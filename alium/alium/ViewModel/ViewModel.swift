//
//  ViewModel.swift
//  alium
//
//  Created by Михаил Щербаков on 04/08/2021.
//

import Foundation
import Combine

class ViewModel: ObservableObject {
    var isLoaderVisible = PassthroughSubject<Bool, Never>();
    var isRedirectVisible = PassthroughSubject<Bool, Never>();
    var webTitle = PassthroughSubject<String, Never>()
    var webViewNavigationPublisher = PassthroughSubject<WebViewNavigationAction, Never>()
}
