struct User: Codable{
    var _id: String
    var username: String
    var token: String
    var books: [String]
    
    enum CodingKeys: String, CodingKey{
        case _id
        case username
        case token
        case books
    }
}
