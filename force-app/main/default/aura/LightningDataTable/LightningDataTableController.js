({
    doInit : function(component, event, helper) {	
        console.log('Inside Init');
        helper.getDataHelper(component, event);
    },
    
getSelectedName: function (cmp, event) {
    var selectedRows = event.getParam('selectedRows');
    // Display that fieldName of the selected rows
    for (var i = 0; i < selectedRows.length; i++){
        alert("You selected: " + selectedRows[i].AccountNumber);
    }
},

})