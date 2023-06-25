@isTest 
public with sharing class MovieTriggerTest {
    private static final String MALE = 'Male';
    private static final String FEMALE = 'Female';

    @testSetup 
    static void setup() {
        List<Id> moviesIds = new List<Id> ( (new Map<Id,Movie__c>( TestDataFactory.createMovies(2))).keySet() );
        List<Id> actorsIds = new List<Id> ( ( new Map<Id,Actor__c>( TestDataFactory.createActors(1, MALE))).keySet() );
        actorsIds.addAll( new List<Id>( (new Map<Id,Actor__c>(TestDataFactory.createActors(1, FEMALE))).keySet()) );
        TestDataFactory.createMovieActor(moviesIds, actorsIds); 
    }

    @isTest
    static void decrementNumberOfMoviesTest() {
        //GIVEN
        List<Movie__c> movies = [SELECT Id FROM Movie__c];
        List<Actor__c> actors = [SELECT Id FROM Actor__c ];

        //WHEN
        Test.startTest();
        delete movies ;
        Test.stopTest();

        List<Actor__c> updatedActors = [SELECT Id, Number_of_movies__c FROM Actor__c];

        //Then 
        for (Actor__c actor : updatedActors) {
            System.assertEquals(0, actor.Number_of_movies__c, 'number of movies not equals to the expected number');
        }
       



    }
}