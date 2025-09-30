import ballerina/http;
import ballerina/log;

listener http:Listener httpDefaultListener = http:getDefaultListener();

service /weather on httpDefaultListener {

    resource function get temperature/[int lat]/[int long]() returns error|TemperatureResponse {
        do {
            log:printInfo(`temperature lookup started`, lattitude = lat, longitude = long);
            decimal temperature = 30;
            log:printDebug(`temparature calculated`, temperature = temperature);
            TemperatureResponse result = {
                lattitude: lat,
                longitude: long,
                temperature: 30,
                unit: "Celsius"
            };
            log:printDebug(`result`, result = result);
            log:printInfo(`temperature lookup done`, lattitude = lat, longitude = long, temperature = temperature);
            return result;
        } on fail error err {
            // handle error
            return error("unhandled error", err);
        }
    }

    resource function get windspeed/[int lat]/[int long]() returns error|WindSpeedResponse {
        do {
            log:printInfo(`windspeed lookup started`, lattitude = lat, longitude = long);
            decimal windspeed = 30;
            log:printDebug(`windspeed calculated`, windspeed = windspeed);
            WindSpeedResponse result = {
                lattitude: lat,
                longitude: long,
                windspeed: 30,
                unit: "kmph"
            };
            log:printDebug(`result`, result = result);
            log:printInfo(`windspeed lookup done`, lattitude = lat, longitude = long, windspeed = windspeed);
            return result;
        } on fail error err {
            // handle error
            return error("unhandled error", err);
        }
    }
}
