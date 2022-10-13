//
//  DatabaseHandler.swift
//  EskomSchedule
//
//  Created by Sibusiso Mbonani on 2022/10/13.
//

import Foundation
import CoreData
import UIKit

class DatabaseHandler {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var area = [DBArea]()
    
    func saveData() {
        
        do {
            try context.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }
    
    func addArea(areaID: String, areaName: String, areaRegion: String) {
        let newArea = DBArea(context: context)
        
        newArea.areaID = areaID
        newArea.areaName = areaName
        newArea.areaRegion = areaRegion
        
        saveData()
        print("Saved Successfully")
        
    }
    
    func loadAreas() {
        
    }
}
