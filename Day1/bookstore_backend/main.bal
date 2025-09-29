import ballerina/http;

listener http:Listener 'listen = new (port = 9091);

service / on 'listen {

    resource function put isbn(@http:Payload Lookup payload) returns error|Result {
        do {
            Result res = {
                isbn: "1234"
            };
            return res;
        } on fail error err {
            // handle error
            return error("unhandled error", err);
        }
    }
}
