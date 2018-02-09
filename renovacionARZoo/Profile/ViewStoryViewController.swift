

import UIKit
import Device

class ViewStoryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    //layout
    @IBOutlet weak var distanceLabelPhoto: NSLayoutConstraint!
    @IBOutlet weak var distancePhotoTF: NSLayoutConstraint!
    @IBOutlet weak var distanceTopLabel: NSLayoutConstraint!
    @IBOutlet weak var distanceButtonBottom: NSLayoutConstraint!
    @IBOutlet weak var distanceTFButton: NSLayoutConstraint!
    
    //view
    @IBOutlet weak var imageStory: UIImageView!
    @IBOutlet weak var labelStory: UITextView!
    
    
  
    
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
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
    
    
  func viewStory(_ sender: UIButton) {
        
        //Create Activity Indicator
        let myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        //Position Activity Indicator in the center of the main view
        myActivityIndicator.center = view.center
        
        //If needed, yo can prevent activity Idicantor from hiing ehen stopAnimating() is called
        myActivityIndicator.hidesWhenStopped = false
        
        //Start Activity Indicator
        myActivityIndicator.startAnimating()
        view.addSubview(myActivityIndicator)
        
        //Send HTTP Request to Register user
//        let myUrl = URL(string:"http://localhost:8888/APIZOORODRIGO/API3/fuelphp/public/Stories/show.json")
//        var request = URLRequest(url:myUrl!)
//        request.httpMethod = "POST"//compose a query string
//        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "content-type")
//        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Accept")
//        
//        let getString = /*"photo="+imageStory.image!+*/"&comment="+labelStory.text!
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
        
}
    
   


