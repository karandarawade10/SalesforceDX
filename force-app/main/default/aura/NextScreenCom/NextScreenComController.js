({
    
    getTList: function(component, event, helper) {
        // Helper function - fetchContacts called for interaction with server
        helper.fetchTList(component, event, helper);
    },
    
    next:function(component, event, helper) {
        
         helper.insertRecordList(component, event, helper);
    },
  
      previous:function(component, event, helper) {
          
          var wrapTList = component.get('v.wrapTList');
          console.log("TList lenght"+wrapTList.length);
          var alenght=wrapTList.length-1;
          console.log("TList lenght 1"+alenght);
          var indexval=component.get("v.indexv");
          if(alenght===indexval){
              component.set("v.nextButton",true);
              component.set("v.finishtButton",false);
              component.set("v.indexv",indexval-1);
              component.set("v.wrapTObj",wrapTList[wrapTList.length-2]);
          }else{
              component.set("v.indexv",indexval-1); 
              component.set("v.wrapTObj",wrapTList[indexval-1]);
          }
      },
    
    finish:function(component, event, helper) {
        component.set("v.screen",false); 
        component.set("v.finishMsg",true); 
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