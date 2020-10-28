public class ContinuationHandler_AC {
    private static final String LONG_RUNNING_SERVICE_URL_1 ='https://getprice.free.beeceptor.com/favicon.ico';
   
    
    public static CalloutWrapper.ResponseWrapper ResponseWrapperIns{get;set;}
    
    public static String label1='';
    public static String state1='';
    
    @AuraEnabled(continuation=true cacheable=true)
    public static Object startRequest() {
        
         system.debug('inside continuation');
        Continuation con = new Continuation(40);
        con.continuationMethod='processResponse';
        con.state='Continuation State';
        
       
        
        HttpRequest req1 = new HttpRequest();
        req1.setMethod('GET');
        req1.setEndpoint(LONG_RUNNING_SERVICE_URL_1);
        con.addHttpRequest(req1);
        
       
        return con;
    }
  
    
    
    @AuraEnabled
    public static Object processResponse() {
        system.debug('inside continuation2');
        CalloutWrapper.ResponseWrapper ResponseWrapperIns = new CalloutWrapper.ResponseWrapper();
        HttpResponse response1 = Continuation.getResponse('Continuation-1');
        system.debug('body==>'+response1.getBody());
        system.debug('state1==>'+state1);
        
        return response1.getBody();
    }
}