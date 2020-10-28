trigger ContactTrigger on Contact (after insert,after update,after delete,after undelete) {
    
    Set<Id> accountIds=new Set<Id>();
    
    For(Contact c:Trigger.isdelete? Trigger.old :trigger.new){
        accountIds.add(c.accountId);
    }
    
    List<Account> accList=new List<Account>();  
    For(Account a:[Select id,(Select id from Contacts) from account where id in:accountIds]){
      a.NumberOfEmployees=a.Contacts.size();
      accList.add(a);
    }  
    
    if(!accList.isEmpty()){
        update accList;
    }
    
}