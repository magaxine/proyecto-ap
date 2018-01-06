/**
* 
*/
public class HelloWorldService {
    
    /**
* @description
* @return true su la vaca... 
*/
    @AuraEnabled
    public static Boolean isVacaInseminable(String vacaId){
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
            		//tengo que chequear ademas q la vaca no este en tambo (preniada)
            System.debug('cantidad de inseminaciones no efectivas:' +count);
            if (count==3){
                System.debug('entre al if//cantidad de inseminaciones:' +count);
                /*Si las ultimas tres inseminaciones no fueron efectivas, retorno false, la vaca no esta
					lista para la inseminacion*/
                return false;
            }else return true;
             
        }catch(Exception e){
            throw new AuraHandledException('Error doing the query. Error: '+e.getMessage());
        }
    }
    
}