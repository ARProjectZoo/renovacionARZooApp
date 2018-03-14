//
//  AnimalListViewController.swift
//  renovacionARZoo
//
//  Created by Kike on 21/2/18.
//  Copyright © 2018 Kike. All rights reserved.
//

import UIKit
import Device
class AnimalListViewController: UIViewController {

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
    
    extension AnimalListViewController : UICollectionViewDataSource {
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            print("ARRAYANIMALS:COUNT\(arrayAnimals.count)")
            return arrayAnimals.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "animalListCell", for: indexPath) as! AnimalListUICollectionViewCell
            cell.imageView.image = arrayAnimals[indexPath.row].image
            cell.labelText.text = arrayAnimals[indexPath.row].name
            return cell
        }
        
        
    }
    
    extension AnimalListViewController : UICollectionViewDelegateFlowLayout {
        
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
        
        
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
