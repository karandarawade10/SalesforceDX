({
    getaccounts : function(component, event, helper) {
        var action = component.get("c.getAccount");
        action.setParams({ 
            Id : component.get("v.recordId") //Passing parameter
        });
         
        action.setCallback(this,function(response) {
            var state = response.getState();
            if(state === 'SUCCESS') {
                console.log('inside success');
                component.set("v.account", response.getReturnValue());
            }
         });
        
        $A.enqueueAction(action);
    }
})