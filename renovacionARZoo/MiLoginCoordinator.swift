import Foundation
import UIKit
import Alamofire
class MiLoginCoordinator: LoginCoordinator {
    
    // MARK: - LoginCoordinator
    var requestStatus : Bool!
    override func start() {
        super.start()
        configureAppearance()
    }
    
    override func finish() {
        super.finish()
    }
    
    // MARK: - Setup
    
    // Customize LoginKit. All properties have defaults, only set the ones you want.
    func configureAppearance() {
        // Customize the look with background & logo images
        backgroundImage = #imageLiteral(resourceName: "Fondo")
        // mainLogoImage =
        // secondaryLogoImage =
        // Change colors
       

        tintColor = UIColor(red: 117/255.0, green: 217/255.0, blue: 180/255.0, alpha: 0.5)
        //tintColor = UIColor(red: 136/255.0, green: 64/255.0, blue: 140/255.0, alpha: 0.5)
        errorTintColor = UIColor(red: 242/255.0, green: 137/255.0, blue: 111/255.0, alpha: 1)
        
        // Change placeholder & button texts, useful for different marketing style or language.
        loginButtonText = "Sign In"
        signupButtonText = "Create Account"
        facebookButtonText = "Login with Facebook"
        forgotPasswordButtonText = "Forgot password?"
        recoverPasswordButtonText = "Recover"
        namePlaceholder = "Name"
        emailPlaceholder = "E-Mail"
        passwordPlaceholder = "Password!"
        repeatPasswordPlaceholder = "Confirm password!"
    }
    
    // MARK: - Completion Callbacks
    
    // Handle login via your API
    override func login(email: String, password: String, mainView : UIViewController) {
        // Handle login via your API
        LogInRequest(email: email, password: password, mainView: mainView)
        print("Login with: email =\(email) password = \(password)")
    }
    
    override func signup(name: String, email: String, password: String, mainView : UIViewController) {
        // Handle signup via your API
        print("Signup with: name = \(name) email =\(email) password = \(password)")
        RegisterRequest(name: name, email: email, password: password, mainView: mainView)
    }
    
    override func enterWithFacebook(profile: FacebookProfile) {
        // Handle Facebook login/signup via your API
        print("Login/Signup via Facebook with: FB profile =\(profile)")
        
    }
    
    override func recoverPassword(email: String, mainView : UIViewController){
        // Handle password recovery via your API
        print("Recover password with: email =\(email)")
        forgotPasswordRequest(email: email, mainView: mainView)
    }
    override func changePassword(newPassword: String, mainView : UIViewController){
        changePasswordRequest(mainView : mainView, newPassword: newPassword)
    }
    
    
    //FUNCIONES PRIVADAS
    private func LogInRequest(email: String, password: String, mainView : UIViewController){
        //Create Activity Indicator
        let myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        //Position Activity Indicator in the center of the main view
        myActivityIndicator.center = mainView.view.center
        
        //If needed, yo can prevent activity Idicantor from hiing ehen stopAnimating() is called
        myActivityIndicator.hidesWhenStopped = false
        
        let parameters : Parameters = [
            "userEmail" : email,
            "password" : password
        ]
        //Start Activity Indicator
        myActivityIndicator.startAnimating()
        mainView.view.addSubview(myActivityIndicator)
        Request(view: mainView, myActivityIndicator: myActivityIndicator, mainCoordinator : self).logIn(parameters: parameters)
        
        
        
    }
    private func RegisterRequest(name : String, email: String, password: String, mainView : UIViewController){
        //Create Activity Indicator
        
        let myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        //Position Activity Indicator in the center of the main view
        myActivityIndicator.center = mainView.view.center
        
        //If needed, yo can prevent activity Idicantor from hiing ehen stopAnimating() is called
        myActivityIndicator.hidesWhenStopped = false
        
        let parameters : Parameters = [
            "userName" : name,
            "password" : password,
            "email" : email,
            "id_device" : "000",
            "x" : "1",
            "y" : "1",
            "profilePhoto" : ""
        ]
        //Start Activity Indicator
        myActivityIndicator.startAnimating()
        mainView.view.addSubview(myActivityIndicator)
        Request(view: mainView, myActivityIndicator: myActivityIndicator, mainCoordinator: self).register(parameters: parameters, mainView: mainView)
    }
    private func forgotPasswordRequest(email: String, mainView : UIViewController){
        //Create Activity Indicator
        let myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        //Position Activity Indicator in the center of the main view
        myActivityIndicator.center = mainView.view.center
        
        //If needed, yo can prevent activity Idicantor from hiing ehen stopAnimating() is called
        myActivityIndicator.hidesWhenStopped = false
        
        let parameters : Parameters = [
            "email" : email
        ]
        //Start Activity Indicator
        myActivityIndicator.startAnimating()
        mainView.view.addSubview(myActivityIndicator)
        Request(view: mainView, myActivityIndicator: myActivityIndicator, mainCoordinator : self).forgotPassword(parameters: parameters)
    }
    
    private func changePasswordRequest(mainView : UIViewController, newPassword : String){
        let myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        //Position Activity Indicator in the center of the main view
        myActivityIndicator.center = mainView.view.center
        
        //If needed, yo can prevent activity Idicantor from hiing ehen stopAnimating() is called
        myActivityIndicator.hidesWhenStopped = false
        
        let parameters : Parameters = [
            "newPassword" : newPassword
        ]
        //Start Activity Indicator
        myActivityIndicator.startAnimating()
        mainView.view.addSubview(myActivityIndicator)
        Request(view: mainView, myActivityIndicator: myActivityIndicator, mainCoordinator : self).changePassword(parameters: parameters)
    }
    
    
}
