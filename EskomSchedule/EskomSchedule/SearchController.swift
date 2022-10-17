//
//  SearchController.swift
//  EskomSchedule
//
//  Created by Sibusiso Mbonani on 2022/10/13.
//

import UIKit

class SearchController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var searchText: UITextField!
    
    let dp = DataProvider()
    let dbh = DatabaseHandler()

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "SearchCell", bundle: nil), forCellReuseIdentifier: "SearchCell")
        tableView.reloadData()
    }

//    override func viewWillAppear(_ animated: Bool) {
//        dp.parseArea(areaName: "benoni") { [self] in
//            if let nameArray = dp.areaSearch {
//                tableView.reloadData()
//
//            }
//        }
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dp.areaSearch?.areas.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = dp.areaSearch?.areas[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell") as! SearchCell
        cell.setUp(areaName: data?.name ?? "None" , region: data?.region ?? "None")
//        cell.titleLable.text = data?.name
//        cell.subTitleLabel.text = data?.region
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = dp.areaSearch?.areas[tableView.indexPathForSelectedRow!.row]
        
        if let aID = data?.id, let aName = data?.name, let aRegion = data?.region {
            dbh.addArea(areaID: aID, areaName: aName, areaRegion: aRegion)
        }
        
        dp.parseSchedule(areaID: data!.id)
        print(dp.schedule)
        
        performSegue(withIdentifier: "showSchedule", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as? ScheduleViewController
        
        vc?.area = dp.areaSearch?.areas[tableView.indexPathForSelectedRow!.row]
        
    }
    
    
    
    @IBAction func searchTapped(_ sender: Any) {
        dp.parseArea(areaName: searchText.text ?? "") {
            print("Done")
            self.tableView.reloadData()
            self.viewDidLoad()
        }
    }
}
