import ballerina/test;

@test:Config
function testValidPayload() {
    do {
        BookData payload = {
            title: "foo",
            author: "bar",
            edition: 0,
            price: 0.0d
        };
        IsbnLookupReq expected = {
            title: "bar",
            author: "bar",
            edition: 0
        };
        IsbnLookupReq actual = createIsbnLookupReq(payload);
        test:assertEquals(actual, expected);
    } on fail error err {
    }
}
