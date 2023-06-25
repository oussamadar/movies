@IsTest
public class TestDataFactory {
   public static List<Movie__c> createMovies(Integer numberOfMovies, Date releaseDate) {
        List<Movie__c> movies = new List<Movie__c>();
        for (Integer i = 0; i < numberOfMovies; i++) {
            movies.add(
                new Movie__c(Name = 'Movie' + i, Category__c = 'Action', Release_date__c = releaseDate)
        );
    }
   
        insert movies;
        return movies;
    }

    public static List<Actor__c> createActors(Integer numberOfMovies, String gender) {
       
        List<Actor__c> actors = new List<Actor__c>();
        for (Integer i = 0; i < numberOfMovies; i++) {
            actors.add(
                new Actor__c(Name = 'Actor' + i, Gender__c = gender)
            );
        }
       
        insert actors;
        return actors;
    }

    public static List<MovieActor__c> createMovieActor(List<Id> movieIds, List<Id> actorsIds) {
       
        List<MovieActor__c> moviesActors = new List<MovieActor__c> {
            new MovieActor__c(Movie__c = movieIds.get(0), Actor__c = actorsIds.get(0)),
            new MovieActor__c(Movie__c = movieIds.get(0), Actor__c = actorsIds.get(1)),
            new MovieActor__c(Movie__c = movieIds.get(1), Actor__c = actorsIds.get(1))
          };
       
        insert moviesActors;
        return moviesActors;
    }
}