namespace AdbMapController;

internal enum EquipmentSwitchConfirmationAction
{
    Wait,
    RetryTap,
    Completed
}

internal readonly record struct EquipmentSwitchConfirmationDecision(
    EquipmentSwitchConfirmationAction Action,
    int MissingChecks);

internal static class EquipmentSwitchConfirmationPolicy
{
    const int RequiredMissingChecks = 2;

    public static EquipmentSwitchConfirmationDecision Decide(
        bool confirmationVisible,
        int missingChecks)
    {
        if (confirmationVisible)
            return new(EquipmentSwitchConfirmationAction.RetryTap, 0);

        missingChecks++;
        return missingChecks >= RequiredMissingChecks
            ? new(EquipmentSwitchConfirmationAction.Completed, missingChecks)
            : new(EquipmentSwitchConfirmationAction.Wait, missingChecks);
    }
}
