
import UIKit
import Device
import Alamofire
class CreateStoryViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate,UIAlertViewDelegate {

    //layaout
    @IBOutlet weak var distanceLabelPhoto: NSLayoutConstraint!
    @IBOutlet weak var distancePhotoTF: NSLayoutConstraint!
    @IBOutlet weak var distanceTopLabel: NSLayoutConstraint!
    @IBOutlet weak var distanceButtonBottom: NSLayoutConstraint!
    @IBOutlet weak var distanceTFButton: NSLayoutConstraint!
    //botones
    @IBOutlet weak var buttonSave: UIButton!
    @IBOutlet weak var back: UIButton!
    //peticiones
    
    @IBOutlet weak var imageStory: UIImageView!
    @IBOutlet weak var commentTF: UITextField!
    //camera
    let imagePicker: UIImagePickerController = UIImagePickerController()
    var imagePicked : UIImage!

    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonSave.layer.cornerRadius = 10
        imageStory.image = #imageLiteral(resourceName: "Fondo")
        imagePicker.delegate = self
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
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
    
    
    
    //tamaños pantalla
    func screen4Inch () {
        distanceTopLabel.constant = 20
        distanceLabelPhoto.constant = 20
        distancePhotoTF.constant = 20
        distanceTFButton.constant = 20
        distanceButtonBottom.constant = 20
    }
    func screen4_7Inch () {
        distanceTopLabel.constant = 40
        distanceLabelPhoto.constant = 40
        distancePhotoTF.constant = 40
        distanceTFButton.constant = 50
        distanceButtonBottom.constant = 50
    }
    func screen5_5Inch (){
        
        distanceTopLabel.constant = 40
        distanceLabelPhoto.constant = 40
        distancePhotoTF.constant = 60
        distanceTFButton.constant = 70
        distanceButtonBottom.constant = 70
    }
    func screen5_8Inch (){
        
        distanceTopLabel.constant = 25
        distanceLabelPhoto.constant = 45
        distancePhotoTF.constant = 90
        distanceTFButton.constant = 100
        distanceButtonBottom.constant = 100
        
    }
    
    
    @IBAction func saveStory(_ sender: UIButton) {
        
        if(commentTF == nil)
        {
            showAlert(message: "Write description", view : self )
            return
        }
        //Create Activity Indicator
        let myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        //Position Activity Indicator in the center of the main view
        myActivityIndicator.center = view.center
        
        //If needed, yo can prevent activity Idicantor from hiing ehen stopAnimating() is called
        myActivityIndicator.hidesWhenStopped = false
        
        //Start Activity Indicator
        myActivityIndicator.startAnimating()
        view.addSubview(myActivityIndicator)
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let currentDate = formatter.string(from: date)
        let parameters : Parameters = [
            "comment" : "commentTF.text",
            "date" : currentDate
        ]
        if(imagePicked != nil){
            //ZooRequest(view: self, myActivityIndicator: myActivityIndicator).createStories(parameters: parameters, selectedImage: imagePicked)//Send HTTP Request to Register user
        }else{
            print("foto vacia")
        }
        
//        let myUrl = URL(string:"http://localhost:8888/APIZOORODRIGO/API3/fuelphp/public/Stories/create.json")
//        var request = URLRequest(url:myUrl!)
//        request.httpMethod = "POST"//compose a query string
//        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "content-type")
//        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Accept")
//
//        let postString = /*"photo="+imageStory.textInputMode!+*/"&comment="+commentTF.text!+"&date="
//        request.httpBody = postString.data(using: .utf8)
//
//        let task = URLSession.shared.dataTask(with: request)
//        {
//            (data: Data?, response: URLResponse?, error: Error?) in
//
//            removeActivityIndicator(activityIndicator: myActivityIndicator)
//
//            if error != nil
//            {
//                showAlert(message: "Could not successfully perform this request. Please try again later", view : self)
//
//                print("error=\(String(describing: error))")
//            }
//
//            // RESPONSE sent from a server side code to NSDictionary object:
//            do{
//                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
//
//                if let parseJSON = json {
//                    let code = parseJSON["code"] as! Int
//                    switch code {
//                    case let (code) where code == 201:
//                        print("Creado")
//                        showAlert(message: "Registrado", view : self)
//                        break
//                    case let (code) where code == 400:
//                        print("Algun parametro esta vacio")
//                        //showAlert(message: "Please try again")
//                        break
//                    case let (code) where code == 400:
//                        print("Algun parametro esta vacio")
//                        //showAlert(message: "Please try again")
//                        break
//                    case let (code) where code == 500:
//                        print("Error de servidor ")
//                        //showAlert(message: "Please try again")
//                        break
//                    default :
//                        print("Please try again")
//                        //showAlert(message: "Please try again")
//                        break
//                    }
//                }
//            }catch{
//                removeActivityIndicator(activityIndicator: myActivityIndicator)
//                //showAlert(message: "Please try again")
//                print(error)
//            }
//        }
//        task.resume()
    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    //camera
    
    @IBAction func addPhoto(_ sender: Any) {
      
        let alertView = UIAlertController(title: "Image", message: "Do you want take photo or choose in your gallery?", preferredStyle: .actionSheet)
        let gallery = UIAlertAction(title: "Cancel", style: .default) {
            (action) in self.dismiss(animated: true, completion: nil)
        }
        let camera = UIAlertAction(title: "Gallery", style: .default) {
            (action) in self.selectPhoto()
        }
        let cancel = UIAlertAction(title: "Camera", style: .default) {
            (action) in  self.takePhoto()
        }
        alertView.addAction(cancel)
        alertView.addAction(camera)
        alertView.addAction(gallery)
        present(alertView, animated: true, completion: nil)
        
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
        if let selectedImage: UIImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageStory.image = selectedImage
            if imagePicker.sourceType == .camera {
                UIImageWriteToSavedPhotosAlbum(selectedImage, nil, nil, nil)
            }
            imagePicked = selectedImage
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
}

    
    
    

