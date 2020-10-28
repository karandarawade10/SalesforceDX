public class restApiClassSalesforceorgTofetchlist{
    
    
    private string cKey='3MVG9ZL0ppGP5UrA4bq6cMNimTwOEF7joVpTCRhVUwH0kv4kLyFKSoQYwaWO7r.fp9VoeW_Zcn3SkgXYwQrzU';
    private string cSecret='43D963F7A245B4F6DB655C1125E823E5D2EFE907BCA629B6E0CFDDB2949BD96A';
    private string uName='karan@infosys.com';
    private string passwd='Xylomanstar@11';
    public static list<resultWrapper> listWrap{get;set;}
    public static list<resultWrapper1> listWrap1{get;set;}
    public String accountId {get;set;}
    public String accId {get;set;}
    string getid='';
    public Boolean errorRes {get;set;}
    public String  photo {get;set;}

    public restApiClassSalesforceorgTofetchlist()
    {
       errorRes=false;
       // getid=apexpages.currentpage().getparameters().get('conlst');
        listWrap=new list<resultWrapper>();
        listWrap1=new list<resultWrapper1>();
        
    }
    
    
    
    public class responseWrapper{
        
        public string id;
        public string access_token;
        public string instance_url;
        
    }
    
    public string getRequestToken()
    {
        string reqBody='grant_type=password&client_id='+cKey+'&client_secret='+cSecret+'&username='+uName+'&password='+passwd;                                    
        
        Http h=new Http();
        HttpRequest req=new HttpRequest();
        req.setBody(reqBody);
        req.setMethod('POST');
        req.setEndpoint('https://login.salesforce.com/services/oauth2/token');
        
        HttpResponse hresp=h.send(req);
        responseWrapper wResp=(responseWrapper) JSON.deserialize(hresp.getBody(),responseWrapper.class);
        
        system.debug('Instance url'+wResp.instance_url);
        system.debug('session id'+wResp.access_token);
        return wResp.access_token;
        
    }
    
    public void  getConList()
    {
       // listWrap=new list<resultWrapper>();
        list<account> accList1=new list<account>();
        String accToken;
        string responseBody;
        string endPoint='https://karan-dev-ed.my.salesforce.com/services/apexrest/getAccountOnExternalIdtofetchList/';
        restApiClassSalesforceorgTofetchlist obj=new restApiClassSalesforceorgTofetchlist();
        accToken=obj.getRequestToken();
        system.debug('access token'+ accToken);
        if(accToken!='')
        {
            Http h1=new Http();
            HttpRequest req1=new HttpRequest();
            req1.setHeader('Authorization','Bearer '+accToken);
            req1.setHeader('Content-Type','application/json');
            //req1.setHeader('Accept','application/json');
            req1.setMethod('GET');
            req1.setEndpoint(endPoint);
            HttpResponse hresp1=h1.send(req1);
            listWrap=(list<resultWrapper>) JSON.deserialize(hresp1.getBody(),list<resultWrapper>.class);
            system.debug('Response'+listWrap);
            system.debug('response body'+hresp1.getBody());
            JSON2Apex des = JSON2Apex.parse(hresp1.getBody());

        }
       // return null;
    }
    
    public PageReference getConList1()
    {
        //errorRes=True;
        getid=apexpages.currentpage().getparameters().get('conlst');
        system.debug('accountID1==>'+accId);
        list<Contact> accList1=new list<Contact>();
        String accToken;
        string responseBody;
        string endPoint='https://karan-dev-ed.my.salesforce.com/services/apexrest/getContactFetchListFromAccount/?accountID='+accId;
        restApiClassSalesforceorgTofetchlist obj=new restApiClassSalesforceorgTofetchlist();
        accToken=obj.getRequestToken();
        system.debug('access token11'+ accToken);
        system.debug('account ID'+accountId);
        if(accToken!='')
        {
            Http h1=new Http();
            HttpRequest req1=new HttpRequest();
            req1.setHeader('Authorization','Bearer '+accToken);
            req1.setHeader('Content-Type','application/json');
            //req1.setHeader('Accept','application/json');
            req1.setMethod('GET');
            req1.setEndpoint(endPoint);
            HttpResponse hresp1=h1.send(req1);
            system.debug('temp result'+hresp1.getBody());
            if(hresp1.getBody() != null){
            listWrap1=(list<resultWrapper1>) JSON.deserialize(hresp1.getBody(),list<resultWrapper1>.class);
            }
            system.debug('Response11'+listWrap1);
            For(resultWrapper1 rw1:listWrap1){
                if(rw1.result != 'success'){
                    system.debug('Inside error');
                    errorRes=True;
                }else{
                    errorRes=False;
                }
                
            }
          //  system.debug('response body11'+hresp1.getBody());
           // JSON2Apex des = JSON2Apex.parse(hresp1.getBody());
            

        }
        return null;
    }
    
    public class resultWrapper{
        
        public string id{get;set;}
        public string name{get;set;}
        
    }
    
     public class resultWrapper1{
        public string result{get;set;}
        public Contact c{get;set;}
        
        
    }
    
  
    public PageReference getPhotoData(){
        String accToken;
        string responseBody;
        string endPoint='https://karan-dev-ed.my.salesforce.com/services/apexrest/getUserPhoto';
        restApiClassSalesforceorgTofetchlist obj=new restApiClassSalesforceorgTofetchlist();
        accToken=obj.getRequestToken();
        system.debug('access token11'+ accToken);
        if(accToken!='')
        {
            Http h1=new Http();
            HttpRequest req1=new HttpRequest();
            req1.setHeader('Authorization','Bearer '+accToken);
            req1.setHeader('Content-Type','application/json');
            //req1.setHeader('Accept','application/json');
            req1.setMethod('GET');
            req1.setEndpoint(endPoint);
            HttpResponse hresp1=h1.send(req1);
            system.debug('temp result'+hresp1.getBody());
            
            photo=hresp1.getBody();
          
        }
          return null;
    }
   
    
}