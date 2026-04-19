@isTest
global class OpenAIMock implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest req) {
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"choices": [{"message": {"content": "{\\"sentiment\\": 15, \\"urgency\\": \\"High\\", \\"summary\\": \\"Upset customer, immediate refund requested\\"}"}}]}');
        res.setStatusCode(200);
        return res;
    }
}