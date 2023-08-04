//
//  CityListViewController.swift
//  WeatherApp
//
//  Created by Khyati Vyas on 2023-08-04.
//

import UIKit

var items:[String] = []
var content: String = "London,On"
var viewC = ViewController()

class CityListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var cityListView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        _ = searchedCityName
      //  self.items.append(item)
        //loadData()
        
        cityListView.delegate = self
        cityListView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityNameList",for: indexPath)
        let item = items[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = item
        content.secondaryText = String(temp)
        
        
        cell.contentConfiguration = content
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        _ = tableView.cellForRow(at: indexPath)
        content = items[indexPath.row]
        
        print("From cell: ", content)
        
    }
    

}

func loadData(){
    
    if let searchedCityName = searchedCityName{
        items.append(searchedCityName)
    }
}
