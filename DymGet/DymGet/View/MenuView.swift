//
//  MenuView.swift
//  DymGet
//
//  Created by Михаил Щербаков on 21.10.2021.
//

import SwiftUI

struct MenuView: View {
    
    @Binding var showMenu: Bool
    @Binding var animatePath: Bool
    @Binding var animateBG: Bool
    
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        ZStack {
            BlurView(style: .systemUltraThinMaterialDark)
            Color("BG2")
                .opacity(0.7)
                .blur(radius: 15)
            
            VStack(alignment: .leading, spacing: 25){
                Button{
                    
                    withAnimation(.interactiveSpring(response: 0.4, dampingFraction: 0.3, blendDuration: 0.3)){
                        animatePath.toggle()
                        
                    }
                    withAnimation {
                        animateBG.toggle()
                    }
                    withAnimation(.spring().delay(0.1)){
                        showMenu.toggle()
                    }
                   
                } label: {
                    Image(systemName: "xmark.circle")
                        .font(.title)
                }
                .foregroundColor(Color.white.opacity(0.8))
                
                HStack {
                    Text(viewModel.userLocation == nil ? "Ищем Вас..." : "Доставить: ")
                        .foregroundColor(.white.opacity(0.8))
                                        
                                        Text(viewModel.userAdress)
                                            .font(.caption)
                                            .fontWeight(.heavy)
                                            .foregroundColor(Color.white.opacity(0.8))
                }
                
                menuButton(title: "Магазины", image: "square.grid.2x2", offset: 0)
                    .padding(.top, 40)
                menuButton(title: "Блог", image: "square.and.arrow.up.on.square", offset: 10)
                menuButton(title: "Профиль", image: "Profile", offset: 30)
                menuButton(title: "Корзина", image: "cart", offset: 10)
                menuButton(title: "Помощь", image: "questionmark.circle", offset: 0)
                
                Spacer(minLength: 10)
                
                menuButton(title: "ВЫХОД", image: "rectangle.portrait.and.arrow.down", offset: 0)
            }
            .padding(.trailing, 120)
            .padding()
            .padding(.top, getSafeArea().top)
            .padding(.bottom, getSafeArea().bottom)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                
        }
        .clipShape(MenuShape(value: animatePath ? 150 : 0))
        .background(
            MenuShape(value: animatePath ? 150 : 0)
                .stroke(
                    .linearGradient(.init(colors: [
                    Color("Blue"),
                    Color("Blue").opacity(0.7),
                    Color("Blue").opacity(0.5),
                    Color.clear
                    ]), startPoint: .top, endPoint: .bottom),
                    lineWidth: animatePath ? 7 : 0
                ).padding(.leading, -50)
        )
        .ignoresSafeArea()
    }
    
    @ViewBuilder
    func menuButton(title: String, image: String, offset: CGFloat)-> some View {
        Button {
            
        } label: {
            HStack(spacing: 12) {
                if image == "Profile" {
                    Image(image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                }
                else {
                    Image(systemName: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 25, height: 25)
                        .foregroundColor(.white.opacity(0.8))
                }
                
                Text(title)
                    .font(.system(size: 17))
                    .fontWeight(.medium)
                    .foregroundColor(Color.white.opacity(0.65))
                    .kerning(title == "LOGOUT" ? 1.2 : 0.8)
            }
            .padding(.vertical)
        }
        .offset(x: offset)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

struct MenuShape: Shape {
    
    var value: CGFloat
    
    var animatableData: CGFloat {
        get{return value}
        set{value = newValue}
    }
    
    func path(in rect: CGRect) -> Path {
        return Path{ path in
            let width = rect.width - 100
            let height = rect.height
            
            path.move(to: CGPoint(x: width, y: height))
            path.addLine(to: CGPoint(x: 0, y: height))
            path.addLine(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: width, y: 0))
            
            path.move(to: CGPoint(x: width, y: 0))
            
            path.addCurve(to: CGPoint(x: width, y: height + 100), control1: CGPoint(x: width + value, y: height / 3), control2: CGPoint(x: width - value, y: height / 2))
        }
    }
}

extension View {
    
    func getSafeArea()-> UIEdgeInsets {
        
        
        guard let screen =
                UIApplication.shared.connectedScenes.first as?
                UIWindowScene else {return .zero}
        
        guard let safeArea =
                screen.windows.first?.safeAreaInsets
        else {return .zero}
        
        return safeArea
    }
    func getRect()->CGRect {
        return UIScreen.main.bounds
    }
}
