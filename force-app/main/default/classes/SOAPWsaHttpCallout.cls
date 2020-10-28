public class SOAPWsaHttpCallout {

   
    @AuraEnabled
    public static List<WrapTlist> get_wsf_checkList(String caNum){
        
       List<WrapTlist> wraplst=new List<WrapTlist>();
      // try{
       
        String body;
           
        body='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:fielddesk4:fielddesk4">';
        body+='<soapenv:Header/>';
        body+= '<soapenv:Body>';
        body+=  '<urn:wsf_checklist>';
        body+=     '<i_userid>source</i_userid>';
        body+=     '<i_passwd>sourcetest</i_passwd>';
        body+=     '<i_domain>USUSD10</i_domain>';
        body+=     '<i_nbr>'+caNum+'</i_nbr>';
        body+=     '<i_line>1</i_line>';
        body+=   '</urn:wsf_checklist>';
        body+= '</soapenv:Body>';
        body+='</soapenv:Envelope>';
        
        system.debug('Body==>'+body);
        
        HTTP h = new HTTP();
        HttpResponse res = new HttpResponse();
        HTTPRequest request = new HTTPRequest();
        request.setEndpoint('https://mdesk.sonendo.com:8443/wsadev/wsa1');
        request.setMethod('POST');
        request.setBody(body);
        
        request.setHeader('Content-Type','text/xml'); 
        request.setHeader('SOAPAction','');
        
        res=h.send(request);
       
        if(res.getStatusCode()==200){   
        
        String jsonContent = XmlParser.xmlToJson(res.getBody());
        
        system.debug('json data:'+jsonContent);
         
         SOAPRes e=(SOAPRes)Json.deserialize(jsonContent,SOAPRes.class);
          
            
            if(e.Envelope.Body!=null){  
                system.debug('deserialize data=>'+e.Envelope.Body.wsf_checklistResponse.ttlist);
                
                
                For(Ttlist tlist:e.Envelope.Body.wsf_checklistResponse.ttlist){
                    WrapTlist wrl=new WrapTlist();
                    wrl.label=tlist.l_label;
                    wrl.value=tlist.l_current_value;
                    wrl.listNumber=tlist.l_list;
                    wrl.seq=tlist.l_seq;
                    wrl.dataType=tlist.l_data_type;
                    if(tlist.l_possible_Values!=null){
                        wrl.possibleValues=getListFromCommaString(tlist.l_possible_Values);
                    }
                    wraplst.add(wrl);
                }
                
                System.debug('wraplst=>'+wraplst);
            }else{
                WrapTlist wrl=new WrapTlist();
                wrl.errorMsg='No result found. Please enter valid CA Number';
                wraplst.add(wrl);
                //return wraplst;                
            }
           return wraplst;
         }else{
             WrapTlist wrl=new WrapTlist();
             wrl.errorMsg='No Result Found';
             wraplst.add(wrl);
             return wraplst;
         }
       /*}catch(Exception e){
           system.debug('Exception:'+e.getMessage());
           WrapTlist wrl=new WrapTlist();
           wrl.errorMsg=e.getMessage();
           wraplst.add(wrl);
           return wraplst;
       }*/
        
    }
    
    
    //@future(callout=true)
    @AuraEnabled
    public static string  get_wsf_recordList(String caNum,String listnum,String seq,String salectedVal){
        
        system.debug('canum=>'+caNum+'listnum=>'+listnum+'seq=>'+seq+'salectedVal=>'+salectedVal);
        
        String body;
        try{  
        body='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:fielddesk4:fielddesk4">';
        body+='<soapenv:Header/>';
        body+= '<soapenv:Body>';
        body+=  ' <urn:wsf_recordlist>';
        body+=     '<i_userid>source</i_userid>';
        body+=     '<i_passwd>sourcetest</i_passwd>';
        body+=     '<i_domain>USUSD10</i_domain>';
        body+=     '<i_nbr>'+caNum+'</i_nbr>';
        body+=     '<i_line>1</i_line>';
        body+=     '<i_list>'+listnum+'</i_list>';
        body+=     '<i_seq>'+seq+'</i_seq>';
        body+=     '<i_value>1</i_value>';
        body+=   '</urn:wsf_recordlist>';
        body+= '</soapenv:Body>';
        body+='</soapenv:Envelope>';
        
        system.debug('Body==>'+body);
        
        HTTP h = new HTTP();
        HttpResponse res = new HttpResponse();
        HTTPRequest request = new HTTPRequest();
        request.setEndpoint('https://mdesk.sonendo.com:8443/wsadev/wsa1');
        request.setMethod('POST');
        request.setBody(body);
        
        request.setHeader('Content-Type','text/xml'); 
        request.setHeader('SOAPAction','');
        
        res=h.send(request);
       
        if(res.getStatusCode()==200){
            String jsonContent = XmlParser.xmlToJson(res.getBody());
            
            system.debug('json data:'+jsonContent);
            
            SOAPRes e=(SOAPRes)Json.deserialize(jsonContent,SOAPRes.class);
                       
            system.debug('status:=>'+e.Envelope.Body.wsf_recordlistResponse.o_status);
            
            return e.Envelope.Body.wsf_recordlistResponse.o_status;
        }else{
            return 'failure';
        }
        }
        catch(Exception e){
            return 'failure';
        }
    }
    
    public class SOAPRes{
        public Envelope Envelope;
    }
    
    public class Envelope {
        public Body Body;
    }
	public class Body {
		public Wsf_checklistResponse wsf_checklistResponse;
        public wsf_recordlistResponse wsf_recordlistResponse;
	}
    public class Wsf_checklistResponse {
		public List<Ttlist> ttlist;
	}
    public class Ttlist {
		public String l_list;
		public String l_seq;
		public String l_label;
		public String l_data_type;
		public String l_possible_Values;
        public String l_current_value;
		public String l_label_1;
	}
    
    public class wsf_recordlistResponse{
        public string o_status;
    }
  
    Public class WrapTlist{
        @AuraEnabled
        public String label {get;set;}
        @AuraEnabled
        public String dataType {get;set;}
        @AuraEnabled
        public string value {get;set;}
      	@AuraEnabled
        public List<string> possibleValues {get;set;}
        @AuraEnabled
        public String listNumber {get;set;}
        @AuraEnabled
        public String seq {get;set;}
        @AuraEnabled
        public String errorMsg {get;set;}
        @AuraEnabled
        public String selectedValue {get;set;}
        
    }
    
    
    public static List<String> getListFromCommaString(String CommaString){
        
        List<String> commaList=new List<String>();
        if(CommaString.contains(',')){
           commaList= CommaString.split(',');
        }else{
            commaList.add(CommaString);
        }
        
        system.debug('Comma List=>'+commaList);
        return commaList;
        
    }
    
}