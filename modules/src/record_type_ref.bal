import ballerina/io;

type Person record {|
    string name;
    int age = 25;
|};
type Employee record {|
    *Person;
    string company?;
    string designation;
|};

type Manager record {
    Employee[] team?;
    *Employee;
};

public function main() {
    Employee john = { name: "John Doe", designation: "Software Engineer" };
    Employee jane = { name: "Jane Doe", designation: "UX Engineer" };

    io:println(john);
    io:println(jane);

    Manager mgr = { name: "Mark", age: 35, designation: "Engineering Manager" };
    mgr.team = [john, jane];
    mgr.company = "XYZ Inc.";
    io:println(mgr);
}