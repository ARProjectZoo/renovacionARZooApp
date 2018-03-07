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
    var headers : HTTPHeaders
    
    init(view : UIViewController, myActivityIndicator : UIActivityIndicatorView) {
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
            debugPrint(response)
            if let json = response.result.value {
                let data = Responses(json: (json as! NSDictionary) as! [String : Any])
                removeActivityIndicator(activityIndicator: self.myActivityIndicator)
                switch(data.code){
                    
                case 200:
                    let recivedData = data.data as! NSDictionary
                    print(recivedData)
                    UserDefaults.standard.set(recivedData["token"] as! String, forKey: "token")
                    
                    DispatchQueue.main.async {
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
    
    public func register(parameters : Parameters, mainView : UIViewController, mainCoordinator : LoginCoordinator){
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
                    mainCoordinator.backToLogin()
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
    
    public func forgotPassword(parameters : Parameters, mainCoordinator : LoginCoordinator){
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
                    mainCoordinator.goToChangePassword()
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
    
    public func changePassword(parameters : Parameters, mainCoordinator : LoginCoordinator){
        let urlRequest = mainURL + "/Users/changePassword.json"
        Alamofire.request(urlRequest, method : .post, parameters : parameters, headers : self.headers).responseJSON { response in
            debugPrint(response)
            if let json = response.result.value {
                let data = Responses(json: (json as! NSDictionary) as! [String : Any])
                removeActivityIndicator(activityIndicator: self.myActivityIndicator)
                switch(data.code){
                case 200:
                    let recivedData = data.data as! NSDictionary
                    mainCoordinator.backToLogin()
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
    
    public func chageProfilePicture(imageToUpload : UIImage){
        let urlRequest = mainURL + "/Users/changeImage.json"
        let imgData = UIImageJPEGRepresentation(imageToUpload, 0.2)!
        print(":::::::IMAGEDATA::::::::\(imgData)")
        let parameters : Parameters = ["photo" : "imgData"]
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            multipartFormData.append(imgData, withName: "photo_path",fileName: "file.jpg", mimeType: "image/jpeg")
//            for(key, value) in parameters{
//                multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
//            }
        }, to: urlRequest, headers : headers)
        { (result) in
            removeActivityIndicator(activityIndicator: self.myActivityIndicator)
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (Progress) in
                    print("Upload Progress: \(Progress.fractionCompleted)")
                })
                
                upload.responseJSON { response in
                    //self.delegate?.showSuccessAlert()
                    print(":::RESQUEST:::\(response.request)")  // original URL request
                    print(":::::RESPONSE:::::\(response.response)") // URL response
                    print(":::::DATA:::\(response.data)")     // server data
                    print(":::::RESULT:::::\(response.result)")   // result of response serialization
                    //                        self.showSuccesAlert()
                    //self.removeImage("frame", fileExtension: "txt")
                    if let JSON = response.result.value {
                        var parseJson = response.result.value as! NSDictionary
                        print(UserDefaults.standard.string(forKey: "token"))
                        UserDefaults.standard.set(parseJson["data"] as! String, forKey: "token")
                        UserDefaults.standard.synchronize()
                         print(UserDefaults.standard.string(forKey: "token"))
                    }
                }
                
            case .failure(let encodingError):
                //self.delegate?.showFailAlert()
                print(encodingError)
            }
            
        }

    }
    
    public func uploadStory(imageToUpload : UIImage, comment : String){
        var urlRequest = mainURL + "/Stories/create.json"
        urlRequest = urlRequest.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!
        let imgData = UIImageJPEGRepresentation(imageToUpload, 0.2)!
        print(":::::::IMAGEDATA::::::::\(imgData)")
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let result = formatter.string(from: date)
        
        let parameters : Parameters = ["comment" : comment,
                                       "date" : result]
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            multipartFormData.append(imgData, withName: "photo_path", fileName: "file.jpg", mimeType: "image/jpeg")
            for(key, value) in parameters
            {
                multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
            }
        }, to: urlRequest, headers : headers)
        { (result) in
            removeActivityIndicator(activityIndicator: self.myActivityIndicator)
            debugPrint(result)
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (Progress) in
                    print("Upload Progress: \(Progress.fractionCompleted)")
                })
                
                upload.responseJSON { response in
                    //self.delegate?.showSuccessAlert()
                    print(":::RESQUEST:::\(response.request)")  // original URL request
                    print(":::::RESPONSE:::::\(response.response)") // URL response
                    print(":::::DATA:::\(response.data)")     // server data
                    print(":::::RESULT:::::\(response.result)")   // result of response serialization
                    //                        self.showSuccesAlert()
                    //self.removeImage("frame", fileExtension: "txt")
                    if let JSON = response.result.value {
                        print("JSON: \(JSON)")
                    }
                }
                
            case .failure(let encodingError):
                //self.delegate?.showFailAlert()
                print(encodingError)
            }
            
        }
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
            print("RESULT :: \(response.result)")
            if let json = response.result.value {
                let data = Responses(json: (json as! NSDictionary) as! [String : Any])
               
                removeActivityIndicator(activityIndicator: self.myActivityIndicator)
                switch(data.code){
                case 200:
                    let array  = data.data as! NSArray
                    for animalJSON in array{
                        arrayAnimals.append(Animals(json: animalJSON as! NSDictionary))
                    }
                    self.getElementsJson()
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
    
    public func getElementsJson(){
        let urlRequest = mainURL + "/Elements/download.json"
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
            print("RESULT :: \(response.result)")
            if let json = response.result.value {
                let data = Responses(json: (json as! NSDictionary) as! [String : Any])
                
                removeActivityIndicator(activityIndicator: self.myActivityIndicator)
                switch(data.code){
                case 200:
                    let array  = data.data as! NSArray
                    for elementJson in array{
                        arrayElements.append(Elements(json: elementJson as! NSDictionary))
                    }
                    for elemento in arrayElements{
                        print(elemento.name)
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
    
    
    public func getStoriesFromUser(){
        let urlRequest = mainURL + "/Stories/show.json"
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
            removeActivityIndicator(activityIndicator: self.myActivityIndicator)
            debugPrint(response)
            print("RESULT :: \(response.result)")
            if let json = response.result.value {
                let data = Responses(json: (json as! NSDictionary) as! [String : Any])
                
                removeActivityIndicator(activityIndicator: self.myActivityIndicator)
                switch(data.code){
                case 200:
                    
                    let array  = data.data as! NSArray
                    for storiesJson in array{
                        arrayStories.append(Story(json: storiesJson as! NSDictionary))
                    }
                    for stories in arrayStories{
                        print(stories.comment)
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
    
    private func getUserInfo(){
        

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

