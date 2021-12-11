//
//  ChartView.swift
//  GraphSheet
//
//  Created by Михаил Щербаков on 23.09.2021.
//

import SwiftUI

struct ChartView: View {
    
    let samplePlot: [CGFloat] =
    [
        989,1200,750,790,650,950,1200,600,500,600,890,1203,1400,900,1250,1600,1200
    ]
    
    //Gesture
    @State var offset: CGFloat = 0
    @State var lastOffset: CGFloat = 0
    @GestureState var gestureOffset: CGFloat = 0
    
    var body: some View {
        ZStack {
            VStack {
                
                HStack {
                    Button {
                        
                    } label: {
                        Image(systemName: "slider.vertical.3")
                            .font(.title2)
                            
                    }
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Image("cat")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 45, height: 45)
                            .clipShape(Circle())
                    }
                }.foregroundColor(.black).padding().padding(.horizontal).padding(.top, 30)
                
                VStack(spacing: 10) {
                    Text("Total balance")
                        .fontWeight(.bold)
                    Text("$ 51 200")
                        .font(.system(size: 38, weight: .bold))
                    
                }.offset(y: -25)
                
                Button {
                    
                } label: {
                    HStack(spacing: 5) {
                        Text("Income")
                        Image(systemName: "chevron.down")
                    }.font(.caption.bold())
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20)
                    .background(Color.white)
                    .clipShape(Capsule())
                    .foregroundColor(.black)
                    .shadow(color: .black.opacity(0.05), radius: 5, x: 5, y: 5)
                    .shadow(color: .black.opacity(0.03), radius: 5, x: -5, y: -5)
                }
                
                GraphLine(data: samplePlot).frame(height: 220).padding(.top, 25)
                
                
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(Color("BG")).edgesIgnoringSafeArea(.all).blur(radius: getBlurRadius())
            
            GeometryReader { proxy -> AnyView in
                
                let height = proxy.frame(in: .global).height
                
                return AnyView (
                    ZStack {
                        BlurView(style: .systemThinMaterialDark)
                            .clipShape(CustomCorner(corners: [.topLeft, .topRight], radius: 30))
                        
                        VStack {
                            Capsule()
                                .fill(Color.white)
                                .frame(width: 80, height: 4)
                            Text("Shortcuts")
                                .font(.title).bold()
                                .foregroundColor(Color.white)
                                .padding()
                        }.frame(maxHeight: .infinity, alignment: .top).padding(.top)
                    }.offset(y: height - 100)
                    .offset(y: -offset > 0 ? -offset <= (height - 100) ? offset : -(height - 100) : 0)
                    .gesture(DragGesture().updating($gestureOffset, body: { value, out, _ in
                        out = value.translation.height
                        onChange()
                    }).onEnded({ value in
                        let maxHeight = height - 100
                        withAnimation{
                            if -offset > 100 && -offset < maxHeight / 2 {
                                offset = -(maxHeight / 3)
                            } else if -offset > maxHeight / 2 {
                                offset = -maxHeight
                            } else {
                                offset = 0
                            }
                        }
                        
                        lastOffset = offset
                    }))
                )
                
            }.ignoresSafeArea(.all, edges: .bottom)
        }
    }
    
    func onChange() {
        DispatchQueue.main.async {
            self.offset = gestureOffset + lastOffset
        }
    }
    
    func getBlurRadius() -> CGFloat {
        let progress = -offset / (UIScreen.main.bounds.height - 100)
        return progress * 30
    }
    
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView()
    }
}
