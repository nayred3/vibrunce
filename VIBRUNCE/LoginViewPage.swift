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
            TextField("Email Address or Username", text: $loginVM.credentials.email)
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
            if authentication.biometricType() != .none {
                Button {
                    authentication.requestBiometricUnlock {
                        (result:Result<Credentials,Authentication.AuthenticationError>) in
                        switch result {
                        case .success(let credentials):
                            loginVM.credentials = credentials
                            loginVM.login { success in
                                authentication.updateValidation(success: success)
                            }
                        case .failure(let error):
                            loginVM.error = error
                        }
                        
                    }
                } label: {
                    Image(systemName: authentication.biometricType() == .face ? "faceid" : "touchid")
                        .resizable()
                        .frame(width: 50, height: 50)
                }
            }
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
        .alert(item: $loginVM.error) { error in
            if error == .credentialsNotSaved {
                return Alert(title: Text("Credentials not saved"), message: Text(error.localizedDescription),
                             primaryButton: .default(Text("Ok"), action: {
                    
                }),
                             secondaryButton: .cancel())
            } else {
                return Alert(title: Text("Invalid Login"), message: Text(error.localizedDescription))
            }
            
        }
    }
}

struct LoginViewPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginViewPage()
    }
}
