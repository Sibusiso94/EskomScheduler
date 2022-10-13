//
//  AreaSearch.swift
//  EskomSchedule
//
//  Created by Sibusiso Mbonani on 2022/10/13.
//

import Foundation

// MARK: - Welcome
struct AreaSearch: Codable {
    let areas: [Area]
}

// MARK: - Area
struct Area: Codable {
    let id, name, region: String
}

