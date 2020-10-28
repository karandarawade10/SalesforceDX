public class XMLBatchMail {

  public Static void sendMail(MAp<String,String> statusMap){
        Integer totalFilecount=0;
        Integer succcessFileCount=0;
        Integer errorFileCount=0;
        
        if(statusMap!= null){
          
           totalFilecount=statusMap.size();
           For(String fileName:statusMap.keySet()){
           if(statusMap.get(fileName)=='Processed Successfully'){
                  succcessFileCount++;
            }else{
                  errorFileCount++;}
           }
          
          system.debug('Total File==> '+totalFilecount+' Success File==> '+succcessFileCount+' ErrorFile==> '+errorFileCount); 
            
          List<User> userObj;
          User_and_File_Configuration__mdt umat=[select Alias__c from User_and_File_Configuration__mdt];
          if(umat.Alias__c != null){
              userObj=[Select email from User where Alias=:umat.Alias__c limit 1];
          }

        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        List<String> address=new List<String>();
        address.add('karandarawade10@gmail.com');
        
        if(userObj!= null){
        address.add(userObj[0].email);
        }
        message.setToAddresses(address);
        message.setSubject('IDOC File Status');
        
        String finalDomainName=URL.getSalesforceBaseUrl().toExternalForm();
        
        system.debug('domain name'+finalDomainName);

         String body='<html><body><br/><br/>';
            body+='Todays total files proccessed by batch:<strong>'+totalFileCount+'</strong><br/><br/>';
            body+='<table border="1"><tr><th><strong>Success Files Count </strong></th><th><strong>Error Files Count</strong></th></tr>';
             
            for(String fileName:statusMap.keySet()){
                body+='<tr><td>'+succcessFileCount+'</td><td>'+errorFileCount+'</td></tr>';
            }
            
         body+='</table></body></html>';
        
        message.setHtmlBody(body); 
        system.debug('Message Body'+message);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] {message});
       
     } // end of mail 
  }

}