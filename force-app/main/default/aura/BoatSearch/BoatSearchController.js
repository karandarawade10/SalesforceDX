({
    onFormSubmit : function(component, event, helper) {
        var params = event.getParam("formData");
         console.log('Inside main event ->');
        var searchResults = component.find("searchResults");
        if (searchResults) {
            console.log('Inside main event 1 ->'+params.boatTypeId);
            searchResults.search(params.boatTypeId);
        }
    }
})