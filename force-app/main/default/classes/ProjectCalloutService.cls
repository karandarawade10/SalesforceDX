public class ProjectCalloutService {
    //Complete the implementation for business and callout logic
    @InvocableMethod
	public static void postOpportunityToPMS(List<Id> opportunityId){

       Opportunity opp =[SELECT Id,Name,Account.Name,CloseDate,Amount FROM Opportunity WHERE Id = :opportunityId[0]]; 
       
       string serviceToken=ServiceTokens__c.getValues('ProjectServiceToken').Token__c;
        
       String jsonInput = '{\n' +
        	' "opportunityId" : "'+opportunity.Id+'",\n'+
        	' "opportunityName" : "'+opportunity.Name+'",\n'+
        	' "accountName" : "'+opportunity.Account.Name+'",\n'+
        	' "closeDate" : "'+String.ValueOf(opportunity.CloseDate).mid(0,10)+'",\n'+   
            ' "amount" : "'+opportunity.Amount+'"\n}';
        
        system.enqueueJob(new QueueablePMSCall(serviceToken,jsonInput,opp.id));
    }
    
    @future(Callout=true)
    public static void postToPMS(String serviceToken,String jsonInput,Id OppId){
        
             Http http=new Http();
             
             HttpRequest request=new HttpRequest();
             request.setEndpoint('callout:ProjectService'); // Named Creadential
             request.setMethod('POST');
             request.setHeader('token',serviceToken);
             request.setHeader('Content-Type','application/json;charset=UTF-8');
             request.setBody(jsonInput);
             
             HttpResponse res=http.send(request);
             
              Opportunity opp = new Opportunity(Id=OppId);
        	if(res.getStatusCode() != 201){
                opp.StageName = 'Resubmit Project';
                System.debug('Failure: ' + res.getStatusCode() + ' ' + res.getStatus());
            } else {
                opp.StageName = 'Submitted Project';                
                System.debug('Success: ' + res.getStatus());
            }
            update opp;

        
    }

     class QueueablePMSCall implements System.Queueable,Database.AllowsCallouts{
         
         String serviceToken='';
         String jsonInput='';
         String OppId='';
         
         public QueueablePMSCall(String serviceToken,String jsonInput,Id OppId){
             this.serviceToken=serviceToken;
             this.jsonInput=jsonInput;
             this.OppId=OppId;
         }
         public void execute(QueueableContext context){
           
               postToPMS(serviceToken,jsonInput,OppId); 
         }
    }
    
}