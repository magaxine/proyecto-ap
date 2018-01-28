/*Trigger para deschequear que la vaca esta, muerta, 
vendida o en tambo*/
trigger EstaEnfermaTrigger on Vaca__c (before update) {
    
     for(integer i=0; i<Trigger.New.size();i++){
        Vaca__c iOld = Trigger.Old.get(i);
        Vaca__c iNew = Trigger.New.get(i);
    
         if(!iOld.Enferma__c && iNew.Enferma__c ){
             	 iNew.Muerta__c = false;
             	 iNew.Vendida__c = false;
             	 iNew.En_tambo__c = false;
         }    
     } 

}