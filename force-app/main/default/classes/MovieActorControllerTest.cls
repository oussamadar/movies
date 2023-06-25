@isTest
public with sharing class MovieActorControllerTest {
    @TestSetup
    static void makeData(){
        TestDataFactory.createActors(2, 'Male');
        TestDataFactory.createMovies(1);
    }

    @isTest
    static void shouldCreatedMovieActor() {

        //GIVEN
        List<Movie__c> movies = [SELECT id FROM Movie__c];
        List<Actor__c> actors = [SELECT id FROM Actor__c];
        List<Id> actorIds = new List<Id> ((new Map<Id,Actor__c>(actors)).keySet());

        //WHEN
        Test.startTest();
        MovieActorController.createMovieActor(movies.get(0).Id, actorIds);
        Test.stopTest();

        //THEN
        List<MovieActor__c> actualMovieActors = [SELECT Id FROM MovieActor__c];

        System.assertEquals(2,actualMovieActors.size(), 'Unexpected Result');


    }
}