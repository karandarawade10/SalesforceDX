public class NamedCredentialPOC {

    public static void testAPI(){
        HttpRequest req = new HttpRequest(); 
       
        /*req.setEndpoint('https://login.microsoftonline.com/5d2d3f03-286e-4643-8f5b-10565608e5f8/oauth2/token');
        req.setBody('grant_type=client_credentials' +
                    '&client_id=0afbfb76-cf68-4d4e-b6ea-5a118c1a95c0' +
                    '&client_secret=?8azKW/g:4SQUrVbQ]GXmQ7ZvALpuQS8');
        req.setHeader('Content-Type','application/x-www-form-urlencoded');*/
        req.setEndpoint('callout:azuretest/5d2d3f03-286e-4643-8f5b-10565608e5f8/oauth2/token');
        req.setMethod('POST');
        req.setBody('grant_type=client_credentials' +
                    '&client_id=0afbfb76-cf68-4d4e-b6ea-5a118c1a95c0' +
                    '&client_secret=?8azKW/g:4SQUrVbQ]GXmQ7ZvALpuQS8');
        req.setHeader('Content-Type','application/x-www-form-urlencoded');
        
        Http http = new Http();
        HTTPResponse res;
        res = http.send(req);
        
        system.debug('res=>'+res.getBody());
        }
}