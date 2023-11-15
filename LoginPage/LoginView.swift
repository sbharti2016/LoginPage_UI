//
//  LoginView.swift
//  LoginPage
//
//  Created by Sanjeev Bharti on 11/13/23.
//

import SwiftUI

struct LoginView: View {
    
    @ObservedObject var viewModel: LoginViewModel
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 20.0) {
                lottieViewWith(animationName: "login")
                
                Spacer()
                
                textFieldsView
                
                errorView
                
                footerView
            }
            .blur(radius: viewModel.showLoader ? 2.0 : 0.0)
            .disabled(viewModel.showLoader ? true : false)
            
            loaderView
        }
        .animation(.smooth, value: viewModel.showError)
        .padding()
        .onAppear(perform: {
            viewModel.onAppearInializations()
        })
    }
    
    private var textFieldsView: some View {
        VStack(spacing: 20.0) {
            BorderedTextFieldView(text: $viewModel.name, placeHolder: "Enter Username")
            BorderedTextFieldView(text: $viewModel.password, placeHolder: "Enter Password", isSecure: true)
        }
    }
    
    private var errorView: some View {
        VStack(alignment: .leading) {
            Text("Please enter valid credentials").foregroundStyle(.red)
            Text("Hint:\nUsername: sanjeev | password: Demo@123").foregroundStyle(.green)
        }
        .font(.footnote)
        .frame(height: viewModel.showError ? 60.0 : 0.0)
        .opacity(viewModel.showError ? 1.0 : 0.0)
    }
    
    private var footerView: some View {
        VStack(spacing: 10) {
            Button(action: {
                viewModel.performLogin()
            }, label: {
                Text("Login")
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(viewModel.enableLoginButton ? .orange : .gray.opacity(0.7))
                    .clipShape(RoundedRectangle(cornerRadius: 8.0))
            })
            .disabled(!viewModel.enableLoginButton)
            .animation(.easeInOut(duration: 0.3), value: viewModel.enableLoginButton)
            
            Button(action: {
                viewModel.showForgotPasswordPage.toggle()
            }, label: {
                Text("Forgot password").font(.footnote).fontWeight(.semibold).foregroundStyle(.orange)
            })
            .sheet(isPresented: $viewModel.showForgotPasswordPage, content: {
                lottieViewWith(animationName: "forgotPassword")
            })
        }
        .fullScreenCover(isPresented: $viewModel.showNextPage, content: {
            lottieViewWith(animationName: "relaxx")
        })
    }
    
    private var loaderView: some View {
        ProgressView()
            .tint(.primary)
            .padding()
            .background(Color(uiColor: .systemBackground).opacity(0.6))
            .clipShape(Circle())
            .opacity(viewModel.showLoader ? 1.0 : 0.0)
    }
    
    private func lottieViewWith(animationName: String) -> some View {
        LottieView(name: animationName, loopMode: .loop)
    }
    
}

#Preview {
    LoginView(viewModel: LoginViewModel.sample)
}

