trigger ClosedOpportunityTrigger on Opportunity (after Insert,After Update) {
    
   /* List<Task> taskList=new List<Task>();
    For(Opportunity op:Trigger.New){
        If(op.StageName=='Closed Won'){
            Task t=new Task();
            t.Subject='Follow Up Test Task';
            t.whatID=op.id;
            taskList.add(t);
        }
    }
    
    
    if(taskList.size()>0 && taskList != null){
             Insert taskList;
        }*/
    
    //ContinuationHandler_AC.startRequest();
   
    // Create event to publish
    List<MyEvent__e> events = new List<MyEvent__e>();
    events.add(new MyEvent__e(Message__c =Trigger.new[0].id));
    
    // Call method to publish events
    List<Database.SaveResult> results = EventBus.publish(events);
    
    // Inspect publishing result for each event
    for (Database.SaveResult sr : results) {
        if (sr.isSuccess()) {
            System.debug('Successfully published event.');
        } else {
            for(Database.Error err : sr.getErrors()) {
                System.debug('Error returned: ' +
                             err.getStatusCode() +
                             err.getMessage());
            }
        }       
    }
    
    }