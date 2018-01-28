trigger EstaMuertaTrigger on Vaca__c (before update) {
    
     for(integer i=0; i<Trigger.New.size();i++){
        Vaca__c iOld = Trigger.Old.get(i);
        Vaca__c iNew = Trigger.New.get(i);
    
         if(!iOld.Muerta__c && iNew.Muerta__c ){
             	 iNew.En_tambo__c = false;
             	 iNew.Vendida__c = false;
             	 iNew.En_pre_parto__c = false;
                 iNew.Enferma__c = false;
         }    
     } 

}