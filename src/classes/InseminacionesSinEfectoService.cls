public class InseminacionesSinEfectoService {
                
                    /**
                    * @description
                    * @return true su la vaca no ha tenido mas de tres inseminaciones seguidas sin efecto 
                    */
                        @AuraEnabled
                        public static Boolean isVacaInseminable(Id vacaId){
                            try{
                                System.debug('isVacaInseminable, vaca id: '+vacaId); 
                                /*Query que me trae las tres ultimas inseminaciones de la vaca */
                                List<Inseminacion__c> inseminaciones = [select id, efectiva__c from Inseminacion__c where vaca__c =:vacaId
                                                                        order by fecha__c desc limit 3];
                                /*Aca filtro por inseminacion no efectiva*/    
                                integer count = 0;
                                    for(integer i=0; i<inseminaciones.size(); i++){
                                        if (inseminaciones[i].efectiva__c==false){
                                            count++;
                                        }
                                    }
                                
                                if(count==3){
                                    return false;
                                } else{
                                    return true;
                                }
           
                        }catch(Exception e){
                        throw new AuraHandledException('Error doing the query. Error: '+e.getMessage());
                    }
            }
    }