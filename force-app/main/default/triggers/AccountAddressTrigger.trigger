trigger AccountAddressTrigger on Account (before Insert,before Update) {
   
   system.debug('Inside accountTrigger');
   
}