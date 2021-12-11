//
//  ViewModel.swift
//  OctaShop
//
//  Created by Михаил Щербаков on 01.10.2021.
//

import Foundation
import Combine

class ViewModel: ObservableObject {
    var isLoaderVisible = PassthroughSubject<Bool, Never>();
    var isRedirectVisible = PassthroughSubject<Bool, Never>();
    var webTitle = PassthroughSubject<String, Never>()
    var webViewNavigationPublisher = PassthroughSubject<WebViewNavigationAction, Never>()
}
