import ballerina/io;
import ballerina/udp;

service on new udp:Listener(8080) {

    remote function onDatagram(udp:Datagram & readonly dg) {
        io:println("bytes received: ", dg.data.length());
    }
}

import ballerina/http;

service on new http:Listener(8080) {

    resource function get hello(string name) returns string {
        return "Hello, " + name;
    }
}
