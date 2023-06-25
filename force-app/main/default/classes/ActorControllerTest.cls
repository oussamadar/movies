@isTest
public with sharing class ActorControllerTest {
   private static final String ACTOR_NAME = 'Actor1';
    @TestSetup
   static void makeData(){
    TestDataFactory.createActors(3, 'Male');
   }

   @isTest
   static void shouldSearchActorByName() {

    //GIVEN
    List<Actor__c> expectedActor = [SELECT Id FROM Actor__c WHERE Name = :ACTOR_NAME];

    //WHEN
    List<Actor__c> actualActor = ActorController.searchActors(ACTOR_NAME) ;

    //THEN
     System.assertEquals(expectedActor.size() , actualActor.size(), 'Unexpected Result');
   }


}