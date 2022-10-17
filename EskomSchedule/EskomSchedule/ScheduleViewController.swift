//
//  ScheduleViewController.swift
//  EskomSchedule
//
//  Created by Sthembiso Ndhlazi on 2022/10/17.
//

import UIKit

class ScheduleViewController: UIViewController {

    @IBOutlet weak var scheduleText: UITextView!
    
    var schedule: EskomSchedule? = nil
    var area:Area?
    
    var dataProvider = DataProvider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataProvider.parseSchedule(areaID: area!.id)

        scheduleText.text = "Schedule: \n\(dataProvider.schedule!)"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        dp.parseSchedule(areaID: area!.id)
    }
    

 

}
