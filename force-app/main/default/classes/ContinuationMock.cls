public class ContinuationMock {
    private static final String LONG_RUNNING_SERVICE_URL_1 = 'https://getprice.free.beeceptor.com/favicon.ico';
    
    public  string result{get;set;}
    public static String label1='';
    public  static String state1='';
    
  //  @AuraEnabled(continuation=true cacheable=true)
    public  Object startRequest() {
		state1='0066F0000159ahx';
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
    
    public  Object processResponse() {
        system.debug('inside continuation2');
       
        CalloutWrapper.ResponseWrapper ResponseWrapperIns = new CalloutWrapper.ResponseWrapper();
        
        HttpResponse response1 = Continuation.getResponse('Continuation-1');
        system.debug('body==>'+response1.getBody());
        system.debug('body==>'+ContinuationMock.state1);
      //  Map<String,System.HttpRequest>=Continuation.getRequests();
       
        Opportunity o=new Opportunity(id='0066F0000159ahx');
        o.Amount=123;
        update o;
        return response1.getBody();
    }
}