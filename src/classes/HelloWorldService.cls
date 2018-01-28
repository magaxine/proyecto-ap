/**
        * 
        */
        public class HelloWorldService {
            
            /**
        * @description
        * @return true si la vaca no puede ser inseminable, ya sea porq esta en tambo, en pre o post-parto
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
                    //tengo que chequear ademas q la vaca no este en tambo o en secado (preniada)
                    
                    Vaca__c vaca= [Select id, Preniada__c, En_pre_parto__c from Vaca__c where id =:vacaId];
        
                    System.debug('cantidad de inseminaciones no efectivas:' +count);
                    System.debug('vaca preniada?'+ vaca.Preniada__c);
                    
                    if(count==3){
                        return false;
                    }else if(vaca.Preniada__c){
                        System.debug('entre al if/vaca esta preniada:' + vaca.Preniada__c);
                       return false; 
                    }else if(vaca.En_pre_parto__c){
                        System.debug('entre al if/vaca esta en pre parto:' + vaca.En_pre_parto__c);
                        return false;     
                    }else{
                        return true;
                    }
                    
                }catch(Exception e){
                    throw new AuraHandledException('Error doing the query. Error: '+e.getMessage());
                }
            }
            
        }