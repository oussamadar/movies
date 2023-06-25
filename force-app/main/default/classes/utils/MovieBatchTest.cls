@isTest
public with sharing class MovieBatchTest {
    
    @TestSetup
    static void makeData(){
        TestDataFactory.createMovies(150, Date.today().addDays(-10));
    }

    @isTest
    static void updateMoviesReleaseDate() {

        //WHEN
        Test.startTest();
        MovieBatch mb = new MovieBatch();
        Id batchId = Database.executeBatch(mb);
        Test.stopTest();

        List<Movie__c> movies = [SELECT IsReleased__c FROM Movie__c WHERE IsReleased__c = TRUE];
        
        //THEN
        System.assertEquals(150, movies.size(), 'Unexpected Result');
    }
}