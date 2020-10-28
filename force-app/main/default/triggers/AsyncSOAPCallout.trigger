trigger AsyncSOAPCallout on Account (before update) {
  List<Id> accId=new List<ID>();  
    For(Account a:Trigger.New){
       Account oldmap=Trigger.oldMap.get(a.ID);
        if(a.Rating!= oldmap.Rating && a.Rating=='Hot'){
            accId.add(a.id);
        }
    }
    if(!system.isFuture()){
    AsyncSOAPCalloutClass.getcalculator(accId);
    }
     
}