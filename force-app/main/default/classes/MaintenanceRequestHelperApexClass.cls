public class MaintenanceRequestHelperApexClass {

    public static void updateWorkOrders(List<case> ClosedCaseList){
    system.debug('List of closed1'+ClosedCaseList);
      Set<Id> caseIds=new Set<Id>();
        
        For(Case c:ClosedCaseList){ caseIds.add(c.id); system.debug('ids'+c);}
        system.debug('Case IDS ==>'+caseIds);
        
      List<Case> closedList=new List<Case>([SELECT Id, subject, Vehicle__c, vehicle__r.Name, equipment__c, type FROM Case WHERE status = 'Closed' and id in:caseIds]);  
      
        system.debug('List of closed'+closedList);
      List<Case> typeList=new List<Case>();
        For(Case c:closedList) {
            if(c.type=='Repair' || c.type=='Routine Maintenance'){
                typeList.add(c);
            }
        } 
        
        if(typeList.size()>0){
            system.debug('Inside repaire list');
            createWorkOrders(typeList);
        }
           
    }
    
    public static void createWorkOrders(List<case> ClosedCaseList){
        
        List<Case> insertCaseList=new List<Case>();
        
        For(Case c:ClosedCaseList){
            Case newCase = new Case();
                newCase.Type = 'Routine Maintenance';
                newCase.Status = 'New';
                newCase.Vehicle__c = c.Vehicle__c;
                newCase.Subject =  c.Subject;
                newCase.Date_Reported__c = Date.today();
                newCase.Date_Due__c = Date.today();
                newCase.Equipment__c = c.Equipment__c;
                insertCaseList.add(newCase);
        }
        
        if(insertCaseList.size()>0){
            system.debug('Inside update list');
            insert insertCaseList;
        }
      
    }
}