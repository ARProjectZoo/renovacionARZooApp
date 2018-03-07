//
//  StoryCreateViewController.swift
//  renovacionARZoo
//
//  Created by Kike on 14/2/18.
//  Copyright © 2018 Kike. All rights reserved.
//

import UIKit
import Device
class StoryCreateViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    let myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    @IBOutlet weak var imageStoryCreate: UIImageView!
    @IBOutlet weak var commentStoryCreate: UITextField!
    
    
    
    //ADDBUTTON
    

    @IBAction func addStoryButton(_ sender: Any) {
        Request(view: self, myActivityIndicator: myActivityIndicator).uploadStory(imageToUpload: imageStoryCreate.image!, comment: commentStoryCreate.text!)
    }
    
     //CONSTRAINTS
    @IBOutlet weak var imageTopConstraint: NSLayoutConstraint!
    var storyToDetail : Story!
    //camera
    let imagePicker: UIImagePickerController = UIImagePickerController()
    var imagePicked : UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Position Activity Indicator in the center of the main view
        myActivityIndicator.center = view.center
        
        //If needed, yo can prevent activity Idicantor from hiing ehen stopAnimating() is called
        myActivityIndicator.hidesWhenStopped = false
        
        //Start Activity Indicator
        myActivityIndicator.startAnimating()
        view.addSubview(myActivityIndicator)
        checkDeviceScreenSize()
        imagePicker.delegate = self
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkDeviceScreenSize() {
        
        switch Device.size() {
        case .screen4Inch:
            print("It's a 4 inch screen");
            screen4Inch()
        case .screen4_7Inch:
            print("It's a 4.7 inch screen")
            screen4_7Inch()
        case .screen5_5Inch:
            print("It's a 5.5 inch screen")
            screen5_5Inch()
        case .screen5_8Inch:
            print("It's a 5.8 inch screen")
            screen5_8Inch()
            
        default:
            print("Unknown size")
        }
    }
    func screen4Inch () {
        //perfect
        imageTopConstraint.constant = 30
       
    }
    func screen4_7Inch () {
        //perfect
        
    }
    func screen5_5Inch (){
        //perfect
        
    }
    func screen5_8Inch (){
        //perfect
        
        
    }
    

    @IBAction func changeImage(_ sender: Any) {
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
            imageStoryCreate.image = selectedImage
            if imagePicker.sourceType == .camera {
                UIImageWriteToSavedPhotosAlbum(selectedImage, nil, nil, nil)
            }
            imagePicked = selectedImage
        }
        imagePicker.dismiss(animated: true, completion: nil)
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
