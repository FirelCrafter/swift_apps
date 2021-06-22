//
//  RecordView.swift
//  Record Player
//
//  Created by Михаил Щербаков on 22/06/2021.
//

import SwiftUI

struct RecordView: View {
    
    @Binding var degrees: Double
    @Binding var shouldAnimate: Bool
    
    var body: some View {
        Image("record").resizable().frame(width: 275, height: 275, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .shadow(color: .gray, radius: 1, x: 0, y: 0)
            .rotationEffect(Angle.degrees(degrees))
            .animation(Animation.linear(duration: shouldAnimate ? 60 : 0))
    }
}

struct RecordView_Previews: PreviewProvider {
    static var previews: some View {
        RecordView(degrees: .constant(2.0), shouldAnimate: .constant(true))
    }
}
