public class TrackingController {
    Public ServiceAppointment saID;
    public TrackingController(ApexPages.StandardController stdController){
         system.debug('Inside Vf page'+saID.id);
        saID=(ServiceAppointment)stdController.getRecord();
    }

    public void updateInfo(){
        system.debug('Inside Vf page'+saID.id);
        For(ServiceAppointment sa:[select id,Subject from ServiceAppointment where id=:saID.id]){
           sa.Subject='Vf Pgafe load work';
              update sa;
        }
    }
}