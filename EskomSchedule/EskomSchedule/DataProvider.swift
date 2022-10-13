//
//  DataProvider.swift
//  EskomSchedule
//
//  Created by Sibusiso Mbonani on 2022/10/12.
//

import Foundation
import UIKit

struct DataProvider {
    
    var schedule: EskomSchedule? = nil
    let tokenString = "yoqhWx01QSnV5gr9bpUg"
    
    func parseJSON(getFood:String, completion: @escaping () -> ()) {


        let trimmedUrl = getFood.trimmingCharacters(in: .whitespacesAndNewlines)


        var request = URLRequest(url: URL(string: "https://developer.sepush.co.za/business/2.0")!)
        request.addValue("esp_token \(tokenString)", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { [self] data, response, error in

            if error == nil {
                do {
                    schedule = try JSONDecoder().decode(EskomSchedule.self, from: data!)
                    
                    DispatchQueue.main.async {
                        completion()
                    }
                } catch {
                    print("Error fetching data: \(error)")
                }
            }
        }.resume()
    }
    
//    func readLocalFile(forName name: String) -> Data? {
//        do {
//            if let bundlePath = Bundle.main.path(forResource: name,
//                                                 ofType: "json"),
//                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
//                print(jsonData.description)
//                return jsonData
//            }
//        } catch {
//            print(error)
//        }
//
//        return nil
//    }
//
//    func parse(jsonData: Data) {
//        do {
//            let decodedData = try JSONDecoder().decode(EskomSchedule.self,
//                                                       from: jsonData)
//
//            print("Title: ", decodedData.events)
//            print("Description: ", decodedData.schedule)
//            print("===================================")
//        } catch {
//            print("decode error")
//        }
//    }
    
//    func loadJson(fromURLString urlString: String,
//                          completion: @escaping (Result<Data, Error>) -> Void) {
//        if let url = URL(string: urlString) {
//            let urlSession = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
//                if let error = error {
//                    completion(.failure(error))
//                }
//                
//                if let data = data {
//                    completion(.success(data))
//                }
//            }
//            
//            urlSession.resume()
//        }
//    }
}
