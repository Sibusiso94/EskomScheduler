//
//  ScheduleBuilder.swift
//  EskomSchedule
//
//  Created by Sibusiso Mbonani on 2022/10/12.
//

import Foundation

let dp = DataProvider()
var areas: [Area] = []

class ScheduleBuilder {
    
    func getAreas(name: String) {
        dp.parseArea(areaName: name) { [self] in
            if let nameArray = dp.areaSearch {
                for nameItem in nameArray.areas {
                    print(nameItem.id)
                    print(nameItem.name)
                    print(nameItem.region)
                    print("============================================")
                }
            }
        }
    }
    
    func builder() {
        let dateTime = Date()
        
        print(dateTime)
    }
}
