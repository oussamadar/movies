import { LightningElement, api, wire } from 'lwc';
import { publish, MessageContext } from 'lightning/messageService';
import MOVIE_PREVIEW_CHANNEL from '@salesforce/messageChannel/Movie_Preview__c'

export default class MovieTile extends LightningElement {
    @api movie;
    @wire(MessageContext)
    messageContext;
    handleSelectMovie() {
        console.log(this.movie.Id);
        const selectedMovie = {
            id: this.movie.Id,
            poster: this.movie.Poster_url__c
            
        };
        publish(this.messageContext, MOVIE_PREVIEW_CHANNEL, selectedMovie);

    }

    
}