trigger ExecuteOnceTrigger on Account (after update) {
    if (!ExecuteOnceHelper.hasExecuted) {
        System.debug('ExecuteOnceTrigger executed');
        ExecuteOnceHelper.hasExecuted = true;
    }
}