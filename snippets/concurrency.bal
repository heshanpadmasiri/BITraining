import ballerina/io;

type Person record {|
    string name;
    boolean employed;
|};

function process(Person[] members, int[] quantities) {
    worker w1 {
        Person[] employedMembers = from Person p in members
            where p.employed
            select p;
        int count = employedMembers.length();
        count -> w2;
        string `Employed Members: ${count}` -> function;
    }

    worker w2 {
        int total = int:sum(...quantities);

        int employedCount = <- w1;

        int avg = employedCount == 0 ? 0 : total / employedCount;
        string `Average: ${avg}` -> function;
    }

    string x = <- w1;
    io:println(x);

    string y = <- w2;
    io:println(y);
}

int n = 0;

function inc() {
    lock {
        n += 1;
    }
}

type R record {
    int v;
};

final int N = getN();

isolated function set(R r) {
    r.v = N;
}

R r = {v: 0};

// This is not isolated

function getN() returns int {
    return 0;
}
