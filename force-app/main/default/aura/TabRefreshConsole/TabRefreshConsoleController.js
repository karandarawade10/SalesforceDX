({
    onTabRefreshed : function(component, event, helper) {
        console.log("Tab Refreshed");
        var refreshedTabId = event.getParam("tabId");
        console.log("tabId"+refreshedTabId);
        var cnt=component.get("v.count");
        console.log("cnt"+cnt);
        var workspaceAPI = component.find("workspace");
        workspaceAPI.getTabInfo({
            tabId : refreshedTabId
        }).then(function(response) {
            console.log("refreshed tab"+refreshedTabId);    
        });
    },
    
    refreshFocusedTab : function(component, event, helper) {
        var workspaceAPI = component.find("workspace");
        workspaceAPI.getFocusedTabInfo().then(function(response) {
            var focusedTabId = response.tabId;
            console.log("tab focus");
        })
        .catch(function(error) {
            console.log(error);
        });
    }

})