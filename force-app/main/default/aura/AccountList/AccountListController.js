({
    doInit : function(component, event) {
       /* var action = component.get("c.findAll");
        
        action.setCallback(this, function(a) {
            component.set("v.accounts", a.getReturnValue());
            window.setTimeout($A.getCallback(function() {
                var event = $A.get("e.c:AccountsLoaded");
                event.setParams({"accounts": a.getReturnValue()});
                event.fire();
            }), 500);
        });
    $A.enqueueAction(action);*/
    },
    onPicklistChange: function(component, event, helper) {
        console.log('Inside select');
        alert('onchnage');
        var city=event.getSource().get("v.value");
        // get the value of select option
        alert('city'+city);
        
        var action = component.get("c.findAll");
         action.setParams({
            'City':city
        }); 
        
        action.setCallback(this, function(a) {
            component.set("v.accounts", a.getReturnValue());
            alert('result'+a.getReturnValue());
            window.setTimeout($A.getCallback(function() {
                var event = $A.get("e.c:AccountsLoaded");
                event.setParams({"accounts": a.getReturnValue()});
                event.fire();
            }), 500);
        });
    $A.enqueueAction(action);
    }
})