public class ParentController {
    @AuraEnabled
    public static List<String> getIndustry(){
        List<String> options = new List<String>();
        Schema.DescribeFieldResult fieldResult = Account.Industry.getDescribe();
        List<Schema.PicklistEntry> pList = fieldResult.getPicklistValues();
        for (Schema.PicklistEntry p: pList) {
            options.add(p.getLabel());
        }
        return options;
    }
    
    @AuraEnabled
    public static List<ContactWrapper> getContacts(String indType){
     List<ContactWrapper> wrapList=new List<ContactWrapper>();
      
    List<Contact> conList= [Select  id ,name,MailingStreet,Phone,Email  from Contact
          					   where account.Industry=:indType];
        For(Contact c:conList){
            wrapList.add(new ContactWrapper(false,c));
        }
     return wrapList;
    }
    
    public class ContactWrapper{
        @AuraEnabled
        Public Boolean selectedContact;
        @AuraEnabled
        Public Contact con;
        
        public ContactWrapper(Boolean selectedContact,Contact con){
            this.selectedContact=selectedContact;
            this.con=con;
        }
    }
}