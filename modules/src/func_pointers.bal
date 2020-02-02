import ballerina/io;
import ballerina/lang.'int as ints;
function test(int x, string s) returns float {
    int | error y = ints:fromString(s);
    float f = 0.0;    if (y is int) {
        f = x * 1.0 * y;
    } else {
        panic y;
    }
    return f;
}
function foo(int x, function (int, string) returns float bar)
             returns float {
    return x * bar(10, "2");
}
function getFunctionPointer() returns (function (int, string) returns float) {
    return test;
}
public function main() {
    io:println("Answer: ", foo(10, test));
    io:println("Answer: ", foo(10, getFunctionPointer()));
    function (int, string) returns float f = getFunctionPointer();
    io:println("Answer: ", foo(10, f));
}
