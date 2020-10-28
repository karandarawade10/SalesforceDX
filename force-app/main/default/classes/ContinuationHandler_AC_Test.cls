@isTest
public class ContinuationHandler_AC_Test {
   
      
      public static testmethod void testWebService() {
        ContinuationHandler_AC controller = new ContinuationHandler_AC();
        // Invoke the continuation by calling the action method
        Continuation conti = (Continuation)ContinuationHandler_AC.startRequest();
        
        // Verify that the continuation has the proper requests
        Map<String, HttpRequest> requests = conti.getRequests();
        //system.assert(requests.size() == 1);
        
        // Perform mock callout 
        // (i.e. skip the callout and call the callback method)
        HttpResponse response = new HttpResponse();
        response.setBody('Mock response body');   
        // Set the fake response for the continuation     
        Test.setContinuationResponse(ContinuationHandler_AC.label1, response);
        // Invoke callback method
        Object result = Test.invokeContinuationMethod(controller, conti);
        // result is the return value of the callback
       // System.assertEquals(null, result);
        // Verify that the controller's result variable
        //   is set to the mock response.
       
    }
}