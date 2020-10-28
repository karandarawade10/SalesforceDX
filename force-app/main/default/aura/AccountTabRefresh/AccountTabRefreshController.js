({
      onTabRefreshed: function(component,event,helper)
    {
        console.log("TabRefreshed7");
        var refreshedTabId= event.getParam("tabId");
        console.log('tab id=>'+refreshedTabId)
        var workspaceAPI= component.find("workspace");
        workspaceAPI.getEnclosingTabId().then(function(tabId) {
            if (refreshedTabId === tabId) {
                console.log('The current tab is the one being focused!');
            }
        })
    },
     onTabFocused : function(component, event, helper) {
         console.log("TabFocused3");
        var focusedTabId = event.getParam('currentTabId');
        var workspaceAPI = component.find("workspace");
        workspaceAPI.getTabInfo({
            tabId : focusedTabId,
            callback : function(error, response){
                console.log(response);
                console.log('tab=>'+focusedTabId);
            }
        });
    }
    
})