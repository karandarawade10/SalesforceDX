({
    onInit : function(component, event, helper) {
        var boat = component.get("v.boat");
        var action = component.get("c.getAll");
        action.setParams({
            "boatId": boat.Id
        });

        action.setCallback(this, function(response) {
            var state = response.getState();
            switch(state) {
                case "SUCCESS":
                    var reviews = response.getReturnValue();
                    component.set("v.boatReviews", reviews);
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