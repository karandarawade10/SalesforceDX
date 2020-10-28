@isTest
public class XMLReaderBatchTest {
  	@isTest
    public static void batchTestMethod(){
        Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
        User u = new User(Alias = 'kDara1', Email='standarduser@testorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='Asia/Kolkata', UserName='standar1230duser@testorg.com');
        
        insert u;
        
        String xmlString='<?xml version="1.0" encoding="UTF-8"?>'+'<ZDEBMASEXT><IDOC><E1KNA1M SEGMENT="1"><KUNNR>0040024976</KUNNR><BBBNR>0000000</BBBNR><BBSNR>00000</BBSNR><BEGRU>3020</BEGRU><BUBKZ>0</BUBKZ><KTOKD>Z002</KTOKD><LAND1>US</LAND1><NAME1>COFFEEVILLE RESOURCES REFINING &#38; MK</NAME1><NAME2>ATTN: ACCOUNTS PAYABLE</NAME2><ORT01>KANSAS CITY</ORT01><ORT02>JACKSON</ORT02><PSTLZ>64141-0420</PSTLZ><REGIO>MO</REGIO><SORTL>6732</SORTL><SPRAS>E</SPRAS><STRAS>PO BOX 410420</STRAS><TELF1>913-982-0486</TELF1><LZONE>ZZS0000000</LZONE><UMJAH>0000</UMJAH><JMZAH>000000</JMZAH><JMJAH>0000</JMJAH><UMSA1>0.00</UMSA1><TXJCD>2609506900</TXJCD><HZUOR>00</HZUOR><CIVVE>X</CIVVE><EXTID>2200</EXTID><E1KNVVM SEGMENT="1"><VKORG>Z30S</VKORG><KDGRP>UK</KDGRP><ZTERM>US03</ZTERM><KVGR4>Z01</KVGR4></E1KNVVM></E1KNA1M></IDOC></ZDEBMASEXT>';             
          
        Blob b=Blob.valueOf(xmlString);
        
        ContentVersion cv=new ContentVersion();
        cv.Description='New';
        cv.VersionData=b;
        cv.Title='IDOCFile';
        cv.PathOnClient='/Test.xml';
        insert cv;
        
        
        Test.startTest();
         XMLReaderBatch xbatch=new XMLReaderBatch();
         database.executeBatch(xbatch, 1);
        Test.stopTest();
          
        
    }
}