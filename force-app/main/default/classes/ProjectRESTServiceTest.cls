@isTest
private class ProjectRESTServiceTest {
  //Implement Apex REST service tests here
  static testMethod void testData(){
      Opportunity opp = New Opportunity(Name='Test Opp', StageName='Prospecting',CloseDate=System.today());
      insert opp;
      
      String ProjectRef = 'Test';
      String ProjectName ='Test Proj';
      String OpportunityId = String.valueOf(opp.Id);
      Date StartDate = System.today();
      Date EndDate = System.today().addDays(7);
      Double Amount = null;
      String Status='Running';
      
        Project__c prjt = new Project__c();
        prjt.ProjectRef__c = 'ProjectRef';
        prjt.Name = 'ProjectName';
        prjt.Opportunity__c = opp.id;
        prjt.Start_Date__c = Date.today();
        prjt.End_Date__c = (Date.today()).addDays(10);
        prjt.Billable_Amount__c = 1000;
        prjt.Status__c = 'Running';
        
        INSERT prjt;
      
      
      Test.startTest();
      ProjectRESTService.postProjectData(prjt.ProjectRef__c,prjt.Name,prjt.Opportunity__c,prjt.Start_Date__c,prjt.End_Date__c,prjt.Billable_Amount__c,prjt.Status__c);
      Opportunity opportunity = [SELECT Id, DeliveryInstallationStatus__c FROM Opportunity WHERE Id = :OpportunityId];
      //System.assertNotEquals('In progress',opportunity.DeliveryInstallationStatus__c);
      Test.stopTest();
      
      
  }
}