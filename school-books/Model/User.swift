struct User: Codable{
    let _id: String
    let username: String
    let token: String
    let books: [String]
    
    enum CodingKeys: String, CodingKey{
        case _id
        case username
        case token
        case books
    }
}
