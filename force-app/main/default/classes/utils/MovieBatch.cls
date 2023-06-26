public with sharing class MovieBatch implements Database.Batchable<SObject> {

    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([SELECT Release_date__c, isReleased__c FROM Movie__c]);
    }

    public void execute(Database.BatchableContext bc, List<SObject> scope) {
        List<Movie__c> movies = new List<Movie__c>();
        for(Movie__c movie : (List<Movie__c>) scope) {
            
            if(movie.Release_date__c <= Date.today()) {
                movie.isReleased__c = true;
                movies.add(movie);
            }
        }
        update movies;
    }

    public void finish(Database.BatchableContext bc) {
        System.debug('Movie Batch has Finished');
    }
}