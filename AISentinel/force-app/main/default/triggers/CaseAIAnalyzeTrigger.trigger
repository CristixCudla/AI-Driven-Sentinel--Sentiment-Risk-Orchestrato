trigger CaseAIAnalyzeTrigger on Case (after insert) {
    // Lista de Case-uri care au text valid pentru analiză
    for (Case c : Trigger.new) {
        
        // Verificăm dacă avem Descriere sau Subiect (prioritate are Descrierea)
        String textToAnalyze = '';
        if (String.isNotBlank(c.Description)) {
            textToAnalyze = c.Description;
        } else if (String.isNotBlank(c.Subject)) {
            textToAnalyze = c.Subject;
        }

        // Dacă avem text, trimitem către serviciul AI
        if (String.isNotBlank(textToAnalyze)) {
            // Apel asincron pentru a nu bloca salvarea Case-ului
            // Parametri: Id-ul Case-ului și textul pe care GPT trebuie să-l analizeze
            AISentinelService.processCaseAI(c.Id, textToAnalyze);
        }
    }
}