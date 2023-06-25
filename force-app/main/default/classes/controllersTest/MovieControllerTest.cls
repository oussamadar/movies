@isTest
public with sharing class MovieControllerTest {
   @testSetup
   static void makeData(){
    TestDataFactory.createMovies(3,  Date.today()); 
   }

   @isTest
   static void shouldReturnAllMovies(){
    
    //GIVEN
    List<Movie__c> expectedMovies = [
        SELECT Id,
            Name,
            Category__c,
            Poster_url__c,
            Description__c,
            Release_date__c,
            Rating__c 
        FROM Movie__c];

    //WHEN 
    List<Movie__c> actualMovies = MovieController.getAllMovies();

    //THEN 
    System.assertEquals(expectedMovies.size(), actualMovies.size(), 'Unexpected Result');
   }

   @isTest
   static void shouldSearchMovieByName(){
    
    //GIVEN
    List<Movie__c> expectedMoviesWithSearchTerm = [SELECT Id FROM Movie__c WHERE Name = 'Movie1'];
    List<Movie__c> expectedMoviesWithoutSearchTerm = [SELECT Id FROM Movie__c ];

    //WHEN 
    List<Movie__c> actualMoviesWithSearchTerm = MovieController.searchMovies('Movie1');
    List<Movie__c> actualMoviesWithoutSearchTerm = MovieController.searchMovies('');

    //THEN 
    System.assertEquals(expectedMoviesWithSearchTerm.size(), actualMoviesWithSearchTerm.size(), 'Unexpected Result');
    System.assertEquals(expectedMoviesWithoutSearchTerm.size(), actualMoviesWithoutSearchTerm.size(), 'Unexpected Result');
   }
}