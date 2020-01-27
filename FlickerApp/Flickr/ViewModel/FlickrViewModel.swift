//
//  FlickrViewModel.swift
//  FlickerApp
//
//  Created by Greek1 on 1/27/20.
//  Copyright © 2020 Test. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol UpdateHomeViewUI : AnyObject {
    func getMostRecentPhotos(responseArr : [Photo])
    func getMostInterestingPhotos(responseArr : [Photo1])
}
class FlickrViewModel: NSObject {
    private var photoResponseArr = [Photo]()
    weak var flickrViewModelDelegate : UpdateHomeViewUI?
    //MARK: -Api Call For MostRecentData
    func apiCallForMostRecentData(p_no:Int)  {
        let urlStr = "https://api.flickr.com/services/rest/?method=flickr.photos.getRecent&api_key=ca370d51a054836007519a00ff4ce59e&per_page=10&format=json&page=\(p_no)&nojsoncallback=1"
        SVProgressHUD.show()
         DispatchQueue.global(qos: .background).async {
            WebServiceHandler.getApiCall_CodableRES(url: urlStr, completion: { (result) in
                DispatchQueue.main.async {
                    SVProgressHUD.dismiss()
                    guard let jsonData = result else{
                        return
                    }

                    let jsonDecoder = JSONDecoder()
                    do {
                         let responseObj = try jsonDecoder.decode(MostRecentPhotoModel.self, from: jsonData)
                       
                        self.photoResponseArr = responseObj.photos.photo
                        self.flickrViewModelDelegate?.getMostRecentPhotos(responseArr: self.photoResponseArr)
                        // print("response \(self.photoResponseArr[0])")
                        
                    }catch{
                        print("not able to decode \(error.localizedDescription)")

                    }

                }
            }) { (error) in
                DispatchQueue.main.async {

                    print("error --- \(error.localizedDescription)")
                }
            }
        }
      
    }
    
    //MARK: -Api Call For Most Interesting
    func apiCallForMostInterestingData(p_no:Int)  {
        let urlStr = "https://api.flickr.com/services/rest/?method=flickr.interestingness.getList&api_key=ca370d51a054836007519a00ff4ce59e&per_page=10&format=json&page=\(p_no)&nojsoncallback=1"
         DispatchQueue.global(qos: .background).async {
            WebServiceHandler.getApiCall_CodableRES(url: urlStr, completion: { (result) in
                DispatchQueue.main.async {
                    guard let jsonData = result else{
                        return
                    }

                    let jsonDecoder = JSONDecoder()
                    do {
                         let responseObj = try jsonDecoder.decode(MostInterestingPhotoModel.self, from: jsonData)
                        print("response \(responseObj)")
                        self.flickrViewModelDelegate?.getMostInterestingPhotos(responseArr: responseObj.photos.photo)
                    }catch{
                        print("not able to decode \(error.localizedDescription)")

                    }

                }
            }) { (error) in
                DispatchQueue.main.async {

                    print("error --- \(error.localizedDescription)")
                }
            }
        }
      
    }
    
}
