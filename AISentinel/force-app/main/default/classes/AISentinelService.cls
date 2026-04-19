public class AISentinelService {
    
    @future(callout=true)
    public static void processCaseAI(Id caseId, String description) {
        // Debug ca să vedem în log-uri dacă metoda pornește
        System.debug('AI Sentinel started for Case: ' + caseId);
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://api.openai.com/v1/chat/completions');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json');
        request.setHeader('Authorization', 'Bearer sk-proj-3AS12HdDpKP6Isnh0I2FVIh5Byac_YSoLiahjbiikZscpQx858rIF7LBqXJO_cbH50zSPJ_d3T3BlbkFJePKSKcTZC3mF-M1Hbfr7_YgiAjsmJlgTJBMK1p_Q2LH3TRldx7pgMSlND6onlLtjgmXuHAq_sA');
        
        String promptText = 'Analyze this customer case: "' + description + '". Return ONLY a JSON object with: "sentiment" (0-100), "urgency" (Low, Medium, High), "summary" (max 10 words).';
        Map<String, Object> body = new Map<String, Object>();
        body.put('model', 'gpt-4o');
        body.put('messages', new List<Object>{ new Map<String, String>{'role' => 'user', 'content' => promptText} });
        request.setBody(JSON.serialize(body));
        
        try {
            HttpResponse response = http.send(request);
            if (response.getStatusCode() == 200) {
                AIResponseWrapper raw = (AIResponseWrapper)JSON.deserialize(response.getBody(), AIResponseWrapper.class);
                String cleanJson = raw.choices[0].message.content.replaceAll('```json', '').replaceAll('```', '').trim();
                AIResponseWrapper.SentimentResult result = (AIResponseWrapper.SentimentResult)JSON.deserialize(cleanJson, AIResponseWrapper.SentimentResult.class);
                
                // Folosim update pe un obiect nou creat cu ID-ul respectiv
                Case c = new Case(Id = caseId);
                c.AI_Sentiment__c = result.sentiment;
                c.AI_Urgency__c = result.urgency;
                c.AI_Summary__c = result.summary;
                if(result.sentiment < 30) c.Priority = 'High';
                
                update c;
                System.debug('Case updated successfully with sentiment: ' + result.sentiment);
            }
        } catch (Exception e) {
            System.debug('Error: ' + e.getMessage());
        }
    }
}

