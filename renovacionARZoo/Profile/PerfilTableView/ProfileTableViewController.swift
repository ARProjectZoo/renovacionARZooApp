//
//  ViewController.swift
//  ScrollingFollowView
//
//  Created by 田中賢治 on 2016/07/05.
//  Copyright © 2016年 田中賢治. All rights reserved.
//

import UIKit
import Device
class ProfileTableViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    var numberOfStories = 4
    
    @IBOutlet weak var profilePictureIV: UIImageView!
    @IBOutlet weak var floatingButton: UIButton!
    
    //constrains
    @IBOutlet weak var heightConstraintProfileImageContainer: NSLayoutConstraint!
    
    var storiesArray : [Story] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    @IBOutlet weak var tabBarItemProfile: UITabBarItem!
    
    @IBAction func logOut(_ sender: Any) {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
        UserDefaults.standard.set(false, forKey: "status")
        UserDefaults.standard.synchronize()
        Switcher.updateRootVC()
    }
    
    func checkDeviceScreenSize(){
        
        switch Device.size() {
        case .screen4Inch:
            print("It's a 4 inch screen");
           print(heightConstraintProfileImageContainer.constant)
            heightConstraintProfileImageContainer.constant = 150
            print(heightConstraintProfileImageContainer.constant)
        case .screen4_7Inch:
            print("It's a 4.7 inch screen")
           
            heightConstraintProfileImageContainer.constant = 150
        case .screen5_5Inch:
            print("It's a 5.5 inch screen")
            heightConstraintProfileImageContainer.constant = 250
        case .screen5_8Inch:
            heightConstraintProfileImageContainer.constant = 250
            print("It's a 5.8 inch screen")
            
            
        default:
            print("Unknown size")
           
        }
    }
    
    let imagePicker: UIImagePickerController = UIImagePickerController()
    var imagePicked : UIImage!
    let myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkDeviceScreenSize()
        if let stories = UserDefaults.standard.array(forKey: "stories"){
            storiesArray = stories as! [Story]
        }else{
            storiesArray = []
        }
        imagePicker.delegate = self
        profilePictureIV.layer.cornerRadius = profilePictureIV.frame.size.width / 2
        profilePictureIV.clipsToBounds = true
        floatingButton.setImage(#imageLiteral(resourceName: "signo-mas-para-agregar"), for: .normal)
        
        
        //Position Activity Indicator in the center of the main view
        myActivityIndicator.center = view.center
        
        //If needed, yo can prevent activity Idicantor from hiing ehen stopAnimating() is called
        myActivityIndicator.hidesWhenStopped = true
        
        //Start Activity Indicator
        myActivityIndicator.startAnimating()
        view.addSubview(myActivityIndicator)
        myActivityIndicator.stopAnimating()
    }
    
    @IBAction func changeProfilePicture(_ sender: Any) {
        let alertView = UIAlertController(title: "Image", message: "Do you want take photo or choose in your gallery?", preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) {
            (action) in
        }
        let gallery = UIAlertAction(title: "Gallery", style: .default) {
            (action) in self.selectPhoto()
        }
        let camera = UIAlertAction(title: "Camera", style: .default) {
            (action) in  self.takePhoto()
        }
        alertView.addAction(camera)
        alertView.addAction(gallery)
        alertView.addAction(cancel)
        present(alertView, animated: true, completion: nil)
    }
    
    func takePhoto() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            if UIImagePickerController.availableCaptureModes(for: .rear) != nil {
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .camera
                imagePicker.cameraCaptureMode = .photo
                
                present(imagePicker, animated: true, completion: nil)
            }
        }
        else
        {
            //NO camera
            print("no hay camera")
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .photoLibrary
                
                present(imagePicker, animated: true, completion: nil)
                
            }
        }
    }
    func selectPhoto() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            imagePicker.allowsEditing = false
            imagePicker.sourceType = .photoLibrary
            
            present(imagePicker, animated: true, completion: nil)
            
        }
        
    }
    
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let selectedImage: UIImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            profilePictureIV.image = selectedImage
            if imagePicker.sourceType == .camera {
                UIImageWriteToSavedPhotosAlbum(selectedImage, nil, nil, nil)
            }
            imagePicked = selectedImage
            myActivityIndicator.startAnimating()
            Request(view: self, myActivityIndicator: myActivityIndicator).chageProfilePicture(imageToUpload: selectedImage)
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
}
extension ProfileTableViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(arrayStories.count < 1){
            return 1
        }else{
            return arrayStories.count
        }
    }
        
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(numberOfStories == 0){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "noStoryCell", for: indexPath)
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "storyCell", for: indexPath) as! StoryCollectionViewCell
            //cell.imageStoryCell.image = arrayStories[indexPath.row].image
            return cell
        }
    }
}

extension ProfileTableViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow:CGFloat = 1
        let hardCodedPadding:CGFloat = 5
        let itemWidth = (collectionView.bounds.width / itemsPerRow) - hardCodedPadding
        let itemHeight = itemWidth
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let item = sender as? UICollectionViewCell
//        let indexPath = collectionView.indexPath(for: item!)
//        let detailVC = segue.destination as! StoryCreateViewController
//        detailVC.storyToDetail = storiesArray[(indexPath?.row)!]
//        detailVC.detailDescription = storiesArray[(indexPath?.row)!].description
    }
}
