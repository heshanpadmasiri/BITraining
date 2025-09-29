import ballerina/http;
import ballerinax/postgresql;

final http:Client isbnClient = check new ("localhost:9091");
final postgresql:Client postgresqlClient = check new ("localhost", "bookstore_user", "bookstore_password", "bookstore", 5432);
