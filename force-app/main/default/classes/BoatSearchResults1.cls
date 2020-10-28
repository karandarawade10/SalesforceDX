public class BoatSearchResults1 {
    
    @AuraEnabled
    public static List<BoatType__c> getBoatTypes() {
        return [SELECT Id, Name FROM BoatType__c];
    }

    @AuraEnabled
    public static List<Boat__c> getBoats(String boatTypeId) {
        if (boatTypeId != null && boatTypeId.length() > 0) {
            return [SELECT Id, Name, Description__c, Price__c, Length__c, Contact__r.Name, Contact__r.Email, Contact__r.HomePhone, BoatType__r.Name, Picture__c, Geolocation__c FROM Boat__c WHERE BoatType__c = :boatTypeId];
        }

        return [SELECT Id, Name, Description__c, Price__c, Length__c, Contact__r.Name, Contact__r.Email, Contact__r.HomePhone, BoatType__r.Name, Picture__c, Geolocation__c FROM Boat__c];
    }
}