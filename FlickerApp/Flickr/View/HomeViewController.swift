//
//  HomeViewController.swift
//  FlickerApp
//
//  Created by Greek1 on 1/27/20.
//  Copyright © 2020 Test. All rights reserved.
//

import UIKit
import SDWebImage

class HomeViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UpdateHomeViewUI{
    @IBOutlet weak var lblDetails: UILabel!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    var flickerViewModelRef : FlickrViewModel!
    var mostRecentPhotosArr = [Photo]()
    var mostInterestingPhotosArr = [Photo1]()
    var selectedIndex = 0
    var loadingData = false
    var pageCount = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView.init(frame: .zero)
        flickerViewModelRef = FlickrViewModel()
        self.tableView.estimatedRowHeight = 150
        self.tableView.rowHeight = UITableView.automaticDimension
        flickerViewModelRef.flickrViewModelDelegate = self
        flickerViewModelRef.apiCallForMostRecentData(p_no:pageCount)
        
    }
    //MARK: - Segment Event
    @IBAction func changeSegmentValue(_ sender: UISegmentedControl) {
        print("sender.selectedSegmentIndex \(sender.selectedSegmentIndex)")
        pageCount = 1
        if sender.selectedSegmentIndex == 0{
            self.mostRecentPhotosArr.removeAll()
            self.tableView.reloadData()
            flickerViewModelRef.apiCallForMostRecentData(p_no:pageCount)
        }else{
            self.mostInterestingPhotosArr.removeAll()
            self.tableView.reloadData()
            flickerViewModelRef.apiCallForMostInterestingData(p_no:pageCount)
        }
    }
    
    //MARK: - Tableview DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectedIndex == 0{
            return mostRecentPhotosArr.count
        }else{
            return mostInterestingPhotosArr.count
        }
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if selectedIndex == 0{
            let lastElement = mostRecentPhotosArr.count - 1
            if !loadingData && indexPath.row == lastElement {
                loadingData = true
                pageCount += 1
                flickerViewModelRef.apiCallForMostRecentData(p_no:pageCount)
            }
        }else{
            let lastElement = mostInterestingPhotosArr.count - 1
            if !loadingData && indexPath.row == lastElement {
                loadingData = true
                pageCount += 1
                flickerViewModelRef.apiCallForMostInterestingData(p_no:pageCount)
            }
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        if selectedIndex == 0{
            let obj = mostRecentPhotosArr[indexPath.row]
            cell.lblTitle.text = obj.title
            let url = URL.init(string: "https://farm\(obj.farm).staticflickr.com/\(obj.server)/\(obj.id)_\(obj.secret)_t_d.jpg")

            cell.imgView.sd_setImage(with: url , placeholderImage: nil)
            return cell
        }else{
            let obj = mostInterestingPhotosArr[indexPath.row]
            cell.lblTitle.text = obj.title
            let url = URL.init(string: "https://farm\(obj.farm).staticflickr.com/\(obj.server)/\(obj.id)_\(obj.secret)_t_d.jpg")

            cell.imgView.sd_setImage(with: url , placeholderImage: nil)
            return cell
        }
    }
    
    //MARK: - UpdateUI Delegate
    func getMostRecentPhotos(responseArr : [Photo]){
        self.mostRecentPhotosArr.append(contentsOf: responseArr)
        print("count is \(self.mostRecentPhotosArr.count)")
        self.selectedIndex = 0
        self.loadingData = false
        self.tableView.reloadData()
    }
    func getMostInterestingPhotos(responseArr : [Photo1]){
        //self.mostInterestingPhotosArr = responseArr
        self.mostInterestingPhotosArr.append(contentsOf: responseArr)
        self.selectedIndex = 1
        self.loadingData = false
        self.tableView.reloadData()
    }

}
