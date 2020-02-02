import ballerina/http;
import ballerina/log;

@http:ServiceConfig {
    basePath: "/hello"
}
service hello on new http:Listener(9090) {
    @http:ResourceConfig {
        methods: ["GET"],
        path: "/greet"
    }
    resource function greet(http:Caller caller, http:Request req) {
        json j6 = { name: "Daniele", saluto: "ciao"};
        
        //var payload = req.getJsonPayload();
        http:Response res = new;
        res.setJsonPayload(j6);
        // if (payload is json) {
        //     io:println(j6);
        //     res.setJsonPayload(<@untainted> payload);
        // } else {
        //     res.statusCode = 500;
        //     res.setPayload(<@untainted> <string>payload.detail()?.message);
        // }

        var result = caller->respond(res);
        if (result is error) {
           log:printError("Error in responding", result);
        }
    }
}
