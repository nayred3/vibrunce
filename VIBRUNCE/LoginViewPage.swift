//
//  LoginViewPage.swift
//  VIBRUNCE
//
//  Created by Sri Kumbham on 2/19/22.
//

import SwiftUI

struct LoginViewPage: View {
    @StateObject private var loginVM = LoginViewModel()
    @EnvironmentObject var authentication: Authentication
    var body: some View {
        VStack {
            Text("VIBRUNCE")
                .font(.largeTitle)
                .bold()
            TextField("Email Address", text: $loginVM.credentials.email)
                .keyboardType(.emailAddress)
            SecureField("Password", text: $loginVM.credentials.password)
            if loginVM.showProgressView {
                ProgressView()
            }
            Button("Login") {
                loginVM.login { success in
                    authentication.updateValidation(success: success)
                    
                }
            }
            .disabled(loginVM.loginDisabled)
            .padding(.bottom, 20)
            Image("vibdark")
                .onTapGesture {
                    UIApplication.shared.endEditing()
                }
            Spacer()
        }
        .autocapitalization(.none)
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .padding()
        .disabled(loginVM.showProgressView)
    }
}

struct LoginViewPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginViewPage()
    }
}
