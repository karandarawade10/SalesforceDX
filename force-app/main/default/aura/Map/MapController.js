({
    jsLoaded: function(component) {
        component.set("v.jsLoaded", true);
    },

    onPlotMapMarker : function(component, event, helper) {
        var location = component.get("v.location");

        location.sObjectId = event.getParam("sObjectId");
        location.lat = event.getParam("lat");
        location.long = event.getParam("long");
        location.label = event.getParam("label");

        component.set("v.location", location);
    }
})