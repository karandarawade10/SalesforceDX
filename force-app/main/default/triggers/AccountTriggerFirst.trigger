trigger AccountTriggerFirst on Account (after update) {

    for(Account a : Trigger.new){
       testFuture.testBatchFuture(a.id);
    }
    
}