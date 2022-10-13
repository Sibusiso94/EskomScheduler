//
//  SearchController.swift
//  EskomSchedule
//
//  Created by Sibusiso Mbonani on 2022/10/13.
//

import UIKit

class SearchController: UITableViewController {
    
    let dp = DataProvider()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: <#T##String#>, bundle: <#T##Bundle?#>), forCellReuseIdentifier: <#T##String#>)
    }

    override func viewWillAppear(_ animated: Bool) {
        dp.parseArea(areaName: "benoni") { [self] in
            if let nameArray = dp.areaSearch {
                
            }
        }
    }
}

extension SearchController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dp.areaSearch?.areas.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: <#T##String#>)
    }
}
