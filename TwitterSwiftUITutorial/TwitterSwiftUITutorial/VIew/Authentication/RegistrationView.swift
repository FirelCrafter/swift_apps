//
//  RegistrationView.swift
//  TwitterSwiftUITutorial
//
//  Created by Михаил Щербаков on 16/05/2021.
//

import SwiftUI

struct RegistrationView: View {
    
    @State var email = ""
    @State var password = ""
    @State var fullname = ""
    @State var username = ""
    @State var showImagePicker = false
    @State var selectedUIImage: UIImage?
    @State var image: Image?
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @EnvironmentObject var viewModel: AuthViewModel
    
    func loadImage() {
        guard let selectedImage = selectedUIImage else {return}
        image = Image(uiImage: selectedImage)
    }
    
    var body: some View {
        
        ZStack {
            VStack {
                
                //MARK: - Avatar Image
                
                Button (action: {showImagePicker.toggle()}, label: {
                    ZStack {
                        if let image = image {
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 140, height: 140)
                                .clipped()
                                .cornerRadius(70)
                                .padding(.top, 88)
                                .padding(.bottom, 16)
                                
                        } else {
                            Image("plus_photo")
                                .resizable()
                                .renderingMode(.template)
                                .scaledToFill()
                                .frame(width: 140, height: 140)
                                .padding(.top, 88)
                                .padding(.bottom, 16)
                                .foregroundColor(.white)
                        }
                        
                    }
                }).sheet(isPresented: $showImagePicker, onDismiss: loadImage, content: {
                    ImagePicker(image: $selectedUIImage)
                })
                
                //MARK: - Registration Data
                
                VStack(spacing: 20) {
                    CustomTextField(text: $email, placeholder: Text("Email"), imageName: "envelope")
                        .padding()
                        .background(Color(.init(white: 1, alpha: 0.15)))
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .foregroundColor(.white)
                    
                    CustomTextField(text: $fullname, placeholder: Text("Full Name"), imageName: "person")
                        .padding()
                        .background(Color(.init(white: 1, alpha: 0.15)))
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .foregroundColor(.white)
                    
                    CustomTextField(text: $username, placeholder: Text("Username"), imageName: "person")
                        .padding()
                        .background(Color(.init(white: 1, alpha: 0.15)))
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .foregroundColor(.white)
                    
                    CustomSecureField(text: $password, placeholder: Text("Password"))
                        .padding()
                        .background(Color(.init(white: 1, alpha: 0.15)))
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 10)
                
                HStack {
                    Spacer()
                    
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Text("Forgot password?")
                            .font(.footnote)
                            .bold()
                            .foregroundColor(.white)
                            .padding(.top, 16)
                            .padding(.trailing, 24)
                    })
                }
                
                //MARK: - Sign Up Button
                
                Button(action: {
                    guard let image = selectedUIImage else {return}
                    viewModel.registerUser(email, password: password, username: username, fullname: fullname, profileImage: image)
                }, label: {
                    Text("Sign Up")
                        .font(.headline)
                        .foregroundColor(.blue)
                        .frame(width: 360, height: 50)
                        .background(Color.white)
                        .clipShape(Capsule())
                        .padding()
                })
                
                Spacer()
                
                Button(action: {mode.wrappedValue.dismiss()}, label: {
                    HStack {
                        
                        Text("Already have an account?")
                            .font(.system(size: 14))
                        
                        Text("Sign In")
                            .font(.system(size: 14, weight: .semibold))
                    }
                    .foregroundColor(.white)
                    .padding(.bottom, 40)
                })
                
                
            }
        }
        .background(Color(#colorLiteral(red: 0, green: 0.6351742148, blue: 0.9511070848, alpha: 1)))
        .ignoresSafeArea()
    }
}

//struct RegistrationView_Previews: PreviewProvider {
//    static var previews: some View {
//        RegistrationView()
//    }
//}
