public class acccountdata {
     

	@AuraEnabled
    public static List<Account> getAccountdata(){
        
        return [select id,name from account];
    }
}