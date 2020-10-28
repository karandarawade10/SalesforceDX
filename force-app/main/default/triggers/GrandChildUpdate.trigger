trigger GrandChildUpdate on GrandChild__c (after update) {

    try{
        Set<Id> accountIds=new Set<Id>();
        Map<Id,List<GrandChild__c>> mapa=new Map<Id,List<GrandChild__c>>();
        
        List<GrandChild__c> gcList=[select id,Contact__r.AccountId,Description__c from GrandChild__c where id in:Trigger.new];
        
        For(GrandChild__c gc:gcList){
            accountIds.add(gc.Contact__r.AccountId);
            if(!mapa.containsKey(gc.Contact__r.AccountId)){
                mapa.put(gc.Contact__r.AccountId,new List<GrandChild__c>{gc});
            }else{
                mapa.get(gc.Contact__r.AccountId).add(gc);
            }
        }
        
        List<Account> accList=[Select id,GransChildData__c from Account where id in:accountIds];
        List<Account> accToUpdate=new List<Account>();            
        
        For(Account a:accList){
            String toupdate='';
            For(GrandChild__c gc:mapa.get(a.id)){
               toupdate+=gc.Description__c;
            }
            if(a.GransChildData__c==null){
               a.GransChildData__c=toupdate;
            }else{
                 a.GransChildData__c= a.GransChildData__c+toupdate;
            }
           
            accToUpdate.add(a);
        }
        
        if(accToUpdate.size()>0){
            update  accToUpdate;
        }
        
    }catch(Exception e){
        system.debug('Exception'+e.getMessage());
    }
    
}