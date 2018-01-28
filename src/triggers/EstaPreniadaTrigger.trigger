/*Trigger para deschequear que la vaca esta muerta o vendida cuando se chequea preniada*/
trigger EstaPreniadaTrigger on Vaca__c (before update) {
    
         for(integer i=0; i<Trigger.New.size();i++){
        Vaca__c iOld = Trigger.Old.get(i);
        Vaca__c iNew = Trigger.New.get(i);
    
         if(!iOld.Preniada__c && iNew.Preniada__c ){
             	 iNew.Muerta__c = false;
             	 iNew.Vendida__c = false;
         }    
     } 

}