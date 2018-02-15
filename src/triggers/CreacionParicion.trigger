/*Este trigger se dispara cuando se marca una inseminacion efectiva.
Se crea un evento 'paricion' relacionado a la vaca y se setean las fechas de parto-pre/parto
de acuerdo a la fecha de inseminacion.*/
trigger CreacionParicion on Inseminacion__c (after update) {
    
    //Debo comparar los old con los new
    for(integer i=0; i<Trigger.New.size();i++){
        Inseminacion__c iOld = Trigger.Old.get(i);
        Inseminacion__c iNew = Trigger.New.get(i);
        	
        //Si no estaba chequeada y ahora esta, se crea el nuevo evento.
        if(!iOld.efectiva__c && iNew.efectiva__c){
            Event e = new Event();
            Inseminacion__c aux = [select fecha__c, Vaca__r.Id
                                 from Inseminacion__c
                                 where id=:iNew.Id];
            Date fechaInseminacion = aux.fecha__c;
            e.StartDateTime = fechaInseminacion.addDays(2); //270
            e.IsAllDayEvent = true;
            
            //Secado de la vaca
            Event e2 = new Event();
            e2.StartDateTime = fechaInseminacion.addDays(1);
            e2.IsAllDayEvent = true;
            //Hago una consulta de la vaca para tomar su numero, porque el objeto
            //que viene del trigger no puede navegar a los atributos de sus objetos 
            //con relacion de tipo look-up.            
            Inseminacion__c aux2 = [select Vaca__r.Nro_de_vaca__c
                                   from Inseminacion__c
                                   where id=:iNew.Id];
            e.Subject = 'Pare la vaca'+' '+ aux2.Vaca__r.Nro_de_vaca__c;
             insert e;
            
            e2.Subject = 'Secado de vaca' + ' ' + aux2.Vaca__r.Nro_de_vaca__c;
			insert e2;
            
             //Updateo a la vaca con ese Id para marcar que esta preñada
            
            Vaca__c vaca = new Vaca__c();
            vaca.id = aux.Vaca__r.Id;
            vaca.Preniada__c = true;
            update vaca;
			
            
            //Seteo fecha de secado en objeto paricion
            Paricion__c paricion = new Paricion__c();
            paricion.Fecha__c= e.StartDateTime.addDays(1);
            paricion.Fecha_en_pre_parto__c = e2.StartDateTime.addDays(1); //210
            paricion.Vaca__c = aux2.vaca__r.id;
            insert paricion;
     
        }
    }       
}