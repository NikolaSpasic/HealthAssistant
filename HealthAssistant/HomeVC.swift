//
//  HomeVC.swift
//  HealthAssistant
//
//  Created by Slavimir Stosovic on 8/23/19.
//  Copyright © 2019 VTS AppsTeam. All rights reserved.
//

import UIKit

class HomeVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var activitiesCollectionView: UICollectionView!
    @IBOutlet weak var resultsTableview: UITableView!
    var measurmentResults = [MeasurmentOption]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let brokenImg = UIColor.black.image()
        
        resultsTableview.delegate = self
        resultsTableview.dataSource = self
        resultsTableview.tableFooterView = UIView()
        resultsTableview.rowHeight = 70
        resultsTableview.allowsSelection = false
        
        measurmentResults.append(MeasurmentOption(logoimg: UIImage(named: "activity_icon") ?? brokenImg, illustrationImg: UIImage(named: "activity_lines") ?? brokenImg, activityName: "Aktivnost"))
        
        activitiesCollectionView.delegate = self
        activitiesCollectionView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 30, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 4, height: activitiesCollectionView.bounds.height - 20)
        activitiesCollectionView.collectionViewLayout = layout
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultsCell") as! resultsTableviewCell
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor(red: 215/255, green: 215/255, blue: 215/255, alpha: 1.0).cgColor
        cell.layer.cornerRadius = 7
        cell.measurementValueLbl.isHidden = true
        cell.mainImageView.image = measurmentResults[indexPath.section].logo
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "resultsTimeCell", for: indexPath) as! ActivitiesCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CGFloat((collectionView.frame.size.width / 3) - 20), height: CGFloat(100))
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
