public class apiMap {
 /*if we are using api call we will use future callout then trigger will support API Callout*/
 
    @future (callout=true)
    public static void chckMap(string lat, string lon, string conId){
// we will use these lat and lon on api url
        Http h = new Http();
        //28.5810215,77.3152004
        HttpRequest  req = new HttpRequest ();
       // String url ='https://maps.googleapis.com/maps/api/geocode/json?key=AIzaSyDCJfSJhXuKJlffbFfB57yOO_iQK4kAmio&latlng='+lat+','+lon+'&sensor=true';
         String url ='https://maps.googleapis.com/maps/api/geocode/json?latlng='+lat+','+lon+'&sensor=true';

        req.setEndpoint(url);
        req.setMethod('GET');
        HttpResponse res = h.send(req);
       
        if(res.getStatusCode()==200){
            string str= res.getBody().split('"formatted_address" : "')[1].split('",')[0];
            system.debug('Address'+str);
            
// update contact with address from API response
            contact c= new Contact();
            c.id=conId;
            c.address__c=str;
            update c;
         }

// making a log for every API Hit for best practice.
            
          /*  httpRequest__c log1= new httpRequest__c();
            log1.Request__c='MapAPI';
            log1.response__c=str;
            log1.status__c=String.valueOf(res.getStatusCode());
            insert log1;*/
        
    }
    
}