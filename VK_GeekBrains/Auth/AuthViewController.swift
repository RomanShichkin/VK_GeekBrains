//
//  AuthViewController.swift
//  VK_GeekBrains
//
//  Created by Роман Шичкин on 15.07.2021.
//

import UIKit

class AuthViewController: UIViewController {
    
    private var authService: AuthService!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //authService = AuthService()
        authService = AppDelegate.shared().authService
    }
    
    @IBAction func signInTouch() {
        authService.wakeUpSession()
    }
    
}
