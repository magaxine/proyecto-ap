public class MyUtils {
    
    /*Metodo que recorre pariciones y chequea si estamos a 7 dias de una vaca 
	para pre-parto*/
    public static void reminderPreParto(){
         List<Paricion__c> pariciones = [Select id, Fecha_en_pre_parto__c, Vaca__c from paricion__c];
        
        //Recorro las pariciones
           for (integer i=0; i<pariciones.size(); i++){
                Paricion__c paricion = pariciones.get(i);
               
               //Obtengo el nro de vaca
               
               Vaca__c vaca = [select Nro_de_vaca__c
                       				from Vaca__c
                                    where id=:paricion.Vaca__c];
               
                //Si la fecha de pre-parto es en 7 dias, avisar.
                Datetime hoy = Date.today();
               System.debug('Fecha de pre-parto:'+ paricion.Fecha_en_pre_parto__c);
               System.debug('Fecha hoy:'+ hoy);
                if(paricion.Fecha_en_pre_parto__c == hoy.addDays(2)){
                    System.debug('debo mandar mail');
                    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                    
					String[] toAddresses = new String[] {'victoria.armario@gmail.com'};
                    mail.setToAddresses(toAddresses);
                    mail.setSubject('Secado de vaca');
                    mail.setSenderDisplayName('Tambo Cows');
                    mail.setPlainTextBody('La vaca '+vaca.Nro_de_Vaca__c+' entra en pre-parto: ' + paricion.Fecha_en_pre_parto__c );
					Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
					
                    /*
                    Contact con = new Contact();
        			con.lastname = 'El Scheduled';
                    insert con;  */
              }//endif
   		 }//endfor   
	}//endmethod
}