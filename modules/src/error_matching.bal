import ballerina/io;

type SampleError error<string,Foo>;

const INVALID_ID = "invalid id";
type  InvalidIdError error<INVALID_ID, InvalidIdDetail>;

type Foo record {|
    string message?;
    error cause?;
    boolean fatal;
|};
type InvalidIdDetail record {|
    string message?;
    error cause?;
    string id;
|};

public function main() {
    [string, string] v1 = ["Sample String", "Sample String 2"];
    Foo v2 = { message: "A", fatal: false };
    error e1 = error("Generic Error", message = "Failed");
    SampleError e2 = error("Sample Error",  message =  "Fatal", fatal = true);
    InvalidIdError e3 = InvalidIdError(id = "33456");
    basicMatch(v1);
    basicMatch(v2);
    basicMatch(e1);
    basicMatch(e2);
    basicMatch(e3);
}

function basicMatch(any|error v) {
    match v {
        var [tVar1, tVar2] => { io:println("Matched a value with a tuple shape"); }
        var { message, fatal } =>
                            { io:println("Matched a value with a record shape"); }
        var InvalidIdError(id = id) => { io:println("Matched `InvalidError` id=", id); }

        var error(reason, message = message) => { io:println("Matched an error value : ",
                  io:sprintf("reason: %s, message: %s", reason, message)); }
        var error(reason, message = message, ...rest) => { io:println("Matched an error value : ",
                  io:sprintf("reason: %s, rest detail: %s", reason, rest)); }
    }
}