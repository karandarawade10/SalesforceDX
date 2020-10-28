public class testEncyption {

    public static void getEncryption(){
        Encryption__c e=[select id,client_Id__c from Encryption__c where id='a1t6F00000FK5M0QAL'];
        String s=e.client_Id__c;
        system.debug('e=>'+s);
    }
   
}