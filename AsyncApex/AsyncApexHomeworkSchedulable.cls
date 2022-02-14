global class AsyncApexHomeworkSchedulable implements Schedulable{
    
    global void execute(SchedulableContext ctx) {
        AsyncApexHomeworkBatch asyncApexHomeworkBatch = new AsyncApexHomeworkBatch();
        Id batchId = Database.executeBatch(asyncApexHomeworkBatch);
        
        AsyncApexHomeworkBatchIterable asyncApexHomeworkBatchIterable = new AsyncApexHomeworkBatchIterable();
        Id batchIdIterable = Database.executeBatch(asyncApexHomeworkBatchIterable);
    }    

}