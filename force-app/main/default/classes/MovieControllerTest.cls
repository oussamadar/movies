@isTest
public with sharing class MovieControllerTest {
   @testSetup
   static void makeData(){
    TestDataFactory.createMovies(3); 
   }

   @isTest
   static void shouldReturnAllMovies(){
    
    //GIVEN
    List<Movie__c> expectedMovies = [SELECT Id FROM Movie__c];

    //WHEN 
    List<Movie__c> actualMovies = MovieController.getAllMovies();

    //THEN 
    System.assertEquals(expectedMovies.size(), actualMovies.size(), 'Unexpected Result');
   }

   @isTest
   static void shouldSearchMovieByName(){
    
    //GIVEN
    List<Movie__c> expectedMovies = [SELECT Id FROM Movie__c WHERE Name = 'Movie1'];

    //WHEN 
    List<Movie__c> actualMovies = MovieController.searchMovies('Movie1');

    //THEN 
    System.assertEquals(expectedMovies.size(), actualMovies.size(), 'Unexpected Result');
   }
}