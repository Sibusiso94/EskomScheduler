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
    @IBOutlet weak var tableView: UITableView!
    
    var selectedDate = Date()
    var totalSquares = [Date]()
    
    var items = ["Helo", "HI", "Ho", "Yiypo", "HVW", "ebfiwefe", "cjahbcvuqvt2ed"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //dp.parseSchedule()
        setMonthView()
        
        collectionView.collectionViewLayout = createLayout()
        tableView.register(UINib(nibName: "SearchCell", bundle: nil), forCellReuseIdentifier: "SearchCell")
        
        dp.parseSchedule {
            self.tableView.reloadData()
        }
    }
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        // item
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(55), heightDimension: .absolute(50)))
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1)
        
        // group
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.1)), repeatingSubitem: item, count: 7)
        
        // section
        let section = NSCollectionLayoutSection(group: group)
        
        //return
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    func setMonthView() {
        
        totalSquares.removeAll()
        
        var current = ch.sundayForDate(date: selectedDate)
        let nextSunday = ch.addDays(date: current, days: 7)
        
        while (current < nextSunday) {
            totalSquares.append(current)
            current = ch.addDays(date: current, days: 1)
        }
        
        monthLabel.text = ch.monthString(date: selectedDate) + " " + ch.yearString(date: selectedDate)
//        collectionView.reloadData()
    }

    @IBAction func prevWeekClicked(_ sender: UIButton) {
        selectedDate = ch.addDays(date: selectedDate, days: -7)
        setMonthView()
    }
    
    @IBAction func nextWeekClicked(_ sender: UIButton) {
        selectedDate = ch.addDays(date: selectedDate, days: 7)
        setMonthView()
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return totalSquares.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarCell", for: indexPath) as! CalendarCell
        let date = totalSquares[indexPath.item]
        cell.titleLabel.text = String(ch.dayOfMonth(date: date))
        
        if date == selectedDate {
            cell.backgroundColor = .systemMint
        } else {
            cell.backgroundColor = .white
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedDate = totalSquares[indexPath.item]
        collectionView.reloadData()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchCell
        cell.titleLable.text = items[indexPath.row]
        return cell
    }
}
