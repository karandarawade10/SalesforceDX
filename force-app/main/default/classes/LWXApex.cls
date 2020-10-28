public with sharing class LWXApex {

    @AuraEnabled(cacheable=true)
    public static List<Contact> getAllContacts(String name){

        List<Contact> conList=[select Id, Name, Title, Phone, Email from Contact  where name=:name limit 10]; 
        system.debug('conList'+conList);
        return conList;
    }
}