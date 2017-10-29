trigger CreacionParicion on Inseminacion__c (after update) {
    
    //Debo comparar los old con los new para saber si 
    for(integer i=0; i<Trigger.New.size();i++){
        Inseminacion__c iOld = Trigger.Old.get(i);
        Inseminacion__c iNew = Trigger.New.get(i);
        	
        //Si no estaba chequeada y ahora esta, se crea el nuevo evento.
        
        if(!iOld.efectiva__c && iNew.efectiva__c){
            Event e = new Event();
            e.StartDateTime = Date.today().addDays(1);
            e.IsAllDayEvent = true;
            //TODO: hacer una consulta de la vaca para tomar su nro de caravana
            //select from vaca id gushu guhsu
            e.Subject = 'Pare la vaca' + iOld.Vaca__r;
            insert e;
        }
    }
    
  
    /*
    for(Inseminacion__c inseminacion: Trigger.New){
        if(inseminacion.efectiva__c){
            System.debug('Se cambio la inseminacion a efectiva'+ inseminacion.name);
            
            Event e = new Event();
            e.StartDateTime = Date.today().addDays(270);
            e.IsAllDayEvent = true;
            e.Subject = 'Pare la vaca';
         
        }
    }*/
         
}