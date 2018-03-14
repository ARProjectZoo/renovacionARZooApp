//
//  StoryCollectionViewController.swift
//  renovacionARZoo
//
//  Created by Kike on 14/2/18.
//  Copyright © 2018 Kike. All rights reserved.
//

import UIKit
import Device
class StoryCollectionViewController: UIViewController, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
}
extension StoryCollectionViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayStories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "storyCollectionCell", for: indexPath) as! StoryCollectionViewCell
        cell.imageStoryCell.image = arrayStories[indexPath.row].image
        return cell
    }
    
    
}

extension StoryCollectionViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow:CGFloat = checkDeviceScreenSize()
        let hardCodedPadding:CGFloat = 10
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
            return 2
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
