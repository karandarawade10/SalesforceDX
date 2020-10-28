public class SOAPtestHeader {
    
    public static void soapAPI(){
        // try{
        String user='Paymetric\\WSAKohlerQA';
        String pass='password8*';
        
        /* // Convert to BLOB
        Blob targetBlob = Blob.valueOf(pass);
        // Generate SHA1 digest
        Blob hashSHA1 = Crypto.generateDigest('SHA1', targetBlob);
        // For Rackspace Compatiblity encode the binary into BASE 64
        // this will result in 28 chars long string 
        String hashBase64SHA1 = EncodingUtil.base64encode (hashSHA1); 
        // should print :  "46VIwd66mOFGG8IkbgnLlXnfnkU="
        System.debug (hashBase64SHA1);*/
        
        //String body='<wsse:Username>'+user+'</wsse:Username><wsse:Password>'+pass+'</wsse:Password>';
        
        patmetric.IPackets respone=new  patmetric.IPackets();
        paymetric30.XiPayWSSoap pay=new paymetric30.XiPayWSSoap(); 
        
        pay.inputHttpHeaders_x =new Map<String,String>();
        pay.inputHttpHeaders_x.put('Content-Type','text/xml');
        pay.inputHttpHeaders_x.put('Accept','text/xml');
        pay.inputHttpHeaders_x.put('SOAPAction','Paymetric/XiPaySoap30/action/XiGGE.SoapOp');

        
        SFMC_SOAP_TO_SF_SECURITY.SecurityHeaderType head=new SFMC_SOAP_TO_SF_SECURITY.SecurityHeaderType(user,pass);
        pay.Security=head;
        
        
        /*Security.Password passd=new Security.Password('pass','password8*');
        Security.UsernameToken token=new Security.UsernameToken(user,passd);
        Security.Securityheader userToken=new  Security.Securityheader(token);
        pay.Security=userToken;*/
        
        respone=pay.SoapOp(getPaymatricData());
        system.debug('respone=>'+respone);
        
    }
    
    // request data for SoapOp method
    public static patmetric.IPackets getPaymatricData(){
        
        patmetric.IPackets packetdata=new patmetric.IPackets();
        patmetric.ArrayOfITransactionHeader packets=new  patmetric.ArrayOfITransactionHeader();
        List<patmetric.ITransactionHeader> ITransactionHeader=new List<patmetric.ITransactionHeader>();
        patmetric.ITransactionHeader transHeader=new patmetric.ITransactionHeader();
        
        patmetric.ArrayOfInfoItem InfoItems=new patmetric.ArrayOfInfoItem();
        List<patmetric.InfoItem> InfoItem=new List<patmetric.InfoItem>();
        patmetric.InfoItem InfoItemData=new patmetric.InfoItem();
        
        //packet data
        packetdata.count=1;
        packetdata.xipayvbresult=false;
        
        //transaction data
        transHeader.Amount=String.valueOf(100.00);
        transHeader.CardExpirationDate='3/21';
        transHeader.CardHolderName='todd test2';
        transHeader.CardNumber='4112344112344113';
        transHeader.CardType='VISA';
        transHeader.PacketOperation=1;
        transHeader.MerchantID='MIRA_GBP';
        transHeader.CurrencyKey='GBP';
        transHeader.CardCVV2='123';
        transHeader.CardHolderAddress1='100 main street';
        transHeader.CardHolderCity='Houston';
        transHeader.CardHolderCountry='GB';
        transHeader.CardHolderState='GL';
        transHeader.CardHolderZip='GL1 81A';
        
        InfoItemData.Key='TR_TRANS_TYPE';
        InfoItemData.Value='7';
        
        InfoItem.add(InfoItemData);
        InfoItems.InfoItem=InfoItem;
        
        transHeader.InfoItems=InfoItems;
        
        ITransactionHeader.add(transHeader);
        packets.ITransactionHeader=ITransactionHeader;
        packetdata.packets=packets;
           
        system.debug('packet data1=>'+packetdata);
        system.debug('packet data=>'+JSON.serialize(packetdata));
        return packetdata;
    }
}