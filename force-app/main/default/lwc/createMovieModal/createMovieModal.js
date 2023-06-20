import { wire } from 'lwc';
import LightningModal from 'lightning/modal';
import REFRESH_MOVIE_LIST from '@salesforce/messageChannel/Refresh_List__c';

import NAME_FIELD from "@salesforce/schema/Movie__c.Name";
import CATEGORY_FIELD from "@salesforce/schema/Movie__c.Category__c";
import DESCRIPTION_FIELD from "@salesforce/schema/Movie__c.Description__c";
import RELEASE_DATE_FIELD from "@salesforce/schema/Movie__c.Release_date__c";
import MOVIE_OBJECT from "@salesforce/schema/Movie__c";
import IMAGE_FIELD from "@salesforce/schema/Movie__c.Poster_url__c";
import { MessageContext, publish } from 'lightning/messageService';

export default class CreateMovieModal extends LightningModal {
   
    @wire(MessageContext)
    messageContext;
    apiObjectName = MOVIE_OBJECT;
    fields = [NAME_FIELD, CATEGORY_FIELD, DESCRIPTION_FIELD, RELEASE_DATE_FIELD, IMAGE_FIELD];

    
    successModal() {
        this.close();
        publish(this.messageContext, REFRESH_MOVIE_LIST);
        
    }
    closeModal() {
        this.close('okay');
    }
}