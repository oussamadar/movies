public with sharing class MovieActorController {
   @AuraEnabled
   public static void createMovieActor(Id movieId, List<Id> actorsIds) {
    List<MovieActor__c> movieActors = new List<MovieActor__c>{};
    for (Id actorId : actorsIds) {
        movieActors.add(
            new MovieActor__c(
                Movie__c = movieId,
                Actor__c = actorId
            )
        );
    }
    if (Schema.sObjectType.MovieActor__c.isCreateable() && movieActors.size() > 0) {
        insert movieActors;
    }
    
   }
}