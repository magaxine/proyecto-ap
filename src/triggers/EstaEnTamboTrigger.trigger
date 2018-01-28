/*Trigger para deschequear que la vaca esta en pre-parto, muerta, 
vendida o enferma cuando esta en tambo*/
trigger EstaEnTamboTrigger on Vaca__c (before update) {
    
    for(integer i=0; i<Trigger.New.size();i++){
        Vaca__c iOld = Trigger.Old.get(i);
        Vaca__c iNew = Trigger.New.get(i);
    
         if(!iOld.En_tambo__c && iNew.En_tambo__c ){
                 iNew.En_pre_parto__c = false;
             	 iNew.Muerta__c = false;
             	 iNew.Vendida__c = false;
             	 iNew.Enferma__c = false;
         }    
     } 
}