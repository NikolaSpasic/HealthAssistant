//
//  HomeVC.swift
//  HealthAssistant
//
//  Created by Slavimir Stosovic on 8/23/19.
//  Copyright © 2019 VTS AppsTeam. All rights reserved.
//

import UIKit

class HomeVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var activitiesCollectionView: UICollectionView!
    @IBOutlet weak var resultsTableview: UITableView!
    var measurmentResults = [MeasurmentOption]()
    var executed = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let brokenImg = UIColor.black.image()
        
        resultsTableview.delegate = self
        resultsTableview.dataSource = self
        resultsTableview.tableFooterView = UIView()
        resultsTableview.rowHeight = 90
        resultsTableview.allowsSelection = false
        
        measurmentResults.append(MeasurmentOption(logoimg: UIImage(named: "activity_icon") ?? brokenImg, illustrationImg: UIImage(named: "activity_lines") ?? brokenImg, activityName: "Aktivnost"))
        
        activitiesCollectionView.delegate = self
        activitiesCollectionView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 15
        layout.sectionInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
        activitiesCollectionView.collectionViewLayout = layout
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        if !executed {
            activitiesCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .right, animated: true)
            executed = true
//        }
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
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "resultsTimeCell", for: indexPath) as! ActivitiesCollectionViewCell
        cell.layer.cornerRadius = 7
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor(red: 215/255, green: 215/255, blue: 215/255, alpha: 1.0).cgColor
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width / 3 - 15, height: UIScreen.main.bounds.height / 4 - 20)
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