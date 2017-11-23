public class MyUtils {
    
    public List<Paricion__c> pariciones = [Select id, Fecha_en_pre_parto__c, Fecha__c, Vaca__c from paricion__c];
    
    public static void reminderParto_PreParto(List<Paricion__c> pariciones){
        //Go over each 'paricion'
           for (integer i=0; i<pariciones.size(); i++){
                Paricion__c paricion = pariciones.get(i);
                //If 'pre-parto' is in about 7 days, send notification
               Datetime hoy = Date.today();
               System.debug('Fecha de pre-parto:'+ paricion.Fecha_en_pre_parto__c);
               
               //Get cow number
                Vaca__c vaca = [select Nro_de_vaca__c 
                           from Vaca__c
                           where id=:paricion.Vaca__c];
                if(paricion.Fecha_en_pre_parto__c == hoy.addDays(2)){
                    //Create mail
                    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
					String[] toAddresses = new String[] {'victoria.armario@gmail.com'};
                    mail.setToAddresses(toAddresses);
                    mail.setSubject('Secado de vaca');
                    mail.setSenderDisplayName('Tambo Cows');
                    mail.setPlainTextBody('La vaca '+ vaca.Nro_de_Vaca__c + 'entra en pre-parto: ' + paricion.Fecha_en_pre_parto__c);
					Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
              }//endif
                   if(paricion.Fecha__c == hoy.addDays(3)){
                       Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
					String[] toAddresses = new String[] {'victoria.armario@gmail.com'};
                    mail.setToAddresses(toAddresses);
                    mail.setSubject('Parto de vaca');
                    mail.setSenderDisplayName('Tambo Cows');
                    mail.setPlainTextBody('La vaca '+ vaca.Nro_de_Vaca__c+' va a parir en: ' + paricion.Fecha__c);
					Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
                       
                   }//endif
   		 }//endfor   
	}//endmethod
}