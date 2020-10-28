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
                    component.set("v.indexv",0);
                    var index = component.get('v.indexv');
                    console.log('index=>'+index);
                    component.set("v.wrapTObj",tList[index]);
                    
                    console.log('datatype=>'+JSON.stringify( component.get("v.wrapTObj")));
                    
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
    
    insertRecordList:function(component, event, helper){
        var action =component.get("c.get_wsf_recordList");
        
        var caNumber=component.get("v.caNumber");
        var listNum=component.get("v.wrapTObj.listNumber");
        var seq=component.get("v.wrapTObj.seq");
        var selectedVal=component.get("v.selectedValue");
        
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
                var wrapTList = component.get('v.wrapTList');
                // console.log("TList lenght"+wrapTList.length);
                var alenght=wrapTList.length-1;
                // console.log("TList lenght 1"+alenght);
                
                component.set("v.selectedValue","");
                
                var indexval=component.get("v.indexv");
                component.set("v.indexv",indexval+1);
                
                var index=indexval+1;
                
                if(alenght===index){
                    component.set("v.nextButton",false);
                    component.set("v.finishtButton",true);
                    component.set("v.wrapTObj",wrapTList[wrapTList.length-1]);
                }else{
                    //component.set("v.indexv",indexval+1); 
                    component.set("v.wrapTObj",wrapTList[index]);
                    //console.log('datatype=>'+JSON.stringify( component.get("v.wrapTObj")));
                }
            }
            else {
                // Show an alert if the state is incomplete or error
                var wrapTList = component.get('v.wrapTList');
                var alenght=wrapTList.length-1;
                var indexval=component.get("v.indexv");
                
                component.set("v.selectedValue","");
                
                component.set("v.indexv",indexval+1);
                var index=indexval+1;
                if(alenght===index){
                    component.set("v.nextButton",false);
                    component.set("v.finishtButton",true);
                    component.set("v.wrapTObj",wrapTList[wrapTList.length-1]);
                }else{
                    //component.set("v.indexv",indexval+1); 
                    component.set("v.wrapTObj",wrapTList[index]);
                }
            }
        });
        // Adding the action variable to the global action queue
        $A.enqueueAction(action);
      /*  var wrapTList = component.get('v.wrapTList');
        // console.log("TList lenght"+wrapTList.length);
        var alenght=wrapTList.length-1;
        // console.log("TList lenght 1"+alenght);
        
        component.set("v.selectedValue","");
        
        var indexval=component.get("v.indexv");
        component.set("v.indexv",indexval+1);
        
        var index=indexval+1;
        
        if(alenght===index){
            component.set("v.nextButton",false);
            component.set("v.finishtButton",true);
            component.set("v.wrapTObj",wrapTList[wrapTList.length-1]);
        }else{
            //component.set("v.indexv",indexval+1); 
            component.set("v.wrapTObj",wrapTList[index]);
            //console.log('datatype=>'+JSON.stringify( component.get("v.wrapTObj")));
        }*/
    }
})