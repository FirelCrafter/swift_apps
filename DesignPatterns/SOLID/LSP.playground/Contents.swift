import Foundation

// LSP (Liskov Subsitution Principle) - заключается в том, что при построении иерархий наследования создаваемые наследники должны корректно реализовывать поведение базового типа. То есть если базовый тип реализует определённое поведение, то это поведение должно быть корректно реализовано и для всех его наследников.

class Rectangle: CustomStringConvertible {
    
    var _width = 0
    var _height = 0
    
    var width: Int {
        get {return _width}
        set(value) {_width = value}
    }
    
    var height: Int {
        get {return _height}
        set(value) {_height = value}
    }
    
    init(){}
    init(_ width: Int, _ height: Int) {
        _width = width
        _height = height
    }
    
    var area: Int {
        return width*height
    }
    public var description: String {
        return "widrh: \(width), height: \(height)"
    }
}

class Square: Rectangle {
    
    override var width: Int {
        get {return _width}
        set(value) {
            _width = value
            _height = value
        }
    }
    
    override var height: Int {
        get {return _height}
        set(value) {
            _width = value
            _height = value
        }
    }
}

func setAndMesure(_ rc: Rectangle) {
    rc.width = 3
    rc.height = 4
    
    print("Expect area to be 12, but got \(rc.area)")
}

func main() {
    let rc = Rectangle()
    setAndMesure(rc)
    
    let sq = Square()
    setAndMesure(sq)
}

main()
