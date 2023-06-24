trigger MovieTrigger on Movie__c (before delete) {
   new MovieTriggerHandler().run();
}