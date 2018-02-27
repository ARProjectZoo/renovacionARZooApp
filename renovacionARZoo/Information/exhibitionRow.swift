
import UIKit
import Device

class exhibitionRow : UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
}

extension exhibitionRow : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "exhibitionCollectionCell", for: indexPath) as! exhibitionCollectionCell
        return cell
    }
    
    
}

extension exhibitionRow : UICollectionViewDelegateFlowLayout {
    
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
