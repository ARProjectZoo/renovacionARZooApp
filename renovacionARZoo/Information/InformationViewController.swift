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
    
    @IBOutlet weak var tableView: UITableView!
    
        override func viewDidLoad() {
        super.viewDidLoad()
            tableView.backgroundView?.alpha = 0
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categories[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == 0){
            print("INDEXPATH ===== 0::::::::::::")
            let cell = tableView.dequeueReusableCell(withIdentifier: "continentsCell") as! AnimalsRow
            return cell
        }else if(indexPath.section == 1){
             print("INDEXPATH ===== 1::::::::::::")
            let cell = tableView.dequeueReusableCell(withIdentifier: "exhibitionCell") as! exhibitionRow
            return cell
        }else {
             print("INDEXPATH ===== 2::::::::::::")
            let cell = tableView.dequeueReusableCell(withIdentifier: "eventsCell") as! eventsRow
            return cell
        }
    }
    
}
