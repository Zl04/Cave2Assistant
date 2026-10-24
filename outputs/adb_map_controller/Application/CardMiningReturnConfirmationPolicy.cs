namespace AdbMapController;

internal enum CardMiningReturnConfirmationAction
{
    Wait,
    RetryTap,
    Completed
}

internal static class CardMiningReturnConfirmationPolicy
{
    public static CardMiningReturnConfirmationAction Decide(
        bool returnedToTown,
        bool confirmationStillVisible,
        int completedChecks)
    {
        if (returnedToTown) return CardMiningReturnConfirmationAction.Completed;
        if (confirmationStillVisible) return CardMiningReturnConfirmationAction.RetryTap;
        return CardMiningReturnConfirmationAction.Wait;
    }
}
