({
    onSearch : function(component, event, helper) {
        var boatTypeId = component.get("v.boatTypeId");
        var action = component.get("c.getBoats");
        action.setParams({
            "boatTypeId": boatTypeId
        });
   
        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log('server res=>'+state);
            switch(state) {
                case "SUCCESS":
                    var boats = response.getReturnValue();
                    component.set("v.boats", boats);
                    break;

                case "INCOMPLETE":
                    console.log('Incomplete');
                    break;

                case "ERROR":
                    console.log(response.getError());
                    break;
            }
        });
        $A.enqueueAction(action);
    }
})