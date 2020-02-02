import ballerina/http;
import ballerina/io;
//import ballerina/log;

http:ClientConfiguration clientConfig = {
    secureSocket: {
        disable: true
    }
};  
http:Client clientEndpoint = new("https://192.168.1.77:19443/oauth2/token", clientConfig);

public function main() {

    var clientId="upTFlMFGvkfswyDmDuCdUpHvWwca";
    var code="35b54a27-d424-3c53-94a7-1c6660b090bc";
    var redirectUri="https://example-app.com/redirect";
    var client_secret="jAFX9fomIkLdGxotuFk8gbTIRlca";
    var response = clientEndpoint->post("?grant_type=authorization_code&code="+code+"&redirectUri="+redirectUri+"&client_id="+clientId+"client_secret="+client_secret,"POST: Get token");
    
    handleResponse(response);
}
function handleResponse(http:Response|error response) {
    
    if (response is http:Response) {
        io:println("Calling backend URI: ", response.resolvedRequestedURI.toString());
        var msg = response.getJsonPayload();
        if (msg is json) {

            io:println(msg.toJsonString());
        } else {
            io:println("Invalid payload received:" , msg.reason(),msg.toString());
        }
    } else {
        io:println("Error when calling the backend: ", response.reason());
    }
}