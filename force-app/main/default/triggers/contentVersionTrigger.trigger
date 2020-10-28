trigger contentVersionTrigger on ContentVersion (before insert) {
 
  String userID=UserInfo.getUserId();
  
  List<User_and_File_Configuration__mdt> cmt=new List<User_and_File_Configuration__mdt>();
  cmt=[select Alias__c from User_and_File_Configuration__mdt limit 1];
  
  User userData=[select id from User where Alias=:cmt[0].Alias__c limit 1];
  
  if(userData.id==userID){
      for(ContentVersion cv:Trigger.New){
          cv.description='New';
      }
  }
    
}