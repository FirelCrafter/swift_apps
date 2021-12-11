//
//  HomeViewModel.swift
//  DymGet
//
//  Created by Михаил Щербаков on 21.10.2021.
//

import SwiftUI
import CoreLocation

class HomeViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var locationManager = CLLocationManager()
    @Published var search = ""
        
    @Published var userLocation: CLLocation!
    @Published var userAdress = ""
    @Published var userCity = ""
    @Published var noLocation = false
    
    
    //MARK: - location manager
       
       func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
           
           switch manager.authorizationStatus {
           case .authorizedWhenInUse:
               print("authorized")
               self.noLocation = false
               manager.requestLocation()
           case .denied:
               print("denied")
               self.noLocation = true
           default:
               print("unknown")
               self.noLocation = false
               //request
               locationManager.requestWhenInUseAuthorization()
           }
       }
       
       func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
           
           print(error.localizedDescription)
           
       }
       
       func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
           
           self.userLocation = locations.last
           self.extractLocation()
           
       }
       
       
       func extractLocation() {
           
           CLGeocoder().reverseGeocodeLocation(self.userLocation) { (res, err) in
               
               guard let safeData = res else { return }
               
               var adress = ""
               
               adress += safeData.first?.name ?? ""
               adress += ", "
               adress += safeData.first?.locality ?? ""
               
               self.userAdress = adress
               
               var city = ""
               
               city += safeData.first?.locality ?? ""
               
               self.userCity = city
               
           }
           
       }
}
