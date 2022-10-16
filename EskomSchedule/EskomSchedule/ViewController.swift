//
//  ViewController.swift
//  EskomSchedule
//
//  Created by Sibusiso Mbonani on 2022/10/11.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    let dp = DataProvider()
    let sb = ScheduleBuilder()
    let ch = CalendarHelper()
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var monthLabel: UILabel!
    
    var selectedDate = Date()
    var totalSquares = [String]()
    
    var items = ["John", "Thabo", "Sthembiso", "Sibusiso"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dp.parseSchedule()
        setMonthView()
    }
    
    func setMonthView() {
        
        totalSquares.removeAll()
        
        let daysInMonth = ch.daysInMonth(date: selectedDate)
        let firstDayOfMonth = ch.firstOfMonth(date: selectedDate)
        let startingSpaces = ch.weekDay(date: firstDayOfMonth)
        
        var count: Int = 1
        
        while (count <= 42) {
            if count <= startingSpaces || startingSpaces - 1 > daysInMonth {
                totalSquares.append("")
            } else {
                totalSquares.append(String(count - startingSpaces))
            }
            count += 1
        }
        
        monthLabel.text = ch.monthString(date: selectedDate) + " " + ch.yearString(date: selectedDate)
//        collectionView.reloadData()
    }

    @IBAction func prevWeekClicked(_ sender: UIButton) {
        selectedDate = ch.minusMonth(date: selectedDate)
        setMonthView()
    }
    
    @IBAction func nextWeekClicked(_ sender: UIButton) {
        selectedDate = ch.plusMonth(date: selectedDate)
        setMonthView()
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarCell", for: indexPath) as! CalendarCell
        cell.titleLabel.text = items[indexPath.row]
        return cell
    }    
}
