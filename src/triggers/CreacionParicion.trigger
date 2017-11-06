trigger CreacionParicion on Inseminacion__c (after update) {
    
    //Debo comparar los old con los new para saber si 
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
            Date preparto = fechaInseminacion.addDays(1);
            e2.IsAllDayEvent = true;
            //Hago una consulta de la vaca para tomar su numero, porque el objeto
            //que viene del trigger no puede navegar a los atributos de sus objetos 
            //con relacion de tipo look-up.            
            Inseminacion__c aux2 = [select Vaca__r.Nro_de_vaca__c
                                   from Inseminacion__c
                                   where id=:iNew.Id];
            e.Subject = 'Pare la vaca'+' '+ aux2.Vaca__r.Nro_de_vaca__c;
             insert e;
            
             //Updateo a la vaca con ese Id para marcar que esta pregnant
            Vaca__c vaca = new Vaca__c();
            vaca.id = aux.Vaca__r.Id;
            vaca.En_tambo__c = true;
            update vaca;
            
            //Seteo fecha de secado en objeto paricion
            Paricion__c paricion = new Paricion__c();
            paricion.Fecha__c= e.StartDateTime.addDays(1);
            paricion.Fecha_en_pre_parto__c = e2.StartDateTime.addDays(1);
            paricion.Vaca__c = aux2.vaca__r.id;
            insert paricion;
                    
            e2.Subject = 'Secado de vaca' + ' ' + aux2.Vaca__r.Nro_de_vaca__c;
			
            
        }
    }       
}