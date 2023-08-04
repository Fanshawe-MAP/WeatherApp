//
//  CityListViewController.swift
//  WeatherApp
//
//  Created by Khyati Vyas on 2023-08-04.
//

import UIKit

class CityListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var cityListView: UITableView!
    var items:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let item = "London"
        self.items.append(item)
        loadData()
        
        cityListView.delegate = self
        cityListView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func loadData(){
        items.append("Toronto")
        items.append("Vancouver")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityNameList",for: indexPath)
        let item = items[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = item
        cell.contentConfiguration = content
        
        return cell
    }
    

}
