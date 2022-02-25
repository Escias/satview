//
//  searchViewController.swift
//  SatView
//
//  Created by administration4 on 25/02/2022.
//

import UIKit


class SearchViewController: UIViewController, UISearchResultsUpdating, UITableViewDataSource, UISearchBarDelegate, UITableViewDelegate {
        
    @IBOutlet weak var tableView: UITableView!
    
    var filteredData: [String]! = []
    let searchController = UISearchController()
    let apiSat = ApiSat()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        title = "search"
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text: String = searchController.searchBar.text else {
            return
        }
        let url = URL(string: "https://tle.ivanstanojevic.me/api/tle?search=" + text)
        apiSat.getSatelites(url: url!) { results in
            var satList: [String] = [String]()
            for item in results! {
                let id = item["satelliteId"]!
                let urlSearch = URL(string: self.apiSat.url + "/" + String(describing: id) + "/propagate")!
                self.apiSat.getSateliteData(url: urlSearch) { results in
                    print(results)
                    var sat = self.apiSat.createSat(data: results)
                    print(sat.name)
                    satList.append(sat.name!)
                    DispatchQueue.main.async{
                      self.filteredData = satList
                      self.tableView.reloadData()
                    }
                    //print(sat)
                }
            }
           
            print(satList)
            
            /*DispatchQueue.main.async{
                self.filteredData = satList
                self.tableView.reloadData()
            }*/
            
        }
        /*filteredData = text.isEmpty ? data : data.filter { (item: String) -> Bool in
                  // If dataItem matches the searchText, return true to include it
                  return item.range(of: text, options: .caseInsensitive, range: nil, locale: nil) != nil
              }
              
              tableView.reloadData()*/
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as UITableViewCell
               cell.textLabel?.text = filteredData[indexPath.row]
               return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return filteredData.count
     }
    
    
      
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
