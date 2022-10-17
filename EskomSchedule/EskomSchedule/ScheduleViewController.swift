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
    var dataProvider = DataProvider()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scheduleText.text = "Schedule: \n\(dataProvider.schedule!)"
    }
    

 

}
