public class schedulableClassTest implements Schedulable {
    
     public void execute(SchedulableContext ctx) 
    {
        //System.schedule('Hourly', '0 0 * * * ?', new schedulableClassTest()); 
        /*Contact con = new Contact();
        con.lastname = 'Scheduled';
        insert con;*/
        
        List<Paricion__c> pariciones = [Select id from paricion__c];
            
            for (integer i=0; i<pariciones.size(); i++){
                Paricion__c paricion = pariciones.get(i);
                //Si la fecha de pre-parto es en 7 dias, avisar.
                Datetime hoy = Date.today();
                if(paricion.Fecha_en_pre_parto__c == hoy.addDays(7)){
                    //mando mail
                }
            }
    }

}