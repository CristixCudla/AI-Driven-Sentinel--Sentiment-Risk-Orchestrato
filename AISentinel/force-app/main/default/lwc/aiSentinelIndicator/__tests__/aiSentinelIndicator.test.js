import { createElement } from 'lwc';
import AiSentinelIndicator from 'c/aiSentinelIndicator';
import { getRecord } from 'lightning/uiRecordApi';

// Mock pentru datele pe care le-ar returna wire-ul getRecord
const mockGetRecord = require('./data/getRecord.json');

describe('c-ai-sentinel-indicator', () => {
    afterEach(() => {
        // Curățăm DOM-ul după fiecare test
        while (document.body.firstChild) {
            document.body.removeChild(document.body.firstChild);
        }
    });

    it('renders AI insights when data is available', () => {
        const element = createElement('c-ai-sentinel-indicator', {
            is: AiSentinelIndicator
        });
        document.body.appendChild(element);

        // Simulăm trimiterea datelor către wire
        getRecord.emit(mockGetRecord);

        // Verificăm dacă informațiile apar în UI
        return Promise.resolve().then(() => {
            const summaryEl = element.shadowRoot.querySelector('.slds-box');
            expect(summaryEl.textContent).toBe('Angry customer needs refund');
            
            // Verificăm dacă scorul apare (sentimentul din mock e 15)
            const sentimentScore = element.shadowRoot.querySelector('.slds-grid span:last-child');
            expect(sentimentScore.textContent).toBe('15%');
        });
    });

    it('shows loading message when no data is available', () => {
        const element = createElement('c-ai-sentinel-indicator', {
            is: AiSentinelIndicator
        });
        document.body.appendChild(element);

        const pEl = element.shadowRoot.querySelector('p');
        expect(pEl.textContent).toBe('Waiting for AI analysis...');
    });
});