public class AIResponseWrapper {
    public List<Choices> choices;

    public class Choices {
        public Message message;
    }

    public class Message {
        public String content;
    }

    // Clasa pentru obiectul JSON final extras din content
    public class SentimentResult {
        public Integer sentiment;
        public String urgency;
        public String summary;
    }
}