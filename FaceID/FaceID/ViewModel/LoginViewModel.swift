//
//  LoginViewModel.swift
//  FaceID
//
//  Created by Михаил Щербаков on 05.01.2022.
//

import Foundation
import SwiftUI
import LocalAuthentication
import Firebase


class LoginViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var logged = false
    
    @Published var alert = false
    @Published var alertMsg: String = ""
    @Published var faceIdDisabled = true
    
    @Published var storeInfo = false
    
    @AppStorage("use_face_id") var useFaceID: Bool = false
    @AppStorage("use_face_email") var useFaceEmail = ""
    @AppStorage("use_face_password") var useFacePassword = ""
    
    func getBioMetricStatus() ->  Bool {
        
        let scanner = LAContext()
        
        if !email.isEmpty && useFaceID && scanner.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: .none) {
            return true
        }
        return false
    }
    
    func authentificateUser() {
        
        let scanner = LAContext()
        scanner.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "To unlock \(email)") { (status, err) in
            if err != nil {
                print(err!.localizedDescription)
                return
            }
            
        }
    }
    
    func verifyUser() {
        
        Auth.auth().signIn(withEmail: email, password: password) { (res, err) in
            
            if let error = err {
                self.alertMsg = error.localizedDescription
                self.alert.toggle()
                return
            }
            
            if self.email == "" || self.password == "" {
                self.storeInfo.toggle()
                return
            }
            
        }
        
        withAnimation(.spring()) {self.logged = true}
        
    }
    
}
