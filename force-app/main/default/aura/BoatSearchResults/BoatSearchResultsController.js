({
    init : function(component, event, helper) {
        helper.onSearch(component, event, helper);
    },

    doSearch : function(component, event, helper) {
        var params = event.getParam('arguments');
        console.log('Inside Boat seach'+params.boatTypeId);
        if (params) {
            component.set("v.boatTypeId", params.boatTypeId);
            helper.onSearch(component, event, helper);
        }
    },

    onBoatSelect : function(component, event, helper) {
        var boatId = event.getParam("boatId");
        component.set("v.selectedBoatId", boatId);
    },

    onBoatSelected : function(component, event, helper) {
    }
})