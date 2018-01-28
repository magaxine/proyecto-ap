/*Trigger to uncheck 'En_tambo' for when 'En_pre_parto' checked and viceversa*/
trigger EstaEnPrepartoTrigger on Vaca__c (before update) {
    
     for(integer i=0; i<Trigger.New.size();i++){
        Vaca__c iOld = Trigger.Old.get(i);
        Vaca__c iNew = Trigger.New.get(i);
    
         if(!iOld.En_pre_parto__c && iNew.En_pre_parto__c ){
                 iNew.En_tambo__c = false;
             	 iNew.Muerta__c = false;
             	 iNew.Vendida__c = false;
         }
         
         if(!iOld.En_tambo__c && iNew.En_tambo__c){
             	iNew.En_pre_parto__c = false;
         }
        
     } 
}