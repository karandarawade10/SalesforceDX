public class OpportunityController {
    
    public static List<Opportunity> getOpprtunity(){
        
        return [select id,name from Opportunity];
    }

}