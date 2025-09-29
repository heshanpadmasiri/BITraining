function createIsbnLookupReq(BookData req) returns IsbnLookupReq => {
    title: req.title,
    author: req.author
,
    edition: req.edition
};

function createBookRes(string status, IsbnLookupResult isbn) returns CreateBookRes => {
    isbn: isbn.isbn,
    status: status
};
