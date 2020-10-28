public class XMLparse{
   
    public string XMLString;
    public List<Account> pro;
    public Account temppro;
    Public Blob body {get;set;}
    public String name  {get;set;}
    Public Address address;
    
    public void readData(){
        List<ErrorObject__c> errorDes=new List<ErrorObject__c>();
        XMLString='';
        pro = new List<Account>();
       // XMLString = '<?xml version="1.0" encoding="UTF-8"?><products><product><name>Xbox</name><code>XBO</code></product><product><name>Playstation</name><code>PS</code></product><product><name>Wii</name></product></products>';
        XMLString=body.toString();
        System.debug('new data1'+XMLString);
        DOM.Document doc=new DOM.Document();
        try{
            doc.load(XMLString);
            DOM.XmlNode rootNode=doc.getRootElement();
            parseXML(rootNode);
            pro.add(temppro);
            saveObject();
        }catch(exception e){
            system.debug(e.getMessage());
            ErrorObject__c err=new ErrorObject__c();
            err.Error_Description__c=e.getMessage();
            errorDes.add(err);
        }

     if(errorDes.size()>0){
         insert errorDes;
     }
       
    }
    
    public XMLparse(){
       
    }
    
    public void saveObject(){
        
        if(pro.size()>0){
         system.debug('insert data ==>'+pro);
         insert pro;
        }
        
    }
    
    
    public void parseXML(DOM.XMLNode node) {
        if (node.getNodeType() == DOM.XMLNodeType.ELEMENT) {
        system.debug(node.getName());
            if(node.getName()=='Account'){
                if(temppro!=null){
                    pro.add(temppro);
                    system.debug('Inside list'+pro);
                }
                temppro = new Account();
            }
            if(node.getName()=='name')
                temppro.name=node.getText().trim();
            if(node.getName()=='AccountNumber')
                temppro.AccountNumber=node.getText().trim();
            if(node.getName()=='NumberOfEmployees')
                temppro.NumberOfEmployees__c=Integer.valueOf(node.getText().trim());
            if(node.getName()=='accountSite')
                temppro.accountSite__c=node.getText().trim();
            if(node.getName()=='billingCity')
                temppro.BillingCity=node.getText().trim();
            if(node.getName()=='billingCountry')
                temppro.BillingCountry = node.getText().trim();
            if(node.getName()=='billingState')
                temppro.BillingState = node.getText().trim();
            if(node.getName()=='billingStreet')
                temppro.BillingStreet = node.getText().trim();
            if(node.getName()=='billingPostalCode')
                temppro.BillingPostalCode =node.getText().trim();
            
            if(node.getName()=='shippingCity')
                temppro.ShippingCity=node.getText().trim();
            if(node.getName()=='shippingCountry')
                temppro.ShippingCountry = node.getText().trim();
            if(node.getName()=='shippingState')
                temppro.ShippingState = node.getText().trim();
            if(node.getName()=='shippingStreet')
                temppro.ShippingStreet = node.getText().trim();
            if(node.getName()=='shippingPostalCode')
                temppro.ShippingPostalCode =node.getText().trim();
            
		
            
        
        for (Dom.XMLNode child: node.getChildElements()) {
            System.debug('Inside Parse'+child);
            parseXML(child);
        }
    }
    
}
   
}