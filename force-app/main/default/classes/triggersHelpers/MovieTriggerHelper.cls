public with sharing class MovieTriggerHelper {

    public static void updateNumberOfMovies(List<Movie__c> oldMovieList) {
        Set<Id> movieIds = (new Map<Id,Movie__c>(oldMovieList)).keySet();

        List<Actor__c> actors = [
            SELECT Id, Number_of_movies__c 
            FROM Actor__c 
            WHERE Id IN (SELECT Actor__c FROM MovieActor__c WHERE Movie__c IN :movieIds )
            WITH SECURITY_ENFORCED
        ];
        
        for (Actor__c actor : actors) {
            actor.Number_of_movies__c--;
        }
      
        if ( Schema.SObjectType.Actor__c.isUpdateable() && Schema.SObjectType.Actor__c.fields.Number_of_movies__c.isUpdateable()) {
            update actors;
        }


    }
}