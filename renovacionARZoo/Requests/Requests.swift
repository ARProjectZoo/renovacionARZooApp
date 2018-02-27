//
//  Requests.swift
//  ReproductorMusicaJulio
//
//  Created by Kike on 31/1/18.
//  Copyright © 2018 julio. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

let mainURL = "http://localhost:8888/CAMBIOAPI/public"
class Request {
    let view : UIViewController
    let myActivityIndicator : UIActivityIndicatorView
    let headers : HTTPHeaders
    let mainCoordinator : LoginCoordinator
    
    init(view : UIViewController, myActivityIndicator : UIActivityIndicatorView, mainCoordinator: LoginCoordinator) {
        self.mainCoordinator = mainCoordinator
        let tokenSaved : String!
        if(UserDefaults.standard.string(forKey: "token") != nil){
            tokenSaved = UserDefaults.standard.string(forKey: "token")
        }else{
            tokenSaved = ""
        }
        self.headers = [
            "Authorization": tokenSaved,
            "Accept": "application/json"
        ]
        self.myActivityIndicator = myActivityIndicator
        self.view = view
    }
    
    public func logIn(parameters : Parameters){
        
        let urlRequest = mainURL + "/Users/login.json"
        
        Alamofire.request(urlRequest, method : .post, parameters : parameters, headers : self.headers).responseJSON { response in
            //debugPrint(response)
            if let json = response.result.value {
                let data = Responses(json: (json as! NSDictionary) as! [String : Any])
                removeActivityIndicator(activityIndicator: self.myActivityIndicator)
                switch(data.code){
                case 200:
                    let recivedData = data.data as! NSDictionary
                    print(recivedData)
                    UserDefaults.standard.set(recivedData["token"] as! String, forKey: "token")
                    
                    DispatchQueue.main.async {
                        self.getAnimalJson()
                        let storyboard: UIStoryboard =   UIStoryboard (name: "Main", bundle: nil)
                        let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "mainAPP") as UIViewController
                        self.view.present(vc ,animated: true, completion: nil )
                    }
                    break
                case 400:
                    print("API ::: \(data.message)")
                    break
                default:
                    break
                }
                
            }
        }
    }
    
    public func register(parameters : Parameters, mainView : UIViewController){
        let urlRequest = mainURL + "/Users/register.json"
        Alamofire.request(urlRequest, method : .post, parameters : parameters, headers : self.headers).responseJSON { response in
            debugPrint(response)
            
            if let json = response.result.value {
                let data = Responses(json: (json as! NSDictionary) as! [String : Any])
                removeActivityIndicator(activityIndicator: self.myActivityIndicator)
                switch(data.code){
                case 201:
                    let recivedData = data.data as! NSDictionary
                    print(recivedData)
                    self.mainCoordinator.backToLogin()
                    break
                case 400:
                    print("API ::: \(data.message)")
                    break
                default:
                    break
                }
                
            }
        }
    }
    
    public func forgotPassword(parameters : Parameters){
        var requestOk : Bool = false
        let urlRequest = mainURL + "/Users/forgotPassword.json"
        Alamofire.request(urlRequest, method : .post, parameters : parameters, headers : self.headers).responseJSON { response in
            debugPrint(response)
            if let json = response.result.value {
                let data = Responses(json: (json as! NSDictionary) as! [String : Any])
                removeActivityIndicator(activityIndicator: self.myActivityIndicator)
                switch(data.code){
                case 200:
                    let recivedData = (data.data as! Dictionary<String,Any>)
                    print(recivedData)
                    UserDefaults.standard.set(recivedData["token"] as! String, forKey: "token")
                    requestOk = true
                    self.mainCoordinator.goToChangePassword()
                    print("REQUEST:::\(requestOk)")
                    break
                case 400...500:
                    requestOk = false
                    print("API ::: \(data.message)")
                    break
                default:
                    requestOk = false
                    UserDefaults.standard.set(requestOk , forKey: "requestStatus")
                    break
                }
            }
        }
    }
    
    public func changePassword(parameters : Parameters){
        let urlRequest = mainURL + "/Users/changePassword.json"
        Alamofire.request(urlRequest, method : .post, parameters : parameters, headers : self.headers).responseJSON { response in
            debugPrint(response)
            if let json = response.result.value {
                let data = Responses(json: (json as! NSDictionary) as! [String : Any])
                removeActivityIndicator(activityIndicator: self.myActivityIndicator)
                switch(data.code){
                case 200:
                    let recivedData = data.data as! NSDictionary
                    self.mainCoordinator.backToLogin()
                    print(recivedData)
                    break
                case 400:
                    print("API ::: \(data.message)")
                    break
                default:
                    break
                }
            }
        }
    }
    
    public func chageProfilePicture(imageToUpload : UIImage, urlToAttack : String){
        let urlRequest = mainURL + urlToAttack
        let imgData = UIImageJPEGRepresentation(imageToUpload, 0.2)!
        let parameters : Parameters = ["photo" : imgData]
        
        Alamofire.upload(
                multipartFormData: { multipartFormData in
                        // On the PHP side you can retrive the image using $_FILES["image"]["tmp_name"]
                    multipartFormData.append(imgData, withName: "image")
                        for (key, val) in parameters {
                            multipartFormData.append((val as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                    }
                },
                to: urlRequest,
                encodingCompletion: { encodingResult in
                    switch encodingResult {
                    case .success(let upload, _, _):
                        upload.responseJSON { response in
                            if let jsonResponse = response.result.value as? [String: Any] {
                                print(jsonResponse)
                            }
                        }
                    case .failure(let encodingError):
                        print(encodingError)
                }
            }
        )
    }
    
    public func getAnimalJson(){
        let urlRequest = mainURL + "/Animals/download.json"
        var token = ""
        if(UserDefaults.standard.string(forKey: "token") != nil){
            token = UserDefaults.standard.string(forKey: "token")!
        }else{
            token = ""
        }
        let header = [
            "Authorization": token,
            "Accept": "application/json"
        ]
        Alamofire.request(urlRequest, method : .get, headers : header).responseJSON{ response in
          //  debugPrint(response)
            print("RESULT :: \(response.result)")
            if let json = response.result.value {
                let data = Responses(json: (json as! NSDictionary) as! [String : Any])
                let array  = data.data
                
                
                print("---------------------------------------------------------")
                print("JSON DEVUELto:::::::: \(array)")
                print("---------------------------------------------------------")
                removeActivityIndicator(activityIndicator: self.myActivityIndicator)
                switch(data.code){
                case 200:
                    var arrayAnimals : [Animals] = []
                    let recivedData = data.data as! NSArray
//                    for animal in recivedData {
//                        var animalTosave = Animals()
//                        let dataFromAnimal = animal as! NSDictionary
//                        for (key, value) in dataFromAnimal{
//                            if((key as! String) == "description"){
//                                animalTosave.descriptionAnimal = value as! String
//                            }
//                            if((key as! String) == "id"){
//                                animalTosave.id = value as! Int
//                            }
//                            if((key as! String) == "id_continent"){
//                                animalTosave.continent = Int(value as! String)!
//                            }
//                            if((key as! String) == "name"){
//                               animalTosave.name = value as! String
//                            }
//                            if((key as! String) == "photo"){
//                                animalTosave.image = value as! String
//                            }
//                            if((key as! String) == "x"){
//                                animalTosave.x = Float(value as! String)!
//                            }
//                            if((key as! String) == "y"){
//                                animalTosave.y = Float(value as! String)!
//
//                            }
//
//                        }
//                        arrayAnimals.append(animalTosave)
//                    }
                    //self.saveDataToFile(arrayAnimals: data.data as! Data)

                    break
                case 400:
                    print("API ::: \(data.message)")
                    break
                default:
                    break
                }
            }
        }
    }
    
    private func saveDataToFile(arrayAnimals : Data){
        let filemgr = FileManager.default
        let animalesArrayPath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("arrayAnimales.plist")
        UserDefaults.standard.setValue(animalesArrayPath, forKey: "arrayAnimalesPath")
        UserDefaults.standard.synchronize()
        
        if filemgr.fileExists(atPath: animalesArrayPath) {
            print("File exists")
            if filemgr.contentsEqual(atPath: animalesArrayPath, andPath: animalesArrayPath) {
                print("File contents match, NO SE CAMBIAN YA ACTUALIZADO")
            } else {
                print("File contents do not match, NO ACTUALIZADO SE CAMBIA")
                let encodedData = NSKeyedArchiver.archivedData(withRootObject: arrayAnimals)
                filemgr.createFile(atPath: animalesArrayPath, contents: encodedData,
                                   attributes: nil)
                
                
            }
            
        } else {
            print("File not found")
            let encodedData = NSKeyedArchiver.archivedData(withRootObject: arrayAnimals)
            filemgr.createFile(atPath: animalesArrayPath, contents: encodedData,
                               attributes: nil)
        }
        
    }
}

