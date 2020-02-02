import ballerina/io;

int globalA = 5;
function basicClosure() returns (function (int) returns int) {
    int a = 3;
    var foo = function (int b) returns int {
        int c = 34;
        if (b == 3) {
            c = c + b + a + globalA;
        }
        return c + a;
    };
    return foo;
}

function modulusClosure() returns (function (int) returns int) {
    
    var foo = function (int x) returns int {
        int c;
        if (x > 0) {
            c = x;
        }else{
            c = -x;
        }
        return c;
    };
    return foo;
}

function multilevelClosure() returns (function (int) returns int) {
    int a = 2;
    var func1 = function (int x) returns int {
        int b = 23;
        a = a + 8;
        var func2 = function (int y) returns int {
            int c = 7;
            var func3 = function (int z) returns int {
                b = b + 1;
                return x + y + z + a + b + c;
            };
            return func3(8) + y + x;
        };
        return func2(4) + x;
    };
    return func1;
}
function functionPointers(int a) returns
                    (function (int) returns (function (int) returns int)) {
    return function (int b) returns (function (int) returns int) {
        return function (int c) returns int {
            return a + b + c;
        };
    };
}
public function main() {
    var foo = basicClosure();
    int result1 = foo(3);
    io:println("Answer: ", result1);

    var modx = modulusClosure();
    int modres = modx(-3);
    io:println("|x| Answer: ", modres);

    var bar = multilevelClosure();
    int result2 = bar(5);
    io:println("Answer: ", result2);
    var baz1 = functionPointers(7);
    var baz2 = baz1(5);
    int result3 = baz2(3);
    io:println("Answer: ", result3);
}
