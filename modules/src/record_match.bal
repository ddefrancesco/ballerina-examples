import ballerina/io;

type RecordOne record {
    string var1;
};
type RecordTwo record {|
    string var1;
    int var2;
|};
type RecordThree record {
    string var1;
    RecordTwo var2;
};
public function main() {
    RecordOne rec1 = {var1: "Hello", "var2": 150};
    RecordOne rec2 = {var1: "Hello", "var2": true};
    RecordOne rec3 = {var1: "Hello", "var2": 150, "var3": true};
    RecordOne rec4 = {var1: "Hello"};    
    basicMatch(rec1);
    basicMatch(rec2);
    basicMatch(rec3);
    basicMatch(rec4);    
    RecordTwo tRec1 = {var1: "Ballerina", var2: 500};
    RecordThree tRec2 = {var1: "Language", var2: tRec1};    
    matchWithTypeGuard(tRec1);
    matchWithTypeGuard(tRec2);
    matchWithTypeGuard(true);
}
function basicMatch(any a) {
    match a {
        var {var1, var2, var3} => {
            io:println("Matched with three vars : ", var1, ", ", var2, ", ", var3);
        }
        var {var1, var2} => {
            io:println("Matched with two vars : ", var1, ", ", var2);
        }
        var {var1} => {
            io:println("Matched with single var : ", var1);
        }
    }
}
function matchWithTypeGuard(any matchExpr) {
    match matchExpr {
        var {var1, var2} if var2 is string => {
               io:println("Matched with string typeguard");
        }
        var {var1, var2} if (var1 is int && var2 is int) => {
               io:println("Matched with int and int typeguard : ", var1);
        }
        var {var1, var2} if (var1 is string && var2 is int) => {
               io:println("Matched with string and int typeguard : ", var1);
        }
        var {var1, var2} if (var1 is int && var2 is RecordTwo) => {
               io:println("Matched with int and RecordTwo typeguard : ", var1);
        }
        var {var1, var2} if (var1 is string && var2 is RecordTwo) => {
               io:println("Matched with string and RecordTwo typeguard : ", var2.var1);
        }
        var x => {
            io:println("Matched with Default");
        }
    }
}
