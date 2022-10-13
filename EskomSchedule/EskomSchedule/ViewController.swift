//
//  ViewController.swift
//  EskomSchedule
//
//  Created by Sibusiso Mbonani on 2022/10/11.
//

import UIKit

class ViewController: UIViewController {
    
    let dp = DataProvider()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        builder()
    }

    func builder() {
        
        if let localData = dp.readLocalFile(forName: "data") {
            dp.parse(jsonData: localData)
        }
        let dateTime = Date()
        
//        print(dateTime)
    }

}

