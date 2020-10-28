public class BatchRunController {
        public boolean batchProcessed;
        public String status{get;set;}
        
        public BatchRunController(){
            status='InProgress';
            batchProcessed = false;    
        }
        public String getMessage(){
            if(batchProcessed){
                Double itemsProcessed;
                Double totalItems ;
                for(AsyncApexJob a : [select TotalJobItems, Status, NumberOfErrors, MethodName, JobType, JobItemsProcessed, Id, 
CreatedDate, CreatedById, CompletedDate, ApexClassId, ApexClass.Name From AsyncApexJob where ApexClass.Name = 'XMLReaderBatch' order by CreatedDate desc limit 1]){
                    itemsProcessed = a.JobItemsProcessed;
                    totalItems = a.TotalJobItems;
                }
                //Determine the percent complete based on the number of batches complete and set message
                if(totalItems == 0){
                    System.debug('Total Job Items'+totalItems);
                    //A little check here as we don't want to divide by 0.
                    return 'Batch Job 0% Complete';
                }else{
                    Integer finalValue=((itemsProcessed  / totalItems) * 100.0).intValue();
                    system.debug('Batch percenteg'+finalValue +' batchProcessed'+ batchProcessed);
                    if(finalValue==100){system.debug('Inside Batch Process'+finalValue);  status='complete';}
                    return 'Batch Job ' + String.valueof(((itemsProcessed  / totalItems) * 100.0).intValue())+'% Complete.';
                }

            } else {
                return 'Batch Job not yet executed !!';
            }
        }

        public PageReference process() {
            XMLReaderBatch batch = new XMLReaderBatch();
            Database.executeBatch(batch,1);
            batchProcessed = true;
            return null;
        }

    }