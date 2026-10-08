param([switch]$CoreOnly, [switch]$Publish)
$ErrorActionPreference = 'Stop'
if ($CoreOnly -and $Publish) { throw 'CoreOnly cannot establish a publish baseline.' }
$projectRoot = [IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..'))
$projectPrefix = $projectRoot.TrimEnd('\') + '\'
$projectXml = [xml](Get-Content -LiteralPath (Join-Path $projectRoot 'AdbMapController.csproj') -Raw -Encoding UTF8)
$applicationName = $projectXml.SelectSingleNode('/Project/PropertyGroup/AssemblyName').InnerText + '.exe'
$cleanupTargets = [Collections.Generic.List[string]]::new()
$exitCode = 0

function Stop-ProjectApplication {
    # Inspect exact name AND delimiter-safe absolute project boundary before stop.
    $running = @(Get-CimInstance Win32_Process | Where-Object {
        $_.Name -eq $applicationName -and $_.ExecutablePath -and
        $_.ExecutablePath.StartsWith($projectPrefix, [StringComparison]::OrdinalIgnoreCase)
    })
    foreach ($item in $running) {
        Write-Host "Stopping project application $($item.ProcessId): $($item.ExecutablePath)"
        Stop-Process -Id $item.ProcessId -Force -ErrorAction Stop
    }
}

function Invoke-TestProject([string]$relativePath) {
    $testProject = Join-Path $projectRoot $relativePath
    $testRoot = Split-Path $testProject
    $results = Join-Path $testRoot ('publish\.verification-' + [Guid]::NewGuid().ToString('N'))
    $cleanupTargets.Add($results)
    & dotnet test $testProject -c Release --logger 'console;verbosity=minimal' --logger 'trx;LogFileName=baseline.trx' --results-directory $results | Out-Host
    $testExit = $LASTEXITCODE
    $trx = Join-Path $results 'baseline.trx'
    if (Test-Path -LiteralPath $trx) {
        [xml]$result = Get-Content -LiteralPath $trx -Raw
        Write-Host "$relativePath : $($result.TestRun.ResultSummary.Counters.OuterXml)"
    } else { Write-Host "$relativePath : no TRX generated (build/runner failed), exit=$testExit" }
    return $testExit
}

try {
    Stop-ProjectApplication
    # Source-linked fallback is always reported separately; it never turns a
    # failed full build green. No production source or device protocol is edited.
    if (-not $CoreOnly) {
        $fullExit = Invoke-TestProject 'tests\AdbMapController.Tests.csproj'
        if ($fullExit -ne 0) { $exitCode = 1 }
    }
    $coreExit = Invoke-TestProject 'tests\baseline\AdbMapController.Baseline.Tests.csproj'
    if ($coreExit -ne 0) { $exitCode = 1 }
    if ($Publish -and $exitCode -eq 0) {
        Stop-ProjectApplication
        & dotnet publish (Join-Path $projectRoot 'AdbMapController.csproj') -c Release
        if ($LASTEXITCODE -ne 0) { $exitCode = 1 }
        else { Write-Host "Published: $(Join-Path (Join-Path $projectRoot 'publish') $applicationName)" }
    }
} finally {
    foreach ($relativePath in @('publish\.build', 'tests\publish\.build', 'tests\baseline\publish\.build')) {
        $cleanupTargets.Add((Join-Path $projectRoot $relativePath))
    }
    foreach ($target in $cleanupTargets) {
        $absolute = [IO.Path]::GetFullPath($target)
        # All deletion targets must be intermediate/results directories inside
        # a project-local publish tree. Never delete publish itself or binaries.
        if (-not $absolute.StartsWith($projectPrefix, [StringComparison]::OrdinalIgnoreCase) -or
            $absolute -notmatch '\\publish\\(\.build|\.verification-[0-9a-f]{32})$') {
            throw "Unsafe cleanup target: $absolute"
        }
        if (Test-Path -LiteralPath $absolute) { Remove-Item -LiteralPath $absolute -Recurse -Force }
    }
}
if ($CoreOnly) { Write-Host 'CORE-ONLY: production build/publish not verified.' }
exit $exitCode
