
type BookData record {
    string title;
    string author;
    int edition;
    decimal price;
};

type CreateBookRes record {|
    string status;
    string isbn;
|};

type IsbnLookupReq record {|
    string title;
    string author;
    int edition;
|};

type IsbnLookupResult record {|
    string isbn;
|};
