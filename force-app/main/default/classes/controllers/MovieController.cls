public with sharing class MovieController {
    

    @AuraEnabled(cacheable=true scope='global')
    public static Movie__c[] getAllMovies() {
        return  [
            SELECT
                Id,
                Name,
                Category__c,
                Poster_url__c,
                Description__c,
                Release_date__c,
                Rating__c
            FROM Movie__c
            WITH SECURITY_ENFORCED
            ORDER BY Name desc
            LIMIT 20
        ];
    }
    @AuraEnabled(cacheable=true scope='global')
    public static Movie__c[] searchMovies(String searchTerm) {
       
        searchTerm = searchTerm.trim();
        if (searchTerm == '') {
            return getAllMovies();
        }
        searchTerm = '%' + searchTerm + '%';
        return [
            SELECT
                Id,
                Name,
                Category__c,
                Poster_url__c,
                Description__c,
                Release_date__c,
                Rating__c
            FROM Movie__c
            WHERE Name LIKE :searchTerm
            WITH SECURITY_ENFORCED
            ORDER BY Name desc
            LIMIT 20
        ];
    }
}