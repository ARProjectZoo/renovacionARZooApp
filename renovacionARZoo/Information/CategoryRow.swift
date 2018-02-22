//
//  CategoryRow.swift
//  TwoDirectionalScroller
//
//  Created by Robert Chen on 7/11/15.
//  Copyright (c) 2015 Thorn Technologies. All rights reserved.
//

import UIKit
import Device

class CategoryRow : UITableViewCell {
    var arrayAnimals : [Animals] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
}

extension CategoryRow : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let arrayAnimals = UserDefaults.standard.array(forKey: "arrayAnimals"){
            
            return arrayAnimals.count
        }else{
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "videoCell", for: indexPath) as! VideoCell
        return cell
    }
    
    
}

extension CategoryRow : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow:CGFloat = checkDeviceScreenSize()
        let hardCodedPadding:CGFloat = 5
        let itemWidth = (collectionView.bounds.width / itemsPerRow) - hardCodedPadding
        let itemHeight = itemWidth
        return CGSize(width: itemWidth, height: itemHeight)
    }
    func checkDeviceScreenSize() -> CGFloat{
        
        switch Device.size() {
        case .screen4Inch:
            print("It's a 4 inch screen");
            return 2
        case .screen4_7Inch:
            print("It's a 4.7 inch screen")
            return 3
        case .screen5_5Inch:
            print("It's a 5.5 inch screen")
            return 3
        case .screen5_8Inch:
            print("It's a 5.8 inch screen")
            return 3
            
        default:
            print("Unknown size")
            return 3
        }
    }
    
    
}
