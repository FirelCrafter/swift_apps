//
//  DetailView.swift
//  HackerNews
//
//  Created by Михаил Щербаков on 11.01.2022.
//

import SwiftUI

struct DetailView: View {
    
    let url: String?
    var body: some View {
        WebView(urlString: url)
    }
}



struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(url: "https://google.com")
    }
}
