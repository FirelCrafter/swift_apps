//
//  HomeViewModel.swift
//  RubanApp
//
//  Created by Михаил Щербаков on 10/07/2021.
//

import SwiftUI
import CoreLocation
import Firebase

class HomeViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var locationManager = CLLocationManager()
    @Published var search = ""
    
    @Published var userLocation: CLLocation!
    @Published var userAdress = ""
    @Published var noLocation = false
    
    @Published var showMenu = false
    
    @Published var items: [Item] = []
    @Published var filtered: [Item] = []
    
    @Published var cartItems: [Cart] = []
    @Published var ordered = false
    
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
        
        self.login()
    }
    
    
    func extractLocation() {
        
        CLGeocoder().reverseGeocodeLocation(self.userLocation) { (res, err) in
            
            guard let safeData = res else { return }
            
            var adress = ""
            
            adress += safeData.first?.name ?? ""
            adress += " ,"
            adress += safeData.first?.locality ?? ""
            
            self.userAdress = adress
            
        }
        
    }
    
    //MARK: - login in firebase
    
    func login() {
        
        Auth.auth().signInAnonymously { (res, err) in
            
            if err != nil {
                print(err!.localizedDescription)
                return
            }
            
            print("Success = \(res!.user.uid)")
            
            self.fetchData()
            
        }
        
    }
    
    //MARK: - firestore
    
    func fetchData() {
        
        let db = Firestore.firestore()
        
        db.collection("Items").getDocuments {(snap, err) in
            
            guard let itemData = snap else { return }
            
            self.items = itemData.documents.compactMap({ (doc) -> Item? in
                
                let id = doc.documentID
                let name = doc.get("itemName") as! String
                let cost = doc.get("itemCost") as! NSNumber
                let image = doc.get("itemImage") as! String
                let ratings = doc.get("itemRatings") as! String
                let details = doc.get("itemDetails") as! String
                
                return Item(id: id, itemName: name, itemCost: cost, itemDetails: details, itemImage: image, itemRatings: ratings)
                
            })
            
            self.filtered = self.items
            
        }
        
    }
    
    
    //MARK: - filter
    
    func filterData() {
        withAnimation(.linear) {
            self.filtered = self.items.filter{
                return $0.itemName.lowercased().contains(self.search.lowercased())
            }
        }
    }
    
    //MARK: - shopping cart manager
    
    func addToCart(item: Item) {
        
        self.items[getIndex(item: item, isCartIndex: false)].isAdded = !item.isAdded
        
        let filterIndex = self.filtered.firstIndex { (item1) -> Bool in
            return item.id == item1.id
        } ?? 0
        
        self.filtered[filterIndex].isAdded = !item.isAdded
        
        if item.isAdded {
            
            self.cartItems.remove(at: getIndex(item: item, isCartIndex: true))
            return
        }
        
        self.cartItems.append(Cart(item: item, quantity: 1))
        
    }
    
    func getIndex(item: Item, isCartIndex: Bool) -> Int {
        
        let index = self.items.firstIndex { (item1) -> Bool in
            
            return item.id == item1.id
            
        } ?? 0
        
        let cartIndex = self.cartItems.firstIndex { (item1) -> Bool in
            
            return item.id == item1.item.id
            
        } ?? 0
        
        return isCartIndex ? cartIndex : index
    }
    
    func calculateTotalPrice() -> String {
        
        var price: Float = 0
        
        cartItems.forEach { (item) in
            price += Float(item.quantity) * Float(truncating: item.item.itemCost)
        }
        
        return getPrice(value: price)
        
    }
    
    func getPrice(value: Float) -> String {
        
        let format = NumberFormatter()
        format.numberStyle = .currency

        return format.string(from: NSNumber(value: value)) ?? ""
        
    }
    
    
    //MARK: - writing user data in firestore
    
    func updateOrder() {
        
        let db = Firestore.firestore()
        
        ordered = false
        
        if ordered {
            db.collection("Users").document(Auth.auth().currentUser!.uid).delete() { (err) in
                
                if err != nil {
                    self.ordered = true
                }
                
            }
        }
        
        var details: [[String: Any]] = []
        
        cartItems.forEach {(cart) in
            
            details.append([
                "itemName": cart.item.itemName,
                "itemQuantity": cart.quantity,
                "itemCost": cart.item.itemCost
            ])
            
        }
        
        ordered = true
        
        db.collection("Users").document(Auth.auth().currentUser!.uid).setData([
            
            "orderedFood" : details,
            "totalCost": calculateTotalPrice(),
            "location": GeoPoint(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
            
        ]){(err) in
            if err != nil {
                self.ordered = false
            }
        }
        
        return
        
    }

    
}
