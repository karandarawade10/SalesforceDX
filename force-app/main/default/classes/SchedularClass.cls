global class SchedularClass implements Schedulable {
    
    private String sessionId;

    global SchedularClass( String sessionId ) {
        this.sessionId = sessionId;
    }

    global void execute(SchedulableContext sc) {

        system.debug('Session id '+sessionId);
    }

}