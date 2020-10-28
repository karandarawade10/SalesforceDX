({
    doInit: function(component, event, helper) {
         var action = component.get("c.getIndustry");
         action.setCallback(this, function(a) {
             console.log(JSON.stringify( a.getReturnValue()));
             component.set("v.options", a.getReturnValue());
        });
        
        $A.enqueueAction(action); 
    },
    
    handleIndustryChnage: function(component, event, helper) {
        helper.getContacts(component, event);
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
    },
    parentComponentEvent: function(component,event,helper){
        //Get the event message attribute
        var contact = event.getParam("contactWrap"); 
       
        alert("selected Contacts"+JSON.stringify(contact));
    }

})