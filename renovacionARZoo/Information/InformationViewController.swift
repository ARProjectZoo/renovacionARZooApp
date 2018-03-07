//
//  InformationViewController.swift
//  renovacionARZoo
//
//  Created by Kike on 20/2/18.
//  Copyright © 2018 Kike. All rights reserved.
//

import UIKit
import Device

class InformationViewController: UIViewController {
 let fileManager = FileManager.default
     var categories = ["Animales", "Eventos", "Restaurantes"]
    var elemts : [Elements]!
    @IBOutlet weak var tableView: UITableView!
    
    let myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)

    
        override func viewDidLoad() {
        super.viewDidLoad()
            
            //Position Activity Indicator in the center of the main view
            myActivityIndicator.center = view.center
            
            //If needed, yo can prevent activity Idicantor from hiing ehen stopAnimating() is called
            myActivityIndicator.hidesWhenStopped = false
            
            //Start Activity Indicator
            myActivityIndicator.startAnimating()
            view.addSubview(myActivityIndicator)
            tableView.backgroundView?.alpha = 0
            Request(view: self, myActivityIndicator: myActivityIndicator).getAnimalJson()
            Request(view: self, myActivityIndicator: myActivityIndicator).getStoriesFromUser()
            elemts = arrayElements
//            do {
//                let items = try fileManager.contentsOfDirectory(atPath: UserDefaults.standard.string(forKey: "arrayAnimalesPath")!)
//                
//                for item in items {
//                    print("Found \(item)")
//                }
//            } catch {
//                // failed to read directory – bad permissions, perhaps?
//            }
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        elemts = arrayElements
        print(elemts)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkDeviceScreenSize() -> CGFloat{
        
        switch Device.size() {
        case .screen4Inch:
            print("It's a 4 inch screen");
            return 150
        case .screen4_7Inch:
            print("It's a 4.7 inch screen")
            return 170
        case .screen5_5Inch:
            print("It's a 5.5 inch screen")
            return 220
        case .screen5_8Inch:
            print("It's a 5.8 inch screen")
            return 250
            
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

extension InformationViewController : UITableViewDelegate { }

extension InformationViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return checkDeviceScreenSize()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell") as! tableViewRow
        cell.imageToShow.layer.masksToBounds = false
        cell.imageToShow.layer.cornerRadius = 10
        cell.imageToShow.clipsToBounds = true
        
        
        //shadows
        cell.shadowView.layer.shadowOpacity = 0.5
        cell.shadowView.layer.shadowColor = UIColor.gray.cgColor
        cell.shadowView.layer.shadowOffset = CGSize(width: 15, height: 3)
        cell.shadowView.layer.shadowRadius = 7
        
        
        if(indexPath.row == 0){
            cell.imageToShow.image = #imageLiteral(resourceName: "tigre-bengala-asia")
            cell.mainTextLabel.text = "Animales"
            cell.secondaryTextLabel.text = "Busca tu animal favorito...¡Y SIGUELÓ!"
        }else if(indexPath.row == 1){
            cell.imageToShow.image = #imageLiteral(resourceName: "reno-europa")
            cell.mainTextLabel.text = "Exhibiciones"
            cell.secondaryTextLabel.text = "Consulta las exhibiciones del zoo para hoy"
            
        }else if(indexPath.row == 2){
            cell.imageToShow.image = #imageLiteral(resourceName: "gradientBG")
            cell.mainTextLabel.text = "Restaurantes"
            cell.secondaryTextLabel.text = "Una magnifica carta de resturantes del zoo"
            
        }
        return cell
    }
    
}
