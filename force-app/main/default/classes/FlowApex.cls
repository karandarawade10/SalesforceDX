public class FlowApex {
 @InvocableMethod
    public static void sendEmail(List<Id> lstId){
        List<String> EmailIds = 'karandarawade10@gmail.com,karandarawade10@yahoo.com'.split(',');
      
         System.debug('Ids'+lstId);     
        PageReference ref = Page.PDF_DEMO;
        Blob b = ref.getContentAsPDF();
        
      
        
        ServiceReport sr=new ServiceReport();
        sr.DocumentBody=b;
        sr.ParentId=lstId[0];
        sr.DocumentName='FSR Report';
        sr.DocumentContentType='application/pdf';
        insert sr;

        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();

        Messaging.EmailFileAttachment efa1 = new Messaging.EmailFileAttachment();
        efa1.setFileName('attachment_WORK.pdf');
        efa1.setBody(b);

        String addresses;
        email.setSubject( 'Check VF From PB' +String.valueOf(DateTime.now()));
        email.setToAddresses( EmailIds  );
        email.setPlainTextBody('Hey there, I am an email Body');
        email.setFileAttachments(new Messaging.EmailFileAttachment[] {efa1});
        Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
    }
}