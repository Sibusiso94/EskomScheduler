//
//  CalendarViewController.swift
//  EskomSchedule
//
//  Created by Sibusiso Mbonani on 2022/10/14.
//

import UIKit

class CalendarViewController: UIViewController {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var items = ["John", "Thabo", "Sthembiso", "Sibusiso"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CalendarViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.titleLabel.text = items[indexPath.row]
        return cell
    }
    
    
}
