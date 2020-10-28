({
    fetchTList:function(component, event, helper){
        
        var action =component.get("c.get_wsf_checkList");
        
        var caNumber=component.get("v.caNumber");
        
        console.log("ca Number"+caNumber);
        
        action.setParams({
            caNum: caNumber
        });
        
        // Callback function to get the response
        action.setCallback(this, function(response) {
            // Getting the response state
            var state = response.getState();
            // Check if response state is success
            if(state === 'SUCCESS') {
                // Getting the list of contacts from response and storing in js variable
                var tList = response.getReturnValue();
                
                console.log('error message'+tList[0].errorMsg);
                
                if(tList[0].errorMsg){ 
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        title : 'Error',
                        message:tList[0].errorMsg,
                        duration:'5000',
                        key: 'info_alt',
                        type: 'error',
                        mode: 'pester'
                    });
                    toastEvent.fire();
                }else{
                    // console.log('tList'+JSON.stringify(tList));
                    // Set the list attribute in component with the value returned by function
                    component.set("v.wrapTList",tList);
                    
                    component.set("v.form",false);
                    component.set("v.screen",true);
                }
                // component.set("v.index",0);
            }
            else {
                // Show an alert if the state is incomplete or error
                alert('Error in getting data');
            }
        });
        // Adding the action variable to the global action queue
        $A.enqueueAction(action);
        
    },
    
    postDataToRecordList:function(component, event, helper){
        
        var action =component.get("c.get_wsf_recordList");
        
        var rowIndex = event.getSource().get("v.name");
        console.log("Row No : " + rowIndex); 
        
        var wrapTList = component.get('v.wrapTList');
        
        var wrapObj=wrapTList[rowIndex];
        
        console.log('datatype=>'+JSON.stringify(wrapObj));
        
        var caNumber=component.get("v.caNumber");
        var listNum=wrapObj.listNumber;
        var seq=wrapObj.seq;
        var selectedVal=wrapObj.selectedValue;
        
        console.log("canum=>"+caNumber+"  listNum=>"+listNum+" seq=>"+seq+" selectedVal=>"+selectedVal);
        
        action.setParams({
            caNum: caNumber,
            listnum:listNum,
            seq:seq,
            salectedVal:selectedVal
        });
        
        // Callback function to get the response
        action.setCallback(this, function(response) {
            // Getting the response state
            var state = response.getState();
            // Check if response state is success
            if(state === 'SUCCESS') {
                var res = response.getReturnValue();
                console.log('RecordList Response:'+res);
            }
            else {
               console.log('Error Occured');
            }
        });
        // Adding the action variable to the global action queue
        $A.enqueueAction(action);
    }
})