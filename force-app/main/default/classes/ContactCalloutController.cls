public class ContactCalloutController {
    
    
    @future(callout=true)
    
    public static void userCreation(Set<Id> contatIds){
        
    //    List<Contact> conList=new List<Contact>();
        
        List<Contact> conListUpdate=new List<Contact>();
        
        
      //  conList=[select id,LastName from Contact where id in :contatIds];
        
        for(Contact c:[select id,LastName from Contact where id in :contatIds]){
            
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setEndpoint('https://reqres.in/api/users?name='+c.LastName+'&job=TestJob');
            request.setMethod('POST');
            HttpResponse response = http.send(request); 
            
            system.debug('response'+response); 
            system.debug('response.getBody()=>'+response.getBody());
            
            Wrapper wrap=new Wrapper();
            wrap=(Wrapper)JSON.deserialize(response.getBody(), Wrapper.class);
            
            system.debug('results=='+wrap);
            
            c.UserId__c=(string)wrap.id;
            // c.Description=(string)wrap.id+wrap.createdAt;
            c.Description=(string)response.getBody();
            conListUpdate.add(c);
            
        }
        
        if(conListUpdate!=null){
            update conListUpdate;
        }
        
    }
    
    
    public  class Wrapper{
        public string id;
        public string createdAt;
    }
}