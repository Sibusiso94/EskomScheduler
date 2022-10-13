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
    var areas = [DBArea]()
    
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
    
    func loadAreas() -> [DBArea] {
        let request: NSFetchRequest<DBArea> = DBArea.fetchRequest()
        
//        request.predicate = NSPredicate(format: "taskArchived == 0 && taskIsDone == 0")
        do {
            areas = try context.fetch(request)
            return areas
        } catch {
            print("Error fetching tasks: \(error)")
            return areas
        }
    }
}
