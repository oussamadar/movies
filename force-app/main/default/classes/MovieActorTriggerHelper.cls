public with sharing class MovieActorTriggerHelper {
    public static void updateNumberOfMovies(List<MovieActor__c> movieActorList, Boolean isDeleted ) {

      Set<Id> actorIds = new Set<Id>{};
        
      for (MovieActor__c mA : movieActorList) {
        actorIds.add(mA.Actor__c);
      }
       
      List<Actor__c> actors = [
          SELECT ID, Number_of_movies__c
          FROM Actor__c
          WHERE ID IN :actorIds
          WITH SECURITY_ENFORCED
      ];

      for (Actor__c actor : actors) {
       
          actor.Number_of_movies__c++;
        }
      
  
      if ( Schema.SObjectType.Actor__c.isUpdateable() && Schema.SObjectType.Actor__c.fields.Number_of_movies__c.isUpdateable()) {
        update actors;
      }
    }
  
    public static void calculateGenderPercentage(List<MovieActor__c> moviesActors) {
      Set<Id> moviesIds = new Set<Id>();
  
      for (MovieActor__c mA : moviesActors) {
        moviesIds.add(mA.Movie__c);
      }
  
      List<Movie__c> movies = [
        SELECT Id
        FROM Movie__c
        WHERE Id IN :moviesIds
        WITH SECURITY_ENFORCED
      ];
  
      Map<Id, AggregateResult> maleCountByMovieId =  new Map<Id, AggregateResult>( [
        SELECT movie__r.Id, actor__r.gender__c, COUNT(actor__r.Name)
        FROM MovieActor__c
        WITH SECURITY_ENFORCED
        GROUP BY movie__r.Id, actor__r.gender__c
        HAVING actor__r.gender__c = 'Male'
      ]);

      Map<Id, AggregateResult> femaleCountByMovieId = new Map<Id,AggregateResult>([
        SELECT movie__r.Id, actor__r.gender__c, COUNT(actor__r.Name)
        FROM MovieActor__c
        WITH SECURITY_ENFORCED
        GROUP BY movie__r.Id, actor__r.gender__c
        HAVING actor__r.gender__c = 'Female'
      ]);
  
      for (Movie__c movie : movies) {
        Integer maleCount = maleCountByMovieId.get(movie.Id) != null
          ? Integer.valueOf(maleCountByMovieId.get(movie.Id).get('expr0'))
          : 0;
        Integer femaleCount = femaleCountByMovieId.get(movie.Id) != null
          ? Integer.valueOf(femaleCountByMovieId.get(movie.Id).get('expr0'))
          : 0;
        Integer total = maleCount + femaleCount;
  
        movie.MaleActorsPercentage__c = ((Decimal) maleCount / total) * 100;
        movie.FemaleActorsPercentage__c = ((Decimal) femaleCount / total) * 100;
      }
  
      if (
        Schema.SObjectType.Movie__c.isUpdateable() &&
        Schema.SObjectType.Movie__c.fields.MaleActorsPercentage__c.isUpdateable() &&
        Schema.SObjectType.Movie__c.fields.FemaleActorsPercentage__c.isUpdateable()
      ) {
        update movies;
      }
    }    
  }