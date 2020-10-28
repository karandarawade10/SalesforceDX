global class XMLReaderBatch implements Database.Batchable<sObject>,Database.Stateful{
    
    global Map<String,String> statusMap;
    
    public XMLReaderBatch(){
        statusMap=new Map<String,String>();
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC){
        String fileType='XML'; 
        String description='New';
        String query='SELECT id,Title,VersionData,description,IsLatest FROM ContentVersion where description=:description and IsLatest=True and FileType=:fileType';
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC,List<ContentVersion> scope){
        XMLParserClass parseClass=new XMLParserClass();
        For(ContentVersion c:scope){
            parseClass.parseContent(c.VersionData.toString(),c.id,statusMap);
        }
        
        // updating file description field and error object 
        parseClass.updateFileStatusandInformation(statusMap);
        
    }
    
    global void finish(Database.BatchableContext BC){
       
        // sending mail with file status information
        XMLBatchMail.sendMail(statusMap);

    }
    

}