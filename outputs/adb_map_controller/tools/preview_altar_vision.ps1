param(
    [Parameter(Mandatory = $true)][string]$InputImage,
    [Parameter(Mandatory = $true)][string]$OutputImage
)

$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.Drawing

$source = [System.Drawing.Bitmap]::new($InputImage)
$normalized = [System.Drawing.Bitmap]::new($source, [System.Drawing.Size]::new(1004, 565))
$annotated = [System.Drawing.Bitmap]::new($source)
$graphics = [System.Drawing.Graphics]::FromImage($annotated)
$font = [System.Drawing.Font]::new('Microsoft YaHei', 10, [System.Drawing.FontStyle]::Bold)
$bluePen = [System.Drawing.Pen]::new([System.Drawing.Color]::Cyan, 3)
$whitePen = [System.Drawing.Pen]::new([System.Drawing.Color]::Lime, 3)
$skipPen = [System.Drawing.Pen]::new([System.Drawing.Color]::Gray, 1)
$emptyPen = [System.Drawing.Pen]::new([System.Drawing.Color]::Gray, 1)
$emptyPen.DashStyle = [System.Drawing.Drawing2D.DashStyle]::Dash
$xs = @(667, 731, 794, 858, 922)
$ys = @(154, 218, 282, 347)
$results = [System.Collections.Generic.List[object]]::new()

function Test-EmptyCell([System.Drawing.Bitmap]$bitmap, [int]$cx, [int]$cy) {
    $minimum = [int]::MaxValue; $maximum = [int]::MinValue
    for ($dy = -14; $dy -le 14; $dy += 4) {
        for ($dx = -14; $dx -le 14; $dx += 4) {
            $color = $bitmap.GetPixel($cx + $dx, $cy + $dy)
            $value = [int]$color.R + $color.G + $color.B
            $minimum = [Math]::Min($minimum, $value)
            $maximum = [Math]::Max($maximum, $value)
        }
    }
    return ($maximum - $minimum) -lt 22
}

function Get-PlateQuality([System.Drawing.Bitmap]$bitmap, [int]$cx, [int]$cy) {
    $strips = @(
        [System.Drawing.Rectangle]::FromLTRB($cx - 28, $cy - 17, $cx - 23, $cy + 18),
        [System.Drawing.Rectangle]::FromLTRB($cx + 23, $cy - 17, $cx + 28, $cy + 18),
        [System.Drawing.Rectangle]::FromLTRB($cx - 17, $cy - 28, $cx + 18, $cy - 23),
        [System.Drawing.Rectangle]::FromLTRB($cx - 17, $cy + 23, $cx + 18, $cy + 28)
    )
    $blueStrips = 0; $whiteStrips = 0; $blueSide = $false; $whiteSide = $false
    for ($index = 0; $index -lt $strips.Length; $index++) {
        $blue = 0; $white = 0; $strip = $strips[$index]
        for ($py = $strip.Top; $py -lt $strip.Bottom; $py++) {
            for ($px = $strip.Left; $px -lt $strip.Right; $px++) {
                $color = $bitmap.GetPixel($px, $py)
                $saturation = $color.GetSaturation()
                $brightness = $color.GetBrightness()
                $hue = $color.GetHue()
                if ($saturation -ge .12 -and $brightness -ge .20 -and $hue -ge 165 -and $hue -le 255) { $blue++ }
                if ($saturation -le .13 -and $brightness -ge .60) { $white++ }
            }
        }
        if ($blue -ge 12) { $blueStrips++; if ($index -lt 2) { $blueSide = $true } }
        if ($white -ge 12) { $whiteStrips++; if ($index -lt 2) { $whiteSide = $true } }
    }
    if ($blueStrips -ge 2 -and $blueSide) { return '蓝色' }
    if ($whiteStrips -ge 2 -and $whiteSide) { return '白色' }
    return '其他/禁用'
}

try {
    foreach ($row in 0..3) {
        foreach ($column in 0..4) {
            $cx = $xs[$column]; $cy = $ys[$row]
            $quality = if (Test-EmptyCell $normalized $cx $cy) { '空' } else { Get-PlateQuality $normalized $cx $cy }
            $results.Add([pscustomobject]@{ Row = $row + 1; Column = $column + 1; X = $cx; Y = $cy; Quality = $quality })
            $scaleX = $source.Width / 1004.0; $scaleY = $source.Height / 565.0
            $left = [int](($cx - 30) * $scaleX); $top = [int](($cy - 30) * $scaleY)
            $width = [int](60 * $scaleX); $height = [int](60 * $scaleY)
            $pen = switch ($quality) { '蓝色' { $bluePen } '白色' { $whitePen } '空' { $emptyPen } default { $skipPen } }
            $graphics.DrawRectangle($pen, $left, $top, $width, $height)
            $label = "$($row + 1)-$($column + 1) $quality"
            $brush = if ($quality -eq '蓝色') { [System.Drawing.Brushes]::Cyan } elseif ($quality -eq '白色') { [System.Drawing.Brushes]::Lime } else { [System.Drawing.Brushes]::White }
            $graphics.DrawString($label, $font, $brush, $left, [Math]::Max(0, $top - 18))
        }
    }
    $annotated.Save($OutputImage, [System.Drawing.Imaging.ImageFormat]::Png)
    $results | ConvertTo-Json -Depth 3
}
finally {
    $graphics.Dispose(); $font.Dispose(); $bluePen.Dispose(); $whitePen.Dispose(); $skipPen.Dispose(); $emptyPen.Dispose()
    $annotated.Dispose(); $normalized.Dispose(); $source.Dispose()
}
