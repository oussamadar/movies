import { LightningElement, wire } from 'lwc';
import searchMovies from '@salesforce/apex/MovieController.searchMovies';

export default class MoviesResults extends LightningElement {
    searchTerm = '';
    movies;
    @wire(searchMovies,{searchTerm:'$searchTerm'})
    loadBears(result) {
        this.movies = result;
        
    }

    handleSearchTermChange(event) {
		
		window.clearTimeout(this.delayTimeout);
		const searchTerm = event.target.value;
		// eslint-disable-next-line @lwc/lwc/no-async-operation
		this.delayTimeout = setTimeout(() => {
			this.searchTerm = searchTerm;
		}, 300);
	}

    get hasResults() {
		return (this.movies.data.length > 0);
	}
}