public with sharing class ContinuationController {
    // Unique label corresponding to the continuation request
    public String requestLabel;
    // Result of callout
    public String result {get;set;}
    // Endpoint of long-running service
    private static final String LONG_RUNNING_SERVICE_URL = 
        '<Insert your service URL>';
   
   // Action method
    public Object startRequest() {
      // Create continuation with a timeout
      Continuation con = new Continuation(40);
      // Set callback method
      con.continuationMethod='processResponse';
      
      // Create callout request
      HttpRequest req = new HttpRequest();
      req.setMethod('GET');
      req.setEndpoint(LONG_RUNNING_SERVICE_URL);
      
      // Add callout request to continuation
       con.addHttpRequest(req);
      
      // Return the continuation
      return con;  
    }
    
    // Callback method 
    public Object processResponse(List<String> label,Object State) {   
      // Get the response by using the unique label
      HttpResponse response = Continuation.getResponse(label[0]);
      // Set the result variable that is displayed on the Visualforce page
      this.result = response.getBody();
      
      // Return null to re-render the original Visualforce page
      return null;
    }
}