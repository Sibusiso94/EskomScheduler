//
//  DataProvider.swift
//  EskomSchedule
//
//  Created by Sibusiso Mbonani on 2022/10/12.
//

import Foundation
import UIKit

class DataProvider {
    
    var schedule: EskomSchedule? = nil
    var areaSearch: AreaSearch? = nil
    var areaID: [Area] = []
    let tokenString = "yoqhWx01QSnV5gr9bpUg"
    
    func parseArea(areaName: String, completion: @escaping () -> ()) {
//        let trimmedUrl = getFood.trimmingCharacters(in: .whitespacesAndNewlines)
        let urlArea = "https://developer.sepush.co.za/business/2.0/areas_search?text=\(areaName)"
        
        guard let url = URL(string: urlArea) else {
            fatalError("Invalid URL")
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(tokenString, forHTTPHeaderField: "token")
//        request.addValue("esp_token \(tokenString)", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { [self] data, response, error in

            guard let data = data else { return }
                do {
                    self.areaSearch = try JSONDecoder().decode(AreaSearch.self, from: data)
                    
                    DispatchQueue.main.async {
//                        for area in decodedData.areas {
//                            self.areaID.append(area)
//                        }
                        completion()
                    }
                } catch {
                    print("Error fetching data: \(error)")
                }
            
        }.resume()
    }
    
    func parseSchedule(completion: @escaping () -> ()) {
        
        let urlScheduleInfo = "https://developer.sepush.co.za/business/2.0/area?id=ekurhuleni3-16-benonicbd&test=current"
//        var areaID: [Area] = []
        
        guard let url = URL(string: urlScheduleInfo) else {
            fatalError("Invalid URL")
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(tokenString, forHTTPHeaderField: "token")

        URLSession.shared.dataTask(with: request) { data, response, error in

            guard let data = data else { return }
                do {
                    let decodedData = try JSONDecoder().decode(EskomSchedule.self, from: data)
                    
                    DispatchQueue.main.async {
                        print(decodedData)
                        completion()
                        }
                } catch {
                    print("Error fetching data: \(error)")
                }
            
        }.resume()
    }
}
