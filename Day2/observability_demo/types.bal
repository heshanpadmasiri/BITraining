type BaseResponse record {|
    int lattitude;
    int longitude;
    string unit;
|};

type TemperatureResponse record {|
    *BaseResponse;
    decimal temperature;
|};

type WindSpeedResponse record {|
    *BaseResponse;
    decimal windspeed;
|};
