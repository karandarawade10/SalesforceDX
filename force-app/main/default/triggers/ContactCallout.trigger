trigger ContactCallout on Contact (after insert) {
    
    Set<id> contactId=new Set<id>();
    
    For(Contact c:Trigger.New){
        contactId.add(c.id);
    }  
    
    
    ContactCalloutController.userCreation(contactId);
    
    

}