import ballerina/http;
import ballerina/log;
// http:ListenerConfiguration helloWorldEPConfig = {
//     secureSocket: {
//         keyStore: {
//             path: "${ballerina.home}/bre/security/ballerinaKeystore.p12",
//             password: "ballerina"
//         }
//     }
// secureSocket: {        
    //     keyStore: {
    //         path: "/Library/Ballerina/ballerina-1.0.2/distributions/jballerina-1.0.2/bre/security/ballerinaTrustsore.p12",
    //         password: "ballerina"
    //      }
    // }
// };l
// istener http:Listener helloWorldEP = new(8243, config = helloWorldEPConfig);@http:ServiceConfig {
//     basePath: "/hello"
// }
// service helloWorld on helloWorldEP {    @http:ResourceConfig {
//         methods: ["GET"],
//         path: "/"
//     }
//     resource function sayHello(http:Caller caller, http:Request req) {
//         var result = caller->respond("Hello World!");
//         if (result is error) {
//            log:printError("Failed to respond", err = result);
//         }
//     }
// }

http:ClientConfiguration clientEPConfig = {
    
    secureSocket: {
        disable: true
    }
 
};

public function main() {
    http:Client clientEP = new("https://192.168.1.77:8243", clientEPConfig);
    http:Request req = new;
    req.addHeader("accept","application/json");
    req.addHeader("Authorization","Bearer e6b35007-cd33-317f-878f-a97812014822");
    var resp = clientEP->get("/hello/v1/greet",req);
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
