/*Esta clase corre un proceso todos los dias a la 1 y chequea si hay vacas en parto 
o pre-parto para avisar. Se ejecuta de la siguiente manera: 
System.schedule('Daily', '0 0 1 * * ?', new schedulableClassTest()); */
public class schedulableClassTest implements Schedulable {
   
    public void execute(SchedulableContext ctx) {
    	List<Paricion__c> pariciones = [Select id, Fecha__c, Fecha_en_pre_parto__c, 
                                                Vaca__c from paricion__c];	
        MyUtils.reminderParto_PreParto(pariciones);
    }
    
}