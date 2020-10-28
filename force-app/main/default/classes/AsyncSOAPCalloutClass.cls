public class AsyncSOAPCalloutClass {
    
   @future(callout=true)
    public static void getcalculator(List<Id> accIds){
        
        List<Account> accList=new List<Account>();
        accList=[select id,Sic from Account where id in:accIds];
        system.debug('Account List'+accList);
        
        For(Account a: accList){
            Double d=10.0;
            Double d1=2.0;
            
            /*calculatorServices.CalculatorImplPort asyc=new calculatorServices.CalculatorImplPort();
            Double  res= asyc.doDivide(d,d1);
            system.debug('response11'+res);
            String out=String.valueOf(res);
            system.debug('response12'+out);
            Account ac=new Account(id=a.id);
            ac.Sic=out;
            update ac;*/
             // wwwSiebelComAsiCreatemtkt main=  wwwSiebelComAsiCreatemtkt
            wwwSiebelComAsiCreatemtkt.CreateMTicketSvc t=new wwwSiebelComAsiCreatemtkt.CreateMTicketSvc();
    
           wwwSiebelComAsiCreatemtkt.CreateMTkt_Output_element response=new wwwSiebelComAsiCreatemtkt.CreateMTkt_Output_element();
            
            response= t.CreateMTkt('MAHARASHTRA','','INDIA','Balewadi','','PUNE','','4545451','Test Acc','','John','Mike','','','','','411045','','8787995');
            
            system.debug('Output'+response);
            
        }
        
    }

}