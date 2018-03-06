//
//  LoginCoordinator.swift
//  Pods
//
//  Created by Daniel Lozano Valdés on 12/12/16.
//
//

import Foundation
import UIKit

protocol ConfigurationSource: class {
    
    var backgroundImage: UIImage { get }
    var mainLogoImage: UIImage { get }
    var secondaryLogoImage: UIImage { get }
    
    var tintColor: UIColor { get }
    var errorTintColor: UIColor { get }
    var buttonInnerColor : UIColor{ get }
    
    var signupButtonText: String { get }
    var loginButtonText: String { get }
    var facebookButtonText: String { get }
    var forgotPasswordButtonText: String { get }
    var recoverPasswordButtonText: String { get }
    var changePasswordButtonText : String { get }
    
    var emailPlaceholder: String { get }
    var passwordPlaceholder: String { get }
    var repeatPasswordPlaceholder: String { get }
    var namePlaceholder: String { get }
    
    var shouldShowForgotPassword: Bool { get }
    
}

open class LoginCoordinator: ConfigurationSource {
    
   
    
    // MARK: - Properties
    
    public let window: UIWindow?
    
    public let rootViewController: UIViewController?
    
    // MARK: Public Configuration
    
    public var backgroundImage = UIImage()
    
    public var mainLogoImage = UIImage()
    
    public var secondaryLogoImage = UIImage()
    
    public var tintColor = UIColor(red: 253 / 255.0, green: 253 / 255.0, blue: 253 / 255.0, alpha: 1)
    
    public var errorTintColor = UIColor(red: 241 / 255, green: 196 / 255 , blue: 15 / 255, alpha: 1)
    
    public var buttonInnerColor = UIColor(red: 253/255, green: 253/255, blue: 253/255, alpha: 1)
    
    public var signupButtonText = "Sign Up"
    
    public var loginButtonText = "Log In"
    
    public var facebookButtonText = "Enter with Facebook"
    
    public var forgotPasswordButtonText = "Forgot Password"
    
    public var recoverPasswordButtonText = "Recover Password"
    
    public var changePasswordButtonText = "Cambiar contraseña"
    
    public var emailPlaceholder = "Email"
    
    public var passwordPlaceholder = "Password"
    
    public var repeatPasswordPlaceholder = "Repeat Password"
    
    public var namePlaceholder = "Full Name"
    
    public var shouldShowForgotPassword = true
    
    // MARK: Private
    
    fileprivate static let bundle = Bundle(for: InitialViewController.self)
    
    // MARK: View Controller's
    
    fileprivate var navigationController: UINavigationController {
        if _navigationController == nil {
            _navigationController = UINavigationController(rootViewController: self.initialViewController)
        }
        return _navigationController!
    }
    private var _navigationController: UINavigationController?
    
    fileprivate var initialViewController: InitialViewController {
        if _initialViewController == nil {
            let viewController = InitialViewController()
            viewController.delegate = self
            viewController.configurationSource = self
            _initialViewController = viewController
        }
        return _initialViewController!
    }
    fileprivate var _initialViewController: InitialViewController?
    
    fileprivate var loginViewController: LoginViewControllerCoordinator {
        if _loginViewController == nil {
            let viewController = LoginViewControllerCoordinator()
            viewController.delegate = self
            viewController.configurationSource = self
            _loginViewController = viewController
        }
        return _loginViewController!
    }
    fileprivate var _loginViewController: LoginViewControllerCoordinator?
    
    fileprivate var signupViewController: SignupViewController {
        if _signupViewController == nil {
            let viewController = SignupViewController()
            viewController.delegate = self
            viewController.configurationSource = self
            _signupViewController = viewController
        }
        return _signupViewController!
    }
    fileprivate var _signupViewController: SignupViewController?
    
    fileprivate var passwordViewController: PasswordViewController {
        if _passwordViewController == nil {
            let viewController = PasswordViewController()
            viewController.delegate = self
            viewController.configurationSource = self
            _passwordViewController = viewController
        }
        return _passwordViewController!
    }
    fileprivate var _passwordViewController: PasswordViewController?
    
    fileprivate var changePasswordViewController : ChangePasswordViewController {
        if _ChangePasswordViewController == nil{
            let viewController = ChangePasswordViewController()
            viewController.delegate = self
            viewController.configurationSource = self
            _ChangePasswordViewController = viewController
        }
        return _ChangePasswordViewController!
    }
    fileprivate var _ChangePasswordViewController : ChangePasswordViewController?

    
    // MARK: Services
    
    public lazy var facebookService = FacebookService()
    
    // MARK: - LoginCoordinator
    
    public init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
        self.window = nil
    }
    
    public init(window: UIWindow) {
        self.window = window
        self.rootViewController = nil
    }
    
    open func start() {
        if let rootViewController = rootViewController {
            rootViewController.present(navigationController, animated: true, completion: nil)
        } else if let window = window {
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
        }
    }
    
    open func finish() {
        if let rootViewController = rootViewController {
            rootViewController.dismiss(animated: true, completion: nil)
        }
        
        _navigationController = nil
        _initialViewController = nil
        _loginViewController = nil
        _signupViewController = nil
        _passwordViewController = nil
        _ChangePasswordViewController = nil
    }
    
    public func visibleViewController() -> UIViewController? {
        return navigationController.topViewController
    }
    
    // MARK: - Callbacks, Meant to be subclassed
    
    open func login(email: String, password: String, mainView : UIViewController) {
        print("Implement this method in your subclass to handle login.")
    }
    
    open func signup(name: String, email: String, password: String, mainView : UIViewController) {
        print("Implement this method in your subclass to handle signup.")
    }
    
    open func enterWithFacebook(profile: FacebookProfile) {
        print("Implement this method in your subclass to handle facebook.")
    }
    
    open func recoverPassword(email: String, mainView : UIViewController ){
        print("Implement this method in your subclass to handle password recovery.")
        
    }
    open func changePassword(newPassword : String, mainView : UIViewController ){
        print("Implement this method in your subclass to handle change password.")
    }
    
}

// MARK: - Navigation

public extension LoginCoordinator {
    
   
        
    func goToLogin() {
        navigationController.pushViewController(loginViewController, animated: true)
        
    }
    
    func backToLogin(){
        navigationController.popToRootViewController(animated: true)
    }
    
    func goToSignup() {
        navigationController.pushViewController(signupViewController, animated: true)
    }
    
    func goToPassword() {
        navigationController.pushViewController(passwordViewController, animated: true)
    }
    func goToChangePassword() {
        navigationController.pushViewController(changePasswordViewController, animated: true)
    }
    
    func pop() {
        _ = navigationController.popViewController(animated: true)
    }
    
    func checkRequest(requesStatus : Bool){
        if(requesStatus){
            goToChangePassword()
        }else{
            print("API_:::::_request negativa")
        }
    }
    
}

// MARK: - View Controller Callbacks

extension LoginCoordinator: InitialViewControllerDelegate {
    
    func didSelectLogin(_ viewController: UIViewController) {
        goToLogin()
    }
    
    func didSelectSignup(_ viewController: UIViewController) {
        goToSignup()
    }
    
    func didSelectFacebook(_ viewController: UIViewController) {
        facebookService.login(from: viewController) { (result) in
            switch result {
            case .success(let profile):
                self.enterWithFacebook(profile: profile)
            default:
                break
            }
        }
    }
    
}

extension LoginCoordinator: LoginViewControllerDelegate {
    
    func didSelectLogin(_ viewController: UIViewController, email: String, password: String) {
        login(email: email, password: password, mainView: viewController)
    }
    
    func didSelectForgotPassword(_ viewController: UIViewController) {
        goToPassword()
    }
    
    func loginDidSelectBack(_ viewController: UIViewController) {
        pop()
        _loginViewController = nil
    }
}

extension LoginCoordinator: SignupViewControllerDelegate {
    
    func didSelectSignup(_ viewController: UIViewController, email: String, name: String, password: String) {
        signup(name: name, email: email, password: password, mainView: viewController)
    }
    
    func signupDidSelectBack(_ viewController: UIViewController) {
        pop()
        _signupViewController = nil
    }
    
}

extension LoginCoordinator: PasswordViewControllerDelegate {
    
    func didSelectRecover(_ viewController: UIViewController, email: String) {
        
        recoverPassword(email: email, mainView: viewController)
    }
    
    func passwordDidSelectBack(_ viewController: UIViewController) {
        pop()
        _passwordViewController = nil
    }
    
}

extension LoginCoordinator: ChangePasswordViewControllerDelegate {
    
    func didSelectChangePassword(_ viewController: UIViewController, newPassword: String) {
        changePassword(newPassword: newPassword, mainView : viewController)
    }
    
    func changePasswordDidSelectBack(_ viewController: UIViewController) {
        pop()
        _passwordViewController = nil
    }
    
}

// MARK: - Font Loading

enum Font: String {
    
    case montserratLight = "Montserrat-Light"
    case montserratRegular = "Montserrat-Regular"
    
    var type: String {
        switch self {
        case .montserratLight:
            return "otf"
        case .montserratRegular:
            return "ttf"
        }
    }
    
    func get(size: CGFloat = 15.0) -> UIFont {
        return UIFont(name: self.rawValue, size: size)!
    }
    
}

let loadFonts: () = {
    print("Login Coordinator: Loading Fonts")
    let light = Font.montserratLight
    let regular = Font.montserratRegular
    let loadedLight = LoginCoordinator.loadFont(light.rawValue, type: light.type)
    let loadedRegular = LoginCoordinator.loadFont(regular.rawValue, type: regular.type)
    if loadedLight && loadedRegular {
        print("Login Coordinator: Loaded Fonts")
    } else {
        print("Login Coordinator: Failed Loading Fonts")
    }
}()

extension LoginCoordinator {
    
    static func loadFont(_ name: String, type: String) -> Bool {
        let bundle = Bundle(for: InitialViewController.self)
        
        guard let fontPath = bundle.path(forResource: name, ofType: type) else {
            return false
        }
        
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: fontPath)) as CFData else {
            return false
        }
        
        guard let provider = CGDataProvider(data: data) else {
            return false
        }
        
        #if swift(>=4)
            guard let font = CGFont(provider) else {
                print("Error loading font. Could not create CGFont from CGDataProvider.")
                return false
            }
        #else
            let font = CGFont(provider)
        #endif
        
        var error: Unmanaged<CFError>?
        
        let success = CTFontManagerRegisterGraphicsFont(font, &error)
        if !success {
            print("Error registering font. Font is possibly already registered.")
            return false
        }
        
        return true
    }
    
}

