public  with sharing class SecurityController{
    public Id Current_Acc_Id {get;set;}

    public SecurityController(ApexPages.StandardController controller) {
       // Case caseObject = (Case)controller.getRecord();
       // Current_Acc_Id = caseObject.AccountId;
    }

    public List<Account> getrelatedCases(){
        List <Account> conList = new List<Account>();
        for(Account relatedCase: [SELECT id, name,Authorization_Group__c FROM Account]){
            conList.add(relatedCase); 
        }
        return conList;
    }
}