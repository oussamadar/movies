import { LightningElement, track, wire } from 'lwc';
import { unsubscribe, MessageContext, subscribe, publish } from 'lightning/messageService';
import MOVIE_PREVIEW_CHANNEL from '@salesforce/messageChannel/Movie_Preview__c';
import REFRESH_MOVIE_LIST from '@salesforce/messageChannel/Refresh_List__c';
import { deleteRecord, getRecord,getFieldValue } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

import NAME_FIELD from "@salesforce/schema/Movie__c.Name";
import CATEGORY_FIELD from "@salesforce/schema/Movie__c.Category__c";
import DESCRIPTION_FIELD from "@salesforce/schema/Movie__c.Description__c";
import RELEASE_DATE_FIELD from "@salesforce/schema/Movie__c.Release_date__c";
import MOVIE_OBJECT from "@salesforce/schema/Movie__c";
import IMAGE_FIELD from "@salesforce/schema/Movie__c.Poster_url__c"

 
export default class MoviePreview extends LightningElement {

    
    objectApiName = MOVIE_OBJECT;
    fields = [NAME_FIELD, CATEGORY_FIELD, DESCRIPTION_FIELD, RELEASE_DATE_FIELD, IMAGE_FIELD];
    subscription = null;
    moviePoster;
    movieId;

    @wire(MessageContext)
    messageContext;

    @wire(getRecord, { recordId: "$movieId", fields })
    movie;

    handleMessage(message) {
        this.movieId = message.id;
        this.moviePoster = message.poster;

    }

    connectedCallback() {

        this.subscription = subscribe(
            this.messageContext,
            MOVIE_PREVIEW_CHANNEL,
            (message) => {
                this.handleMessage(message);
            });
    }
    disconnectedCallback() {
        unsubscribe(this.subscription);
        this.subscription = null;
    }

    handleDelete(event) {
        
        deleteRecord(this.movieId)
            .then(() => {
                publish(this.messageContext, REFRESH_MOVIE_LIST);
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Movie deleted',
                        variant: 'success'
                    })
                );
                this.movieId = null;

            })
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error deleting record',
                        message: error.body.message,
                        variant: 'error'
                    })
                );
            });
    }

    editHandler() {
        publish(this.messageContext, REFRESH_MOVIE_LIST);
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Success',
                message: 'Movie updated successfully',
                variant: 'success'
            })
        );
    }
    handleInput(){
        alert('f');
    }
}