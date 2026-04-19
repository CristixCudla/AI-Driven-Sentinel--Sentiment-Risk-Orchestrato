🤖 AI-Driven Sentinel: Sentiment & Risk Orchestrator
AI-Driven Sentinel is a sophisticated Salesforce integration that uses OpenAI's GPT engine to perform real-time sentiment analysis and risk assessment on incoming Customer Support Cases.

The system automatically categorizes customer emotions, summarizes complex issues, and prioritizes urgent cases before a human agent even opens the record.

🌟 Features
Real-time AI Analysis: Triggers on Case creation to analyze Description and Subject.

Sentiment Scoring: Provides a 0-100% score (Visualized via a custom LWC).

Automated Prioritization: Dynamically upgrades Case Priority to High if the AI detects extreme frustration or critical failures.

Concise Summarization: Generates a 1-sentence executive summary of the customer's issue.

Unit Tested: 100% coverage for both Backend (Apex) and Frontend (Jest).

📸 Project Walkthrough
1. Creating a New Case
When a customer submits a case, the AI Sentinel Trigger intercepts the record and sends the text to the OpenAI API.

<img width="622" height="1145" alt="SCREENSHOTAPLICATIE" src="https://github.com/user-attachments/assets/f5ab4281-4035-4cec-b44e-a398028662e8" />


2. Live Insights Dashboard (LWC)
Once the analysis is complete, the custom Lightning Web Component displays the results. Notice the dynamic color coding and emoji reflecting the customer's mood.

<img width="978" height="560" alt="Screenshot 2026-04-19 233022" src="https://github.com/user-attachments/assets/9f502e07-9320-4303-9bc4-5460e1cbd7bf" />


3. Automated Metadata Updates
The AI doesn't just show data; it acts on it. The standard Priority field is automatically updated based on the AI's urgency assessment.

🧪 Testing & Quality Assurance
The project follows Salesforce best practices with a robust testing suite.

Backend (Apex Testing)
We use HttpCalloutMock to simulate API responses and ensure the trigger logic is bulletproof.

<img width="1386" height="970" alt="Screenshot 2026-04-19 230553" src="https://github.com/user-attachments/assets/3fa736cb-b49f-46a0-9f7c-ddf0dcd85baf" />


Frontend (Jest Testing)
The LWC is tested using Jest to ensure the UI handles different sentiment scores correctly.

<img width="1031" height="237" alt="Screenshot 2026-04-19 230527" src="https://github.com/user-attachments/assets/f69343f5-0e4b-4d94-94f3-e5301f707d6d" />


🛠️ Technical Stack
Backend: Apex (Triggers, Future Methods, REST Callouts).

Frontend: Lightning Web Components (LWC), HTML/CSS (Lightning Design System).

Integration: OpenAI API (GPT-3.5-Turbo).

Testing: Jest, Apex Test Framework.

🚀 Installation Note
To run this in a production environment:

Add https://api.openai.com to Remote Site Settings.

Store the OpenAI API Key in a Named Credential or Custom Label (currently configured in AISentinelService.cls for demo purposes).

👨‍💻 Author & Project Status
This project was architected and developed from scratch by Cristi Cudla.

Status: ✅ Fully Functional

Version: 1.0 (Production Ready)

Core Competencies: Full-stack Salesforce Development, AI Integration, UI/UX Design with SLDS.
