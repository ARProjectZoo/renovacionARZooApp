//
//  PasswordViewController.swift
//  Pods
//
//  Created by Daniel Lozano Valdés on 12/12/16.
//
//

import UIKit
import Validator
import SkyFloatingLabelTextField

protocol ChangePasswordViewControllerDelegate: class {
    
    func didSelectChangePassword(_ viewController: UIViewController, newPassword: String)
    
    func changePasswordDidSelectBack(_ viewController: UIViewController)
    
}

class ChangePasswordViewController: UIViewController, BackgroundMovable, KeyboardMovable {
    
    // MARK: - Properties
    
    weak var delegate: ChangePasswordViewControllerDelegate?
    
    weak var configurationSource: ConfigurationSource?
    
    var changePasswordAttempted = false
    
    // MARK: Keyboard movable
    
    var selectedField: UITextField?
    
    var offset: CGFloat = 0.0
    
    // MARK: Background Movable
    
    var movableBackground: UIView {
        get {
            return backgroundImageView
        }
    }
    
    // MARK: Outlet's
    
    @IBOutlet var fields: [SkyFloatingLabelTextField]!
    
    @IBOutlet weak var newPassword: SkyFloatingLabelTextField!
    
    @IBOutlet weak var confirmPassword: SkyFloatingLabelTextField!
    @IBOutlet weak var changePasswordButton: Buttn!
    
    @IBOutlet weak var logoImageView: UIImageView!
    
    @IBOutlet weak var backgroundImageView: GradientImageView!
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initBackgroundMover()
        customizeAppearance()
        setupValidation()
    }
    
    override func loadView() {
        self.view = viewFromNib()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Setup
    
    func customizeAppearance() {
        configureFromSource()
        setupFonts()
    }
    
    func configureFromSource() {
        guard let config = configurationSource else {
            return
        }
        
        backgroundImageView.image = config.backgroundImage
        backgroundImageView.gradientColor = config.tintColor
        backgroundImageView.fadeColor = config.tintColor
        logoImageView.image = config.secondaryLogoImage
        
        changePasswordButton.setTitle(config.changePasswordButtonText, for: .normal)
            changePasswordButton.setTitleColor(config.tintColor, for: .normal)
    }
    
    func setupFonts() {
        newPassword.font = Font.montserratRegular.get(size: 13)
       confirmPassword.font = Font.montserratRegular.get(size: 13)
        changePasswordButton.titleLabel?.font = Font.montserratRegular.get(size: 15)
    }
    
    // MARK: - Action's
    
    @IBAction func didSelectBack(_ sender: AnyObject) {
        delegate?.changePasswordDidSelectBack(self)
    }
    
    @IBAction func didSelectChangePassword(_ sender: AnyObject) {
        changePasswordAttempted = true
        
        guard let newPassword = newPassword.text else {
            return
        }
        
        validateFields {
            delegate?.didSelectChangePassword(self, newPassword: newPassword)
        }
    }
    
}

// MARK: - Validation

extension ChangePasswordViewController {
    
    var equalPasswordRule: ValidationRuleEquality<String> {
        return ValidationRuleEquality<String>(dynamicTarget: { self.newPassword.text ?? "" },
                                              error: ValidationError.passwordNotEqual)
    }
    
    func setupValidation() {
        var passwordRules = ValidationService.passwordRules
        setupValidationOn(field: newPassword, rules: passwordRules)
        passwordRules.add(rule: equalPasswordRule)
        setupValidationOn(field: confirmPassword, rules: passwordRules)
    }
    
    func setupValidationOn(field: SkyFloatingLabelTextField, rules: ValidationRuleSet<String>) {
        field.validationRules = rules
        field.validateOnInputChange(enabled: true)
        field.validationHandler = validationHandlerFor(field: field)
    }
    
    func validationHandlerFor(field: SkyFloatingLabelTextField) -> ((ValidationResult) -> Void) {
        return { result in
            switch result {
            case .valid:
                guard self.changePasswordAttempted == true else {
                    break
                }
                field.errorMessage = nil
            case .invalid(let errors):
                guard self.changePasswordAttempted == true else {
                    break
                }
                if let errors = errors as? [ValidationError] {
                    field.errorMessage = errors.first?.message
                }
            }
        }
    
    }
    func validateFields(success: () -> Void) {
        var errorFound = false
        for field in fields {
            let result = field.validate()
            switch result {
            case .valid:
                field.errorMessage = nil
            case .invalid(let errors):
                errorFound = true
                if let errors = errors as? [ValidationError] {
                    field.errorMessage = errors.first?.message
                }
            }
        }
        if !errorFound {
            success()
        }
    }
    
}

// MARK: - UITextField Delegate

extension ChangePasswordViewController: UITextFieldDelegate {
    
     func textFieldDidBeginEditing(_ textField: UITextField) {
        selectedField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        selectedField = nil
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1
        let nextResponder = view.viewWithTag(nextTag) as UIResponder!
        
        if nextResponder != nil {
            nextResponder?.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            didSelectChangePassword(self)
        }
        
        return false
    }
    
}

