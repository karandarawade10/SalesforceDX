public class XMLParserClass {
    
    // Variable Declaration
    List<Account> accountList;
    Account accountObj;
    List<ErrorObject__c> errorDes;
    List<IDOC_Mapping__mdt> cmt;
    Map<String,String> mapMeta;
    Map<String, Schema.SObjectField> objectFieldMap;
    User_and_File_Configuration__mdt umat;
    Map<String,String> externalIdToParentMap;
    Map<String,String> externalIdToexternalId;
    
    //Constructor
    public XMLParserClass(){
        objectFieldMap = Schema.SObjectType.Account.fields.getMap();
        mapMeta=new Map<String,String>();
        cmt=[select Element_Name__c,FieldAPIName__c from IDOC_Mapping__mdt];
        For(IDOC_Mapping__mdt a:cmt){
            mapMeta.put(a.Element_Name__c,a.FieldAPIName__c);
        } 
        system.debug('Meatadata content'+mapMeta);
        umat=[select Root_Element__c,Shipping_Address_same_as_Billing_Address__c from User_and_File_Configuration__mdt];
        system.debug('Inside metadata'+umat);
    }
    
    //
    Public  void parseContent(String xmlData,String fileName,Map<String,String>statusMap){
        
        externalIdToParentMap=new Map<String,String>();
        externalIdToexternalId=new Map<String,String>();
        accountObj=null;
        accountList=new List<Account>();
        errorDes=new List<ErrorObject__c>();
        System.debug('new data1'+xmlData);
        DOM.Document doc=new DOM.Document();
        try{
            doc.load(xmlData);
            DOM.XmlNode rootNode=doc.getRootElement();
            parseXML(rootNode);
            system.debug('accountObj==>'+accountObj);
            
            accountList.add(accountObj);
            
            //Updating Account Hierarchy
            updateParentID(accountList);
            
            system.debug('Final List ==>>'+accountList);
            
            if(accountList.size()>0){
                system.debug('insert data ==>'+accountList);
                upsert accountList ExternalId__c;
                statusMap.put(fileName,'Processed Successfully');
            }
        }catch(exception e){
            statusMap.put(fileName,e.getMessage());
        }
    }  
    
    public void parseXML(DOM.XMLNode node) {
        system.debug('Inside node type'+DOM.XMLNodeType.ELEMENT+' node name'+node);
        if (node.getNodeType() == DOM.XMLNodeType.ELEMENT) {
            system.debug('root element'+node.getName());
            system.debug('accountObj value'+accountObj);
            if(node.getName().equalsIgnoreCase(umat.Root_Element__c)){
                system.debug('Inside parse'+node.getName());
                system.debug('accountObj value'+accountObj);
                if(accountObj!=null){
                    system.debug('Inside account 1'+accountObj);
                    accountList.add(accountObj);
                    system.debug('Inside list'+accountList);
                }
                accountObj = new Account();
            }
            try{
                system.debug('Inside node.getName().trim() **'+node.getName());
                if(mapMeta.containsKey(node.getName().trim())){
                    
                    system.debug('Inside node.getName().trim() **+'+node.getName());
                    system.debug('Inside node.getText() **+'+node.getText());
                    if(node.getText().trim()!=null){
                        
                        system.debug('Inside Node >>>'); 
                        
                        //getting dataType of field
                        Schema.SObjectField field = objectFieldMap.get(mapMeta.get(node.getName().trim()));
                        Schema.DisplayType objFieldType = field.getDescribe().getType(); 
                        String fieldType=String.valueOf(objFieldType);
                        system.debug('Field Type'+fieldType);         
                        // end of dataTypeCheck
                        
                        // Mapping values to Fields dynamically
                        mappingValueToField(fieldType,node);
                        
                        
                        // Updating ShippingAddress same as billing adress
                        shippingAdressSameAsBilling();
                        
                    }
                }
                System.debug('Account object fields'+accountObj);
            }// end of try    
            catch(Exception e){
                system.debug('Inside exception  99'+e.getMessage());
            }// end of catch
            
            system.debug('Inside Child value'+node.getChildElements());
            
            for (Dom.XMLNode child: node.getChildElements()) {
                System.debug('inside child element'+child);
                parseXML(child);
            }
        }
        
    }
    
    public void updateParentID(List<Account> accountList){
        
        system.debug('Account method pass'+accountList);
        Set<String> externalIDs=new Set<String>();
        For(Account a:accountList){
            externalIDs.add(a.ParentAccountRef__c);
        }
        system.debug('Inside external ==>'+externalIDs);
        
        For(Account parentAcc:[select id,ExternalId__c from Account where ExternalId__c in:externalIDs]){
            externalIdToParentMap.put(parentAcc.ExternalId__c,parentAcc.id);
            externalIdToexternalId.put(parentAcc.ExternalId__c,parentAcc.ExternalId__c);
        }
        
        system.debug('externalIdToParentMap ==>>'+externalIdToParentMap);
        
        For(Account a:accountList){
            
            system.debug('Inside referance'+a.ParentAccountRef__c);
            system.debug('Inside referance123=>'+externalIdToParentMap.get(a.ParentAccountRef__c));
            
            if(externalIdToParentMap.containsKey(a.ParentAccountRef__c)){
                if(a.ParentAccountRef__c == externalIdToexternalId.get(a.ParentAccountRef__c)){
                    system.debug('Inside Match parent ID');
                    a.ParentID=externalIdToParentMap.get(a.ParentAccountRef__c);
                }
            }
        }    
        
    }
    
    public void shippingAdressSameAsBilling(){
        if(umat.Shipping_Address_same_as_Billing_Address__c){
            system.debug('Inside shipping address'+accountObj.get('BillingStreet'));
            accountObj.put('ShippingCountry',accountObj.get('BillingCountry'));
            accountObj.put('ShippingCity',accountObj.get('BillingCity'));
            accountObj.put('ShippingPostalCode',accountObj.get('BillingPostalCode'));
            accountObj.put('ShippingState',accountObj.get('BillingState'));
            accountObj.put('ShippingStreet',accountObj.get('BillingStreet'));
            
        }
    }
    
    public void mappingValueToField(String fieldType,DOM.XMLNode node){
        String mutipleInput='';
        if(fieldType == 'currency' ||fieldType == 'double' ||
           fieldType == 'percent' || fieldType == 'decimal'){
               accountObj.put(mapMeta.get(node.getName().trim()),decimal.valueOf(node.getText().trim()));
           }
        else if(fieldType == 'integer'){
            accountObj.put(mapMeta.get(node.getName().trim()),integer.valueOf(node.getText().trim()));
        } 
        else if (fieldType == 'boolean'){
            accountObj.put(mapMeta.get(node.getName().trim()),Boolean.valueOf(node.getText().trim()));
        }
        else if(fieldType == 'date'){
            accountObj.put(mapMeta.get(node.getName().trim()),date.valueOf(node.getText().trim()));
        }
        else if(fieldType == 'MULTIPICKLIST'){
            system.debug('child element size'+node.getChildElements().size());
            if(node.getChildElements()!=null){
                for(Integer i=0;i<node.getChildElements().size();i++){
                    if(i<node.getChildElements().size()-1){
                        mutipleInput=mutipleInput+node.getChildElements()[i].getText()+';';
                    }else{
                        mutipleInput=mutipleInput+node.getChildElements()[i].getText();  
                    }
                }
            }
            system.debug('Multiple Input '+mutipleInput);
            accountObj.put(mapMeta.get(node.getName().trim()),mutipleInput);
        }
        else{
            accountObj.put(mapMeta.get(node.getName().trim()),node.getText().trim());
        }
    }
    
    public void updateFileStatusandInformation(Map<String,String> statusMap){
         system.debug('Finish Method status'+statusMap);
        
        List<ContentVersion> conVerList=new List<ContentVersion>();
        List<ErrorObject__c> errObjList=new List<ErrorObject__c>();
        
        For(String fileName:statusMap.keySet()){
            ContentVersion conVer=new ContentVersion(id=fileName);
            
            ErrorObject__c errObj=new ErrorObject__c();
            
            if(statusMap.get(fileName)=='Processed Successfully'){
                conVer.description='Processed';
                conVerList.add(conVer);
                
                errObj.FileName__c=fileName;
                errObj.Status__c='Processed Successfully';
                errObj.Error_Description__c='File has been Processed Successfully';
                errObjList.add(errObj);
                
            }else{
                conVer.description=statusMap.get(fileName);
                conVerList.add(conVer);
                
                errObj.FileName__c=fileName;
                errObj.Status__c='Unprocessed';
                errObj.Error_Description__c=statusMap.get(fileName);
                errObjList.add(errObj);
            }
        }
        system.debug('finish err log'+conVerList);
        if(conVerList.size()>0){
            update conVerList;
        }
        
        if(errObjList.size()>0){
            Insert errObjList;
        }
    }
    
    
}