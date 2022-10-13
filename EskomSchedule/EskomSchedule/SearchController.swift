//
//  SearchController.swift
//  EskomSchedule
//
//  Created by Sibusiso Mbonani on 2022/10/13.
//

import UIKit

class SearchController: UITableViewController {
    
    let dp = DataProvider()
    let dbh = DatabaseHandler()

    override func viewDidLoad() {
        super.viewDidLoad()

        print("Loaded")
        tableView.register(UINib(nibName: "SearchCell", bundle: nil), forCellReuseIdentifier: "SearchCell")
    }

    override func viewWillAppear(_ animated: Bool) {
        dp.parseArea(areaName: "benoni") { [self] in
            if let nameArray = dp.areaSearch {
                tableView.reloadData()

            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dp.areaSearch?.areas.count ?? 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = dp.areaSearch?.areas[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell") as! SearchCell
        cell.titleLable.text = data?.name
        cell.subTitleLabel.text = data?.region
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = dp.areaSearch?.areas[tableView.indexPathForSelectedRow!.row]
//        dbh.addArea()
        print(data?.id)
        print(data?.name)
        print(data?.region)
    }
}
