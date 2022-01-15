//
//  LoginView.swift
//  FaceID
//
//  Created by Михаил Щербаков on 05.01.2022.
//

import SwiftUI
import LocalAuthentication
import Firebase

struct LoginView: View {
    
    @StateObject var viewModel = LoginViewModel()
    @AppStorage("use_face_id") var useFaceID: Bool = false
    
    var body: some View {
        VStack {
            Circle()
                .trim(from: 0, to: 0.5)
                .fill(Color.black)
                .frame(width: 45, height: 45)
                .rotationEffect(.init(degrees: -90))
                .hLeading()
                .offset(x: -23)
                .padding(.bottom, 30)
        
        Text("Login Page")
                .font(.largeTitle.bold())
                .foregroundColor(.black)
                .hLeading()
            
            TextField("E-mail", text: $viewModel.email)
                .padding()
                .autocapitalization(.none)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(viewModel.email == "" ? Color.black.opacity(0.05) :  Color("Orange"))
                ).padding(.top, 20)
            
            SecureField("Password", text: $viewModel.password)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(viewModel.password == "" ? Color.black.opacity(0.05) : Color("Orange"))
                ).padding(.top, 15)
            
            
            Group {
                if useFaceID {
                    
                    Button {
                        
                    }label: {
                        VStack(alignment: .leading, spacing: 10) {
                            Label {
                                Text(LAContext().biometryType == .faceID ? "Face ID" : "Touch ID")
                            } icon: {
                                Image(systemName: LAContext().biometryType == .faceID ? "faceid" : "touchid")
                            }
                            .font(.caption)
                            .foregroundColor(.gray)
                        }
                    }
                    
                } else {
                    Toggle(isOn: $useFaceID) {
                        Text("Use FaceID to login")
                            .foregroundColor(.gray)
                    }
                }
            }.padding(.vertical, 20)
            
            Button {
                viewModel.verifyUser()
            } label: {
                Text("Login")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding()
                    .hCenter()
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color("Brown"))
                    )
                    
            }.padding(.vertical, 35)
                .disabled(viewModel.email == "" || viewModel.password == "")
                .opacity(viewModel.email == "" || viewModel.password == "" ? 0.5 : 1)
            
        }
        .padding(.horizontal, 25)
        .padding(.vertical)
        .alert(isPresented: $viewModel.alert) {
            Alert(title: Text("Error"), message: Text(viewModel.alertMsg), dismissButton: .destructive(Text("Ok")))
        }
    }
    
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

extension View {
    
    func hLeading() -> some View {
        self
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    func hTrailing() -> some View {
        self
            .frame(maxWidth: .infinity, alignment: .trailing)
    }
    
    func hCenter() -> some View {
        self
            .frame(maxWidth: .infinity, alignment: .center)
    }
}
