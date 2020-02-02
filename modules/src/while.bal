import ballerina/io;
public function main() {
    io:println("Iterating a string array :");
    string[] fruits = ["apple", "banana", "cherry"];
    foreach var v in fruits {
        io:println("fruit: ", v);
    }    
    io:println("\nIterating a map :");
    map<string> words = { a: "apple", b: "banana", c: "cherry" };
    foreach var fruit in words {
        io:println(fruit);
    }
    foreach var [k, v] in words.entries() {
        io:println("letter: ", k, ", word: ", v);
    }    
    io:println("\nIterating a JSON object :");
    json apple = { name: "apple", colors: ["red", "green"], price: 5 };
    map<json> mapValue = <map<json>> apple;
    foreach var value in mapValue {
        if (value is string) {
            io:println("string value: ", value);
        } else if (value is int) {
            io:println("int value: ", value);
        } else if (value is json[]) {
            io:println("json array value: ", value);
        } else {
            io:println("non-string value: ", value);
        }
    }    
    
    io:println("\nIterating a JSON array :");
    json[] colors = <json[]>apple.colors;
    int counter = 0;
    foreach var j in colors {
        io:println("color ", counter, ": ", j);
        counter += 1;
    }    
    
    io:println("\nIterating XML :");
    xml book = xml `<book>
                        <name>Sherlock Holmes</name>
                        <author>Sir Arthur Conan Doyle</author>
                    </book>`;
    counter = 0;
    foreach var x in book.getChildren().elements(){
        io:println("xml at ", counter, ": ", x);
        counter += 1;
    }    
    
    io:println("\nIterating a closed integer range :");
    int endValue = 10;
    int sum = 0;
    foreach var i in 1...endValue {
        sum = sum + i;
    }
    io:println("summation from 1 to ", endValue, " is ", sum);    
    
    io:println("\nIterating a half open integer range :");
    sum = 0;
    foreach var i in 1..<endValue {
        sum = sum + i;
    }
    io:println("summation from 1 to ", endValue,
                        " excluding ", endValue, " is ", sum);
}
