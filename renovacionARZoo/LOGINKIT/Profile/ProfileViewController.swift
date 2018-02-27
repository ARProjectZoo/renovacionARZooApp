

import UIKit
import ZAlertView
import Device
import AVFoundation
import Alamofire

class ProfileViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate,UIAlertViewDelegate {
    
    //variables
    var isActive = true
    
    //outlets

    @IBOutlet weak var collection: UICollectionView!
    
    
    //label
    @IBOutlet weak var nameLabel: UILabel!
    
    
    //layaout
    @IBOutlet weak var distanceLabelCollection: NSLayoutConstraint!
    @IBOutlet weak var distancetopMobile: NSLayoutConstraint!
    @IBOutlet weak var distanceLabels: NSLayoutConstraint!
    @IBOutlet weak var distanceButtonName: NSLayoutConstraint!
    @IBOutlet weak var distanceBottom: NSLayoutConstraint!

    var myArrayProfile: [UIImage] = [#imageLiteral(resourceName: "fotousuario")]
    //camara
    let imagePicker: UIImagePickerController = UIImagePickerController()
    @IBOutlet weak var imageProfile: UIImageView!
    
    //tamaños pantalla
    func myFunc() {
        
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
        
        distanceBottom.constant = 20
        distanceLabels.constant = 30
        distanceButtonName.constant = 20
    }
    func screen4_7Inch () {
        //perfect
        distanceLabels.constant = 40
        distancetopMobile.constant = 40
        distanceLabelCollection.constant = 40
        distanceButtonName.constant = 40
    }
    func screen5_5Inch (){
        //perfect
        distanceLabels.constant = 90
        distancetopMobile.constant = 50
        distanceLabelCollection.constant = 40
        distanceButtonName.constant = 40
    }
    func screen5_8Inch (){
        //perfect
        distanceLabelCollection.constant = 40
        distanceButtonName.constant = 40
        distanceLabels.constant = 100
        distancetopMobile.constant = 50
        
    }
    
    
    //popup
    let dialog = ZAlertView()
        public var screenWidth: CGFloat{
            return UIScreen.main.bounds.width
        }
        public var screenHeight: CGFloat{
            return UIScreen.main.bounds.height
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collection.dataSource = self
        collection.delegate = self
        imagePicker.delegate = self
        
        myFunc()
    }

    
    
    
    //esto es para el nombre
    override func viewWillAppear(_ animated: Bool) {
        //Create Activity Indicator
        let myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        //Position Activity Indicator in the center of the main view
        myActivityIndicator.center = view.center
        
        //If needed, yo can prevent activity Idicantor from hiing ehen stopAnimating() is called
        myActivityIndicator.hidesWhenStopped = false
        
        //Start Activity Indicator
        myActivityIndicator.startAnimating()
        view.addSubview(myActivityIndicator)
        
        ZooRequest(view: self, myActivityIndicator: myActivityIndicator).infoUser(nameLabel : nameLabel)
        let parameters : Parameters = [:]
        //ZooRequest(view: self, myActivityIndicator: myActivityIndicator).showStories(parameters: parameters)
        //ZooRequest(view: self, myActivityIndicator: myActivityIndicator).getImagesFromServer()
        //Send HTTP Request to Register user
//        let myUrl = URL(string:"http://localhost:8888/APIZOORODRIGO/API3/fuelphp/public/Users/show.json")
//        var request = URLRequest(url:myUrl!)
//        request.httpMethod = "GET"//compose a query string
//        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "content-type")
//        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Accept")
//
//        let getString = "userName="+nameLabel.text!
//        request.httpBody = getString.data(using: .utf8)
//
//        let task = URLSession.shared.dataTask(with: request)
//        {
//            (data: Data?, response: URLResponse?, error: Error?) in
//
//            removeActivityIndicator(activityIndicator: myActivityIndicator)
//
//            if error != nil
//            {
//                showAlert(message: "Could not successfully perform this request. Please try again later", view : self )
//                print("error=\(String(describing: error))")
//            }
//
//            // RESPONSE sent from a server side code to NSDictionary object:
//            do{
//                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
//
//                if let parseJSON = json {
//
//                    let code = parseJSON["code"] as! Int
//                    switch code {
//                    case let (code) where code == 200:
//                        print("Has obtenido el nombre")
//                        print(parseJSON["token"] as! String)
//                        UserDefaults.standard.set(parseJSON["token"] as! String, forKey: "token")
//                        break
//                    case let (code) where code == 400:
//                        print("Please try again")
//                        break
//                    case let (code) where code == 500:
//                        print("Error del servidor")
//                        break
//                    default :
//                        print("Please try again")
//                        break
//                    }
//                }
//            }catch{
//                removeActivityIndicator(activityIndicator: myActivityIndicator)
//                showAlert(message: "Could not successfully perform this request. Please try again later", view : self )
//                print(error)
//            }
//        }
//        task.resume()
    }
    
    
    
    
    //imagenes del cell
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayStoriesUser.count+5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellStory", for: indexPath) as! CellStory
        if(indexPath.row == 0){
            cell.imgImage.image = #imageLiteral(resourceName: "fondo2")
        }else{
            cell.imgImage.image = #imageLiteral(resourceName: "fondo2")
        }
        
        return cell
    }
    
    
    
    
    
    
    
    //boton foto
    @IBAction func btnProfile(_ sender: Any) {
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
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            //redirecion charge
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let editViewController = storyBoard.instantiateViewController(withIdentifier: "edit")
            self.present(editViewController, animated: true, completion: nil)
        }
        else
        {
            //redireccion View
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let viewViewController = storyBoard.instantiateViewController(withIdentifier: "viewStory")
            self.present(viewViewController, animated: true, completion: nil)
        }
        
    }
    
    
    
        
    
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    //camera
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
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let selectImage: UIImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageProfile.image = selectImage
            if imagePicker.sourceType == .camera {
                UIImageWriteToSavedPhotosAlbum(selectImage, nil, nil, nil)
            }
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
}
