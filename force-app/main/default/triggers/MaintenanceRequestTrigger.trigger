trigger MaintenanceRequestTrigger on Case (after update) {

    system.debug('Inside trigger maintainance');
    MaintenanceRequestHelperApexClass.updateWorkOrders(Trigger.New);
}