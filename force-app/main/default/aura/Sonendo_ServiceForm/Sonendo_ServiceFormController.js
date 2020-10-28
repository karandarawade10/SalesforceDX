({
    getTList: function(component, event, helper) {
        helper.fetchTList(component, event, helper);
    },
    
    postDataToRecordList:function(component, event, helper) {
        helper.postDataToRecordList(component, event, helper);
    },
    
    submit:function(component, event, helper){
        
        var allValid = component.find('fieldId').reduce(function (validSoFar, inputCmp) {
            inputCmp.showHelpMessageIfInvalid();
            return validSoFar && !inputCmp.get('v.validity').valueMissing;
        }, true);
        if (allValid) {
           // alert('All form entries look valid. Ready to submit!');
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                title : 'Success Message',
                message: 'Thanks For Submitting',
                duration:' 5000',
                key: 'info_alt',
                type: 'success',
                mode: 'pester'
            });
            toastEvent.fire();
            component.set("v.finishMsg",true);
            component.set("v.screen",false);
        } else {
           // alert('Please update the invalid form entries and try again.');
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                title : 'Error Message',
                message:'Please update the invalid form entries and try again.',
                duration:' 5000',
                key: 'info_alt',
                type: 'error',
                mode: 'pester'
            });
            toastEvent.fire();
        }
        
    },
      // function automatic called by aura:waiting event  
    showSpinner: function(component, event, helper) {
        // make Spinner attribute true for displaying loading spinner 
        component.set("v.spinner", true); 
    },
     
    // function automatic called by aura:doneWaiting event 
    hideSpinner : function(component,event,helper){
        // make Spinner attribute to false for hiding loading spinner    
        component.set("v.spinner", false);
    }
})