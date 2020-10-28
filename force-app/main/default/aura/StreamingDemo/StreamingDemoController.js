({
    handleMessage : function(component, event, helper) {
        component.set("v.lastMessagePayload", JSON.stringify(event.getParam("payload")));
        $A.get("e.force:refreshView").fire();
        console.log('record Id'+component.get("v.recordId"));
        component.set("v.recid",component.get("v.recordId"));
    },
    doInit: function(component, event, helper) {
        // Set the attribute value. 
        // You could also fire an event here instead.
        component.set("v.setMeOnInit", "controller init magic!");
        console.log('Inside Init');
    }
})