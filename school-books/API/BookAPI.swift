import Siesta

let BookAPI = _BookAPI()

class _BookAPI{
    
    
    private let service = Service(
        baseURL : "http://projecten3studserver03.westeurope.cloudapp.azure.com:3003",
        standardTransformers: [.text, .image])
    
    private init(){
        SiestaLog.Category.enabled = [.network, .pipeline, .observers]
        
        let jsonDecoder = JSONDecoder()
        
        service.configure("**"){
            $0.headers["Authorization"] = self.basicAuthHeader
        }
        
        service.configureTransformer("/users/*")
        {
            try jsonDecoder.decode(User.self, from: $0.content<#T##Data#>)
        }
    }
    
    func logIn(username: String, password: String)
    {
        
    }
    
    private var basicAuthHeader: String?{
        service.invalidateConfiguration()
        
        service.wipeResources()
    }
}
