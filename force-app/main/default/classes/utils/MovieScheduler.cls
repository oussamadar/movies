public with sharing class MovieScheduler implements Schedulable {

    public void execute(SchedulableContext sc) {
        System.debug('inside MovieScheduler' );
        MovieBatch movieBatch = new MovieBatch();
        Database.executeBatch(movieBatch);
    }
}