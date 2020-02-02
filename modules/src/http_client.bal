import ballerina/http;
import ballerina/log;

public function main() {
 http:Client clientEP = new("http://192.168.1.77:8280");
    http:Request req = new;
    req.addHeader("accept","application/json");
    req.addHeader("Authorization","Bearer 27b9cda7-0a1b-39a0-976c-ce4d6aa0e090");
    var resp = clientEP->get("/v1/hello/api/sayHello");
    if (resp is http:Response) {
        var payload = resp.getJsonPayload();
        if (payload is json) {
            log:printInfo(payload.toJsonString());
        } else {
            log:printError(<string>payload.detail()["message"]);
        }
    } else {
        log:printError(<string>resp.detail()["message"]);
    }
}
