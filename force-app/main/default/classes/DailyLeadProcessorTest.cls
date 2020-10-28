@isTest
public class DailyLeadProcessorTest {
    
    static testmethod void test1(){
     String CRON_EXP = '0 0 0 15 3 ? 2022';
    List<Lead> Leadlist=new List<Lead>();
  
       for (Integer i = 0; i < 200; i++) {
            Leadlist.add(new lead(
               Lastname='Dream force'+i,
               Company='C'+i
            ));
        }
        insert Leadlist;
       Test.startTest();
       DailyLeadProcessor ab = new DailyLeadProcessor();

        String jobId = System.schedule('ScheduledApexTest',
            CRON_EXP,ab);    
        Test.stopTest();
     }
}