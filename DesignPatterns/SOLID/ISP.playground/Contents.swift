import Foundation

// Interface Segregation Peinciple - заключается в создании интерфейсов, которые достаточно специфичны и требуют только необходимый минимум реализаций методов.


class Document {
    
}

protocol Machine {
    func print(d: Document)
    func scan(d: Document)
    func fax(d: Document)
}

// segregated interface is better

protocol Printer {
    func print(d: Document)
}
protocol Scanner {
    func scan(d: Document)
}
protocol Fax {
    func fax(d: Document)
}

class MFP: Printer, Scanner, Fax {
    func print(d: Document) {
        //ok
    }
    func scan(d: Document) {
        //ok
    }
    func fax(d: Document) {
        //ok
    }
}

class Photocopier: Printer, Scanner {
    func print(d: Document) {
        //ok
    }
    func scan(d: Document) {
        //ok
    }
}

class OldFasionedPrinter: Printer {
    func print(d: Document) {
        //ok
    }
}
