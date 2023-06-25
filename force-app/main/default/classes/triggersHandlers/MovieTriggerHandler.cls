public with sharing class MovieTriggerHandler extends TriggerHandler {
    List<Movie__c> oldMovieList = new List<Movie__c> ();

    public MovieTriggerHandler() {
        oldMovieList = (List<Movie__c>) Trigger.old;
    }
    
    protected override void beforeDelete() {
        System.debug('calling before delete');
        MovieTriggerHelper.updateNumberOfMovies(oldMovieList);
    }

}