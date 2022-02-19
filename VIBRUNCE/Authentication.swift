//
//  Authentication.swift
//  VIBRUNCE
//
//  Created by Sri Kumbham on 2/19/22.
//

import SwiftUI
import LocalAuthentication

class Authentication: ObservableObject {
    @Published var isValidated = false
    @Published var isAuthorized = false
    
    enum BiometricType {
        case none
        case face
        case touch
    }
    
    enum AuthenticationError: Error, LocalizedError, Identifiable {
        case invalidCredentials
        case deniedAccess
        case noFaceIDEnrolled
        case noFingerprintEnrolled
        case biometricError
        case credentialsNotSaved
        
        var id: String {
            self.localizedDescription
        }
        
        var errorDescription: String? {
            switch self {
                
            case .invalidCredentials:
                return NSLocalizedString("The email or password that was provided was incorrect", comment: "")
                
            case .deniedAccess:
                return NSLocalizedString("Access to Face ID was denied. Locate VIBRUNCE in your settings and turn Face ID on.", comment: "")
                
            case .noFaceIDEnrolled:
                return NSLocalizedString("There are no stored Face IDs on this device. Set up a Face ID in your device settings", comment: "")
                
            case .noFingerprintEnrolled:
                return NSLocalizedString("There are no stored Fingerprints on this device. Set up a Fingerprint in your device settings", comment: "")
            case .biometricError:
                return NSLocalizedString("The Face ID or Fingerprint was not recognized", comment: "")
            
            case .credentialsNotSaved:
                return NSLocalizedString("Credentials have not been saved. Would you like to save them after the next successful login?" , comment: "")
            }
        }
    }
    
    func updateValidation(success: Bool) {
        withAnimation {
            isValidated = success
        }
    }
    
    func biometricType() -> BiometricType {
        let authContext = LAContext()
        let  _ = authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
        switch authContext.biometryType {
            
        case .none:
            return .none
        case .touchID:
            return .touch
        case .faceID:
            return .face
        @unknown default:
            return .none
        }
    }
    
    func requestBiometricUnlock(completion: @escaping (Result<Credentials, AuthenticationError>) -> Void) {
        
        let credentials:Credentials? = Credentials(email: "admin@vibrunce.com", password: "vibrunce")
        
        
        // might do some keychain wrapper stuff here in future
       //let credentials:Credentials? = nil
        
        
        
        guard let credentials = credentials else {
            completion(.failure(.credentialsNotSaved))
            return
        }
        
        let context = LAContext()
        var error: NSError?
        let canEvaluate = context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
        if let error = error {
            
            switch error.code {
                
            case -6:
                completion(.failure(.deniedAccess))
            case -7:
                
                if context.biometryType == .faceID {
                    completion(.failure(.noFaceIDEnrolled))
                    
                } else {
                    completion(.failure(.noFingerprintEnrolled))
                }
            default:
                completion(.failure(.biometricError))
            }
            return
        }
        if canEvaluate {
            if context.biometryType != .none {
                
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Need to access credentials") {
                    success, error in
                    DispatchQueue.main.async {
                        
                        if error != nil {
                            completion(.failure(.biometricError))
                        } else {
                            completion(.success(credentials))
                        }
                    }
                }
            }
        }
    }
}
