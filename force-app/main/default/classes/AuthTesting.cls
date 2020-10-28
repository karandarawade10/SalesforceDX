public class AuthTesting {
    
    public  String  getAccessToken(){
        
        AuthProvider ap=[select id,ConsumerKey,ConsumerSecret,TokenUrl from authprovider where developerName='Azure'];
        
        String accessToken;
        HttpRequest req = new HttpRequest(); 
        req.setMethod('POST');
        req.setEndpoint(ap.TokenUrl);
        
        req.setBody('grant_type=client_credentials' +
                    '&client_id=' + EncodingUtil.urlEncode(ap.ConsumerKey, 'UTF-8')+
                    '&client_secret=' +EncodingUtil.urlEncode(ap.ConsumerSecret, 'UTF-8'));
        req.setHeader('Content-Type','application/x-www-form-urlencoded');
        
        Http http = new Http(); 
        HTTPResponse res;
        
        res = http.send(req);
        if(res.getBody()!=null && res.getStatusCode()==200){
            Map<String,Object> resMap= (Map<string,Object>)Json.deserializeUntyped(res.getBody());
            accessToken=String.valueOf(resMap.get('access_token'));
            system.debug('accessToken=>'+accessToken);
        }else{
            accessToken='';
        }
        
        return accessToken;
        
    }
    
    public void getAccountBalance(){ 
        
        AuthProvider muleAuth=[select id,ConsumerKey,ConsumerSecret,TokenUrl from authprovider where developerName='MuleSoft'];
        
        String accessToken=getAccessToken();
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('http://dev-sfdc2-xapi-ws.us-e2.cloudhub.io/accounts/test/balance/test');
        req.setMethod('GET');
        req.setTimeout(120000);
        
        req.setHeader('Accept','application/json');
        req.setHeader('x-correlation-id','asdf1234');
        req.setHeader('client_id',muleAuth.ConsumerKey);
        req.setHeader('client_secret',muleAuth.ConsumerSecret);
        req.setHeader('Authorization','Bearer '+accessToken);
        
        //perform get rqquest to API
        HttpResponse res = h.send(req);
        system.debug('Mulesoft response=>'+res.getBody());
        
    }
    
     public static AuthProvider getClientAuthDetails(){
        AuthProvider auth=new AuthProvider();
        auth=[select id,ConsumerKey,ConsumerSecret,developerName from authprovider where developerName='Azure'];
        system.debug('auth=>'+auth);
        return auth;
    }
    public static AuthProvider getMuleSoftAuthDetails(){
        AuthProvider auth=new AuthProvider();
        auth=[select id,ConsumerKey,ConsumerSecret,developerName from authprovider where developerName='MuleSoft'];
        system.debug('auth=>'+auth);
        return auth;
    }   
}