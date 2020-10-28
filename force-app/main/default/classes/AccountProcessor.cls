public class AccountProcessor {

@future
public static void countContacts(Set<Id> accountIds){

    List<Account> accountList=[select id,Number_of_Contacts__c,(select id from Contacts) from Account where id in:accountIds];
    
        For(Account a:accountList){
            List<Contact> conList=a.Contacts;
            a.Number_of_Contacts__c=conList.size();
        }
        if(accountList.size()>0 && accountList!= null)
         update accountList;
}

}