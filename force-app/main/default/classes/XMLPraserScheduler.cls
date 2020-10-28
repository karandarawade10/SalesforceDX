global  class XMLPraserScheduler implements Schedulable{
    
    public static String crn = '0 0 0 1/1 * ? *';   // batch runs on every day 12 am
    global static String scheduleMe() {
        XMLPraserScheduler SC = new XMLPraserScheduler(); 
        return System.schedule('XML Parser Batch', crn, SC);
    }

    global void execute(SchedulableContext sc) {
        XMLReaderBatch b1 = new XMLReaderBatch();
        Database.executeBatch(b1,5);           
    }
}