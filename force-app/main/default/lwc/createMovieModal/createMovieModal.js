import { wire } from 'lwc';
import LightningModal from 'lightning/modal';
import REFRESH_MOVIE_LIST from '@salesforce/messageChannel/Refresh_List__c';
import searchActors from '@salesforce/apex/ActorController.searchActors';
import createMovieActor from '@salesforce/apex/MovieActorController.createMovieActor'

import NAME_FIELD from "@salesforce/schema/Movie__c.Name";
import CATEGORY_FIELD from "@salesforce/schema/Movie__c.Category__c";
import DESCRIPTION_FIELD from "@salesforce/schema/Movie__c.Description__c";
import RELEASE_DATE_FIELD from "@salesforce/schema/Movie__c.Release_date__c";
import MOVIE_OBJECT from "@salesforce/schema/Movie__c";
import PICTURE_FIELD from "@salesforce/schema/Movie__c.Poster_url__c";
import RATING_FIELD from "@salesforce/schema/Movie__c.Rating__c";
import { MessageContext, publish } from 'lightning/messageService';


export default class CreateMovieModal extends LightningModal {
    nameField = NAME_FIELD;
    categoryField = CATEGORY_FIELD;
    descriptionField = DESCRIPTION_FIELD;
    releaseDateField = RELEASE_DATE_FIELD;
    ratingField = RATING_FIELD;
    objectApiName = MOVIE_OBJECT;
    pictureField = PICTURE_FIELD;
    selectedActorIds = [];

    @wire(MessageContext)
    messageContext;

    handleMovieCreated(event) {
        createMovieActor({ movieId: event.detail.id, actorsIds: this.selectedActorIds })
            .then(() => {
                publish(this.messageContext, REFRESH_MOVIE_LIST);
                this.close();
            })
            .catch((error) => {
                this.close();
                this.showToastMessage(
                    'Error Creating Movie',
                    error.body.message,
                    'Error'
                );
            });
    }

    handleSearchActor(event) {
        const lookupElement = event.target;
        searchActors(event.detail)
            .then((results) => {
                lookupElement.setSearchResults(results);
            })
            .catch((error) => {
                this.showToastMessage(
                    'Somtehing went wrong',
                    error.body.message,
                    'Error'
                );
            });
    }

    handleSelectionActor(event) {
        this.selectedActorIds = event.detail;
    }

    handleClose() {
        this.close();
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