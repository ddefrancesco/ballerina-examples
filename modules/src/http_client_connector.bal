import ballerina/io;
import ballerina/http;
import ballerina/log;





http:ClientConfiguration clientEPConfig = {
    secureSocket: {
        disable: true
    }
    

};

http:Client clientEndpoint = new("https://192.168.1.77:9443/api/identity/auth/v1.1",clientEPConfig);

function handleResponse(http:Response|error response) returns @tainted string{
    var msg = "";
    if (response is http:Response) {
         if (response.getJsonPayload() is json) {
            log:printInfo(response.getContentType());
        
        
            msg = response.getJsonPayload().toString();
       
            
            return msg.toJsonString();
        } else {
            io:println("Invalid payload received:" );
            return response.getJsonPayload().toString();
            //, msg.reason()+"\n\t"+msg.detail().toString()
        }
    } else {
        io:println("Error when calling the backend: ", response.detail());
    }
    return msg;
}

public function main() {
    // io:println("GET request:");
    // var response = clientEndpoint->get("/get?test=123");
    // handleResponse(response);

    io:println("\nPOST request:");
    json payload = { username: "admin", password: "admin"};
    http:Request authReq = new();
    authReq.addHeader("Content-Type","application/json");
    authReq.setPayload(payload);
    
    log:printInfo("Preparata request");
    var response = clientEndpoint->post("/authenticate", authReq);
    var res = handleResponse(response);
    

    // io:println("\nUse custom HTTP verbs:");
    // response = clientEndpoint->execute("COPY", "/get", "CUSTOM: Hello World");
    // http:Request req = new;

    // if (response is http:Response) {
    //     string contentType = response.getHeader("Content-Type");
    //     io:println("Content-Type: " + contentType);

    //     int statusCode = response.statusCode;
    //     io:println("Status code: " + statusCode.toString());
    // } else {
    //     io:println("Error when calling the backend: " , response.reason());
    
    // }

}