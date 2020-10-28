({
    doInit : function(component, event, helper) {
        helper.onInit(component, event, helper);
    },

    onUserInfoClick : function(component, event, helper) {
        var userid = event.target.getAttribute("data-userid");
        var redirectEvent = $A.get("e.force:navigateToSObject");
        if (redirectEvent) {
            redirectEvent.setParams({
                "recordId": userid
            });
            redirectEvent.fire();
        }
    }
})