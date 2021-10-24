import Foundation

class Point: CustomStringConvertible {
    
    var x, y: Double
    
    init(x: Double, y: Double) {
        
        self.x = x
        self.y = y
        
    }
    
    init(rho: Double, theta: Double) {
        
        x = rho * cos(theta)
        y = rho * sin(theta)
        
    }
    
    // Factory method - simple way to explain what happens here
    
//    static func createCartesian(x: Double, y: Double) -> Point {
//        return Point(x: x, y: y)
//    }
//
//    static func createPolar(rho: Double, theta: Double) -> Point {
//        return Point(rho: rho, theta: theta)
//    }
    
    
    
//    static let factory = PointFactory.instance
//    class PointFactory {
//
//        // Inner Factory  - class for extraction methods inside the class
//
//        private init() {}
//
//        static let instance = PointFactory()
//
//        func createCartesian(x: Double, y: Double) -> Point {
//            return Point(x: x, y: y)
//        }
//
//        func createPolar(rho: Double, theta: Double) -> Point {
//            return Point(rho: rho, theta: theta)
//        }
//    }
    
    var description: String {
        return "x = \(x), y = \(y)"
    }
}

class PointFactory {
    
    // Factory  - class for extraction methods
    
    func createCartesian(x: Double, y: Double) -> Point {
        return Point(x: x, y: y)
    }
    
    func createPolar(rho: Double, theta: Double) -> Point {
        return Point(rho: rho, theta: theta)
    }
}

func main() {
    
//    let p = Point.createPolar(rho: 1, theta: 2)
    
    let f = PointFactory()
    let p = f.createCartesian(x: 1, y: 2)
    
    print(p)
    
}

main()
