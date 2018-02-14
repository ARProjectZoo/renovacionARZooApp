//
//  ViewController.swift
//  ScrollingFollowView
//
//  Created by 田中賢治 on 2016/07/05.
//  Copyright © 2016年 田中賢治. All rights reserved.
//

import UIKit
class ProfileTableViewController: UIViewController, KYButtonDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var profilePictureIV: UIImageView!
    @IBOutlet weak var floatingButton: KYButton!
    @IBOutlet weak var navBarScrollingFollowView: ScrollingFollowView!

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var navBarTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var navBarTitle: UINavigationItem!
    
    @IBOutlet weak var tabBarItemProfile: UITabBarItem!
    
    
    let imagePicker: UIImagePickerController = UIImagePickerController()
    var imagePicked : UIImage!
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        profilePictureIV.layer.cornerRadius = profilePictureIV.frame.size.width / 2
        profilePictureIV.clipsToBounds = true
        tableView.backgroundView = UIImageView(image: #imageLiteral(resourceName: "FondoProfile") )
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
            let navBarHeight: CGFloat = 20
            let statusBarHeight = UIApplication.shared.statusBarFrame.size.height
        
        navBarScrollingFollowView.setup(constraint: navBarTopConstraint, maxFollowPoint: navBarHeight + statusBarHeight, minFollowPoint: 0)
        navBarScrollingFollowView.setupDelayPoints(pointOfStartingHiding: 100, pointOfStartingShowing: 0)
        
        navBarScrollingFollowView.backgroundColor = UIColor.green
        
        floatingButton.kyDelegate = self
        floatingButton.openType = .slideUp
        floatingButton.plusColor = UIColor.green     //  Change plus color
        floatingButton.fabTitleColor = UIColor.black    // Change title color
        floatingButton.add(color: .black, title: "Add", image: #imageLiteral(resourceName: "signo-mas-para-agregar")){(item)
            in
            let alert = UIAlertController(title: "Hello", message: "Are you ok?", preferredStyle: .alert)
            let ok = UIAlertAction(title: "ok", style: .default, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
            
        }
        floatingButton.add(color: .black, title: "Delete", image: #imageLiteral(resourceName: "cruz")) { (item) in
            let alert = UIAlertController(title: "Hello", message: "Are you ok?", preferredStyle: .alert)
            let ok = UIAlertAction(title: "ok", style: .default, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        
        }
        
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
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }

}

extension ProfileTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 150//Choose your custom row height
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayStories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row < 1){
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "storyCell") else { fatalError("Empty Cell") }
            let myCell = cell as! TableViewCell
            myCell.imageCell.image = arrayStories[0].image
            myCell.labelCell.text = arrayStories[0].description
            return myCell
        }else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "storyCell") else { fatalError("Empty Cell") }
            let myCell = cell as! TableViewCell
            myCell.imageCell.image = arrayStories[1].image
            myCell.labelCell.text = arrayStories[1].description
            return myCell
        }
        
        
    }
}

extension ProfileTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
       
    }
}

extension ProfileTableViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        navBarScrollingFollowView.didScroll(scrollView)
        if tableView.contentOffset.y < 100 {
            navBarScrollingFollowView.show(true) {
                print("show")
                self.navBarTitle.title = "Profile"
                self.tabBarItemProfile.badgeColor = #colorLiteral(red: 0.2196078431, green: 0.5568627451, blue: 0.2352941176, alpha: 1)
                
            }
        } else {
            navBarScrollingFollowView.hide(true) {
                print("hide")
            self.tabBarItemProfile.badgeColor = #colorLiteral(red: 0.2196078431, green: 0.5568627451, blue: 0.2352941176, alpha: 1)
                self.navBarTitle.title = ""
            }
        }
        
        navBarScrollingFollowView.resetPreviousPoint(tableView)
    
}
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        navBarScrollingFollowView.didEndScrolling()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        navBarScrollingFollowView.didEndScrolling(decelerate)
    }
}
