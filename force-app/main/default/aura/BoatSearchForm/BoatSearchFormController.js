({
    init : function(component, event, helper) {
        var createRecordEvent = $A.get("event.force:createRecord");
         console.log('create event'+createRecordEvent);
        if (createRecordEvent) {
            console.log('create event');
            component.set("v.showNewBtn", true);
        }
   
        helper.loadBoatTypes(component, event, helper);
    },

    boatTypeChange : function(component, event, helper) {
        var boatType = event.getSource().get("v.value");
        component.set("v.boatType", boatType);
        
    },

    onFormSubmit : function(component, event, helper) {
        var params = {"formData": {"boatTypeId": component.get("v.boatType")}};

        var formsubmit = component.getEvent("formsubmit");
        formsubmit.setParams(params);
        formsubmit.fire();
        console.log('event fire');
    },

    newBtnClick : function(component, event, helper) {
        var createRecordEvent = $A.get("event.force:createRecord");

        if (createRecordEvent) {
            var params = {"entityApiName": "Boat__c"};

            var boatType = component.get("v.boatType");
            if (boatType) {
                params.defaultFieldValues = {"BoatType__c" : boatType};
            }

            createRecordEvent.setParams(params);
            createRecordEvent.fire();
        }
    }
})