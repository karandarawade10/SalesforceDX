public class SOAPTestClass {
    
    public static void soapAPI(){
        paymetricXipaysoap30Message.IPackets respone=new  paymetricXipaysoap30Message.IPackets();
        paymetricXipaysoap30.XiPayWSSoap pay=new paymetricXipaysoap30.XiPayWSSoap();
       
        // SOAP webservice method from paymetricXipaysoap30.XiPayWSSoap
        respone=pay.SoapOp(getPaymatricData());
        system.debug('respone=>'+respone);
    }
    
    // request data for SoapOp method
    public static paymetricXipaysoap30Message.IPackets getPaymatricData(){
        
        paymetricXipaysoap30Message.IPackets packetdata=new paymetricXipaysoap30Message.IPackets();
        paymetricXipaysoap30Message.ArrayOfITransactionHeader packets=new  paymetricXipaysoap30Message.ArrayOfITransactionHeader();
        List<paymetricXipaysoap30Message.ITransactionHeader> ITransactionHeader=new List<paymetricXipaysoap30Message.ITransactionHeader>();
        paymetricXipaysoap30Message.ITransactionHeader transHeader=new paymetricXipaysoap30Message.ITransactionHeader();
        
        paymetricXipaysoap30Message.ArrayOfInfoItem InfoItems=new paymetricXipaysoap30Message.ArrayOfInfoItem();
        List<paymetricXipaysoap30Message.InfoItem> InfoItem=new List<paymetricXipaysoap30Message.InfoItem>();
        paymetricXipaysoap30Message.InfoItem InfoItemData=new paymetricXipaysoap30Message.InfoItem();
        
        // packet data
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