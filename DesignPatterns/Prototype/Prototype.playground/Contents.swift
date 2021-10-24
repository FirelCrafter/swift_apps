import Foundation

// Copy Constructor

protocol Copying {
//    init(copyFrom other: Self)
    
    func clone() -> Self
}

class Address: CustomStringConvertible, Copying {
    
    var streetAddress: String
    var city: String
    
    init(_ streetAddress: String, _ city: String) {
        
        self.streetAddress = streetAddress
        self.city = city
    }
    
    required init(copyFrom other: Address) {
        streetAddress = other.streetAddress
        city = other.city
    }
    
    var description: String {
        return "\(streetAddress), \(city)"
    }
    
    func clone() -> Self {
        return cloneImple()
    }
    
    private func cloneImple<T>() -> T {
        return Address(streetAddress, city) as! T
    }
}

struct Employee: CustomStringConvertible, Copying {
    
    var name: String
    var address: Address
    
    init(_ name: String, _ address: Address) {
        
        self.name = name
        self.address = address
    }
    
//    required init(copyFrom other: Employee) {
//
//        name = other.name
//
//        // 1
////        address = Address(other.address.streetAddress, other.address.city)
//
//        // 2
//        address = Address(copyFrom: other.address)
//    }
    
    var description: String {
        return "My name is \(name), I live at \(address)"
    }
    
    func clone() -> Self { // <-- struct
        return Employee(name, address.clone())
    }
}

func main() {
    
    var john = Employee("John", Address("123 London Road", "London"))
    
    var chris = john.clone()
    chris.name = "Chris"
    
    print(john.description)
    print(chris.description)
    
}

main()
