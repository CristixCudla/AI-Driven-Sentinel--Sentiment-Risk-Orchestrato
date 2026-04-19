import { LightningElement, api, wire } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';

import SENTIMENT_FIELD from '@salesforce/schema/Case.AI_Sentiment__c';
import URGENCY_FIELD from '@salesforce/schema/Case.AI_Urgency__c';
import SUMMARY_FIELD from '@salesforce/schema/Case.AI_Summary__c';

const FIELDS = [SENTIMENT_FIELD, URGENCY_FIELD, SUMMARY_FIELD];

export default class AiSentinelIndicator extends LightningElement {
    @api recordId;

    @wire(getRecord, { recordId: '$recordId', fields: FIELDS })
    case;

    // --- ADAUGĂ ASTA ---
    get isDataAvailable() {
        return this.case && this.case.data;
    }
    // -------------------

    get sentiment() { return getFieldValue(this.case.data, SENTIMENT_FIELD) || 0; }
    get urgency() { return getFieldValue(this.case.data, URGENCY_FIELD) || 'N/A'; }
    get summary() { return getFieldValue(this.case.data, SUMMARY_FIELD) || 'Analysis in progress...'; }

    get urgencyClass() {
        return this.urgency === 'High' ? 'slds-text-color_error slds-text-title_bold' : 'slds-text-color_success';
    }

    get barVariant() {
        return this.sentiment < 40 ? 'error' : 'success';
    }

    get sentimentLabel() {
        if (this.sentiment < 30) return '😠 Very Frustrated';
        if (this.sentiment < 60) return '😐 Neutral';
        return '😊 Happy / Satisfied';
    }
}