public class Api {

struct crypto {
       
        let name: String
        let symbol: String
        let image: String
        let id: String
        
    }
    
    var cryptoName: [String] = []
    var  cryptoImage: [String] = []
    
    var coins = [crypto]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Crypto Watcher"
        self.tableView.delegate = self
        self.tableView.dataSource = self
        // Do any additional setup after loading the view.
        
        let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=eur&order=market_cap_desc&per_page=100&page=1&sparkline=false")!
        
        let config = URLSessionConfiguration.default
        let sessions = URLSession(configuration: config)
       
        let task = sessions.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                if let json = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers) {
                    if let data = json as? [[String: AnyObject]] {
                            for coin in data {
                                self.coins.append(crypto(name: coin["name"] as! String,
                                                         symbol: coin["symbol"] as! String,
                                                         image: coin["image"] as! String,
                                                         id: coin["id"] as! String))
                                DispatchQueue.main.async {
                                    self.tableView.reloadData()
                                }
                        }
                    }
                }
            }
        }
        task.resume()
        
        
    }
}
