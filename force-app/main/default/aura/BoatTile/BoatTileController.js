({
    onBoatClick : function(component, event, helper) {
        var boat = component.get("v.boat");
        if (boat && boat.Id) {
            var boatselect = component.getEvent("boatselect");
            boatselect.setParams({"boatId": boat.Id});
            boatselect.fire();

            var boatselected = $A.get("e.c:BoatSelected");
            boatselected.setParams({"boat": boat});
            boatselected.fire();

            var plotMapMarker = $A.get("e.c:PlotMapMarker");
            plotMapMarker.setParams({
                "sObjectId": boat.Id,
                "lat": boat.Geolocation__c.latitude,
                "long": boat.Geolocation__c.longitude,
                "label": boat.Name
            });
            plotMapMarker.fire();
        }
    }
})