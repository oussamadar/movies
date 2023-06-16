import { LightningElement, api } from 'lwc';

export default class MovieTile extends LightningElement {
    @api movie;
    handleSelectMovie() {
       
        console.log( movie.Name);
        console.log(this.movie.Category__c);

    }

    
}