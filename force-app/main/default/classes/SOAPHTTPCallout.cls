public class SOAPHTTPCallout {

    @future(callout=true)
    public static void paymatricRPI(){
     
     String user='Paymetric\\WSAKohlerQA';
     String pass='password8*';  
     String url='https://cert-xipayapi.paymetric.com/PMXIGGE/XiPay30WS.asmx';
        
     String body;
        body='<?xml version="1.0" encoding="UTF-8"?>';
        body+='<soapenv:Envelope xmlns:mes="http://Paymetric/XiPaySoap30/message/" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">';
        body+='<soapenv:Header xmlns:wsa="http://www.w3.org/2005/08/addressing">';
        body+='<wsse:Security xmlns:wsse="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd"';
        body+=' xmlns:wsu="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd">';
        body+='<wsse:UsernameToken wsu:Id="UsernameToken-3c52cc57-4ab6-4e3c-9c4e-7aca3088a013">';
		body+='<wsse:Username>'+user+'</wsse:Username>';
        body+='<wsse:Password>'+pass+'</wsse:Password>';
        body+='</wsse:UsernameToken>';
        body+='</wsse:Security>';
        body+='</soapenv:Header>';
        body+='<soapenv:Body>';
        body+='<mes:SoapOp>';
        body+='<mes:pPacketsIn>';
        body+='<mes:count>1</mes:count>';
        body+='<mes:xipayvbresult>false</mes:xipayvbresult>';
        body+='<mes:packets>';
        body+='<mes:ITransactionHeader>';
        body+='<mes:Amount>100.00</mes:Amount>';
        body+='<mes:CardExpirationDate>3/21</mes:CardExpirationDate>';
        body+='<mes:CardHolderName>todd test2</mes:CardHolderName>';
        body+='<mes:CardNumber>4112344112344113</mes:CardNumber>';
        body+='<mes:CardType>VISA</mes:CardType>';
        body+='<mes:PacketOperation>1</mes:PacketOperation>';
        body+='<mes:MerchantID>MIRA_GBP</mes:MerchantID>';
        body+='<mes:CurrencyKey>GBP</mes:CurrencyKey>';
        body+='<mes:CardCVV2>123</mes:CardCVV2>';
        body+='<mes:CardHolderAddress1>100 main street</mes:CardHolderAddress1>';
        body+='<mes:CardHolderCity>Houston</mes:CardHolderCity>';
        body+='<mes:CardHolderCountry>GB</mes:CardHolderCountry>';
        body+='<mes:CardHolderState>GL</mes:CardHolderState>';
        body+='<mes:CardHolderZip>GL1 81A</mes:CardHolderZip>';
        body+='<mes:InfoItems>';
        body+='<mes:InfoItem>';
        body+='<mes:Key>TR_TRANS_TYPE</mes:Key>';
        body+='<mes:Value>7</mes:Value>';
        body+='</mes:InfoItem>';
        body+='</mes:InfoItems>';
        body+='</mes:ITransactionHeader>';
        body+='</mes:packets>';
        body+='</mes:pPacketsIn>';
        body+='</mes:SoapOp>';
        body+='</soapenv:Body>';
        body+='</soapenv:Envelope>';
        
        system.debug('Body==>'+body);
        
        
        HTTP h = new HTTP();
        HttpResponse res = new HttpResponse();
        HTTPRequest request = new HTTPRequest();
        request.setEndpoint(url);
        request.setMethod('POST');
        request.setBody(body);
        
        request.setHeader('Content-Type','text/xml'); 
        request.setHeader('SOAPAction','Paymetric/XiPaySoap30/action/XiGGE.SoapOp');
        
        res=h.send(request);
        
        system.debug('res=>'+res.getBody());
        
        String jsonContent = XmlParser.xmlToJson(res.getBody());
        
        system.debug('json data:'+jsonContent);
        
    }
}