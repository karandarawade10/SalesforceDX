global class DailyLeadProcessor implements Schedulable {
    global void execute(SchedulableContext ctx) {
        List<Lead> leadList=[select id,LeadSource from Lead where LeadSource=NULL limit 200];
        
        if(leadList.size()>0 && leadList!= null){
        For(Lead l:leadList){
            l.LeadSource='Dreamforce';	
        }
         update leadList;
       }
    }
}