trigger task on Task (after insert) {
     system.debug('After insert');
    
    if(Trigger.isInsert){
        
            List<Task> tsk=[select id,recordType.developerName from Task where recordType.developerName!=null];
            system.debug('tsk=>'+tsk);
   
        
    }
    
}