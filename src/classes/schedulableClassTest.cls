public class schedulableClassTest implements Schedulable {
    
    public List<Paricion__c> pariciones = [Select id, Fecha__c, Fecha_en_pre_parto__c, Vaca__c from paricion__c];
     public void execute(SchedulableContext ctx) 
    {
        //System.schedule('Hourly', '0 0 * * * ?', new schedulableClassTest()); 
        //'0 0 1 * * ?' --> to make be daily and make it run at 1AM
        //MyUtils.reminderParto_PreParto(pariciones);
        Contact con = new Contact();
        con.lastname='Schedulable1AM';
            }
   
}