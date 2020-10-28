global class schedulebatch implements schedulable{

   global void execute(Schedulablecontext sc)
          {
             batchExample b=new batchExample();
             //Database.executeBatch(instance,size);
             Database.executeBatch(b,2);
          }

}