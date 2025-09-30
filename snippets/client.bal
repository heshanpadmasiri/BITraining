import ballerina/email;

function mailDemo() returns error? {

    email:SmtpClient sc = check new ("smtp.example.com",
        "user123@example.com",
        "Passwd123"
    );
    check sc->sendMessage({
        to: "contact@ballerina.io",
        subject: "Ballerina",
        body: "I love Ballerina!"
    });
}
