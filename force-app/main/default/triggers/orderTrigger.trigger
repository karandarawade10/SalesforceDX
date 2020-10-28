/**
* @name orderTrigger
* @description
**/
trigger orderTrigger on Order (after update) {
   
    if(Trigger.new != null) {
        //ContinuationHandler_AC com=new ContinuationHandler_AC();
        ContinuationHandler_AC.startRequest();
       // OrderHelper.AfterUpdate(Trigger.new, Trigger.old);
    }
}