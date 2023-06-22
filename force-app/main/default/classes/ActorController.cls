public with sharing class ActorController {
   @AuraEnabled(cacheable=true)
   public static Actor__c[] searchActors(String searchTerm){
    searchTerm = '%' + searchTerm + '%';
        return [
            SELECT
                Id,
                Name,
                Gender__c
            FROM Actor__c
            WHERE Name LIKE :searchTerm
            WITH SECURITY_ENFORCED
            ORDER BY Name asc
            LIMIT 20
        ];
   }
}