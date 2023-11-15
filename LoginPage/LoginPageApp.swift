//
//  LoginPageApp.swift
//  LoginPage
//
//  Created by Sanjeev Bharti on 11/13/23.
//

import SwiftUI

@main
struct LoginPageApp: App {
    var body: some Scene {
        WindowGroup {
            LoginView(viewModel: LoginViewModel.sample)
        }
    }
}
