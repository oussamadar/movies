import { LightningElement, wire } from 'lwc';
import searchMovies from '@salesforce/apex/MovieController.searchMovies';
import REFRESH_MOVIE_LIST from '@salesforce/messageChannel/Refresh_List__c';
import { refreshApex } from '@salesforce/apex';
import { unsubscribe, MessageContext, subscribe } from 'lightning/messageService';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import CreateMovieModal from "c/createMovieModal";

export default class MoviesResults extends LightningElement {
  searchTerm = '';
  movies;
  subscription = null;


  @wire(MessageContext)
  messageContext;
  @wire(searchMovies, { searchTerm: '$searchTerm' })
  loadMovies(result) {
    this.movies = result;

  }

  connectedCallback() {
    this.subscription = subscribe(this.messageContext, REFRESH_MOVIE_LIST, () => {
      this.showToastMessage(
        'Success',
        'Operation Executed Successefully',
        'Success'
      );
      refreshApex(this.movies);
    })
  }

  disconnectedCallback() {
    unsubscribe(this.subscription);
    this.subscription = null;
  }

  handleSearchTermChange(event) {
    window.clearTimeout(this.delayTimeout);
    const searchTerm = event.target.value;
    this.delayTimeout = setTimeout(() => {
      this.searchTerm = searchTerm;
    }, 300);
  }

  get hasResults() {
    return (this.movies.data.length > 0);
  }


  async handleOpenModal() {
    const result = await CreateMovieModal.open({
      size: 'small',
      description: 'Modal to create new movie',
    });

  }

  showToastMessage(title, message, variant) {
    const event = new ShowToastEvent({
      title,
      message,
      variant
    });
    this.dispatchEvent(event);
  }

}