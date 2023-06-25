@isTest 
public with sharing class MovieActorTriggerTest {
    private static final String MALE = 'Male';
    private static final String FEMALE = 'Female';
    

    @TestSetup 
    static void makeData() {
      TestDataFactory.createMovies(3);
      TestDataFactory.createActors(2, MALE); 
      TestDataFactory.createActors(2, FEMALE); 
    }
    
    @isTest 
    static void updateNumberOfMoviesTest() {
      //GIVEN
      List<Movie__c> movies = [SELECT Id FROM Movie__c];
      List<Actor__c> actors = [SELECT Id FROM Actor__c WHERE Gender__c = :MALE];

      List<MovieActor__c> moviesActors = new List<MovieActor__c> {
          new MovieActor__c(Movie__c = movies.get(0).Id, Actor__c = actors.get(0).Id),
          new MovieActor__c(Movie__c = movies.get(0).Id, Actor__c = actors.get(1).Id),
          new MovieActor__c(Movie__c = movies.get(1).Id, Actor__c = actors.get(1).Id)
        };
		
        List<ID> actorsUnderTestIds = new List<ID>();
        actorsUnderTestIds.add(actors.get(0).Id);
        actorsUnderTestIds.add(actors.get(1).Id);
      
        //WHEN
        Test.startTest();
        insert moviesActors;
        Test.stopTest();
		
        List<MovieActor__c> createdMovieActor = [SELECT Id FROM MovieActor__c];
			        
        Map<ID,Actor__c> updatedActors = new Map<ID,Actor__c> ([
          SELECT Id, Number_of_movies__c 
          FROM Actor__c 
          WHERE Id IN :actorsUnderTestIds
          ]);
		
        //THEN
        System.assertEquals(1, updatedActors.get(actors.get(0).Id).Number_of_movies__c, 'number of movies not equal to the expected number' );
      	System.assertEquals(3, createdMovieActor.size(), 'number of created MovieActor record not equals to the expected number');
    }
    
}