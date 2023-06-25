@isTest
public with sharing class MovieSchedulerTest {

    private static final String CRON_EXP = '0 0 0 15 3 ? 2042';

    @TestSetup
    static void makeData(){
        TestDataFactory.createMovies(150, Date.today().addDays(-10));
    }  
    

    @isTest static void shoudlExecuteMovieBatch() {

        //WHEN
        Test.startTest();
        System.schedule('ScheduledApexTest', CRON_EXP, new MovieScheduler());
        Test.stopTest();

        List<Movie__c> results = [SELECT IsReleased__c FROM Movie__c WHERE IsReleased__c = TRUE];

        //THEN
        //System.assertEquals(150, results.size(), 'Unexpected results');
    }
}