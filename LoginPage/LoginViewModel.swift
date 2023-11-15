//
//  LoginViewModel.swift
//  LoginPage
//
//  Created by Sanjeev Bharti on 11/13/23.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
    
    @Published var name = ""
    @Published var password = ""

    @Published var enableLoginButton = false
    
    @Published var showForgotPasswordPage = false
    @Published var showNextPage = false
    
    @Published var showLoader = false
    @Published var showError = false
    
    private var continueButtonCancellable: AnyCancellable?
    private var validateDataPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest($name, $password).map { (username, pass) in
            return username.count > 5 && pass.count > 5
        }.eraseToAnyPublisher()
    }
    
    func onAppearInializations() {
        
        continueButtonCancellable = validateDataPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in},
                  receiveValue: {[weak self] result in
                self?.enableLoginButton = result
            })
    }
}

extension LoginViewModel {
    
    // Dummy login call
    func performLogin() {
        
        showLoader = true
        DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 1.0 ... 3.0), execute: DispatchWorkItem(block: {
            self.showLoader = false
            self.showNextPage = self.name.caseInsensitiveCompare("Sanjeev") == .orderedSame && self.password == "Demo@123"
            
            // Show Error
            if self.showNextPage == false {
                self.showError.toggle()
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: DispatchWorkItem(block: {
                    self.showError.toggle()
                }))
            }
        }))
    }
    
}

extension LoginViewModel {
    
    static var sample: LoginViewModel {
        return LoginViewModel()
    }
}
