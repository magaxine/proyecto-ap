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
            /*Query que me trae las ultimas tres inseminaciones seguidas que no tuvieron efecto*/
            List<Inseminacion__c> inseminaciones = [select id, efectiva__c  from Inseminacion__c 
                                           		 where efectiva__c = false order by fecha__c limit 3];
                integer count = 0;
                for(integer i=0; i<inseminaciones.size(); i++){
                    if (inseminaciones[i].efectiva__c==false){
                        count++;
                    }
                }
            if (count==3){
                return false;
            }else return true;
             
        }catch(Exception e){
            throw new AuraHandledException('Error doing the query. Error: '+e.getMessage());
        }
    }
    
}