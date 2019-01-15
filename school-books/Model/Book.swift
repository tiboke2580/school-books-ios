struct Book: Codable{
        var _v: String
    var _id: String
    var title: String
    var bookDescription: String
    var image_filename: String
    var contact: String
    var price: String
    var user_id: String
    
    enum CodingKeys: String, CodingKey{
        case _v
        case _id
        case title
        case bookDescription
        case image_filename
        case contact
        case price
        case user_id

    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self._id = try container.decode(String.self, forKey: ._id)
        self.title = try container.decode(String.self, forKey: .title)
        self.bookDescription = try container.decode(String.self, forKey: .bookDescription)
        self.image_filename = try container.decode(String.self, forKey: .image_filename)
        self.contact = try container.decode(String.self, forKey: .contact)
        self.price = try container.decode(String.self, forKey: .price)
        self.user_id = try container.decode(String.self, forKey: .user_id)
        self._v = try container.decode(String.self, forKey: ._v)
        
    }
    
}





