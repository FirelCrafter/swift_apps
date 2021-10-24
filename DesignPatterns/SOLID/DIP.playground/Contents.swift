import Foundation

// Dependency Inversion Principle - модули верхних уровней не должны зависеть от модулей нижних уровней, а оба типа модулей должны зависеть от абстракций; сами абстракции не должны зависеть от деталей, а вот детали должны зависеть от абстракций.

enum Relationship {
    case child
    case parent
    case sibling
}

class Person {
    var name = ""
    init(_ name: String) {
        self.name = name
    }
}

protocol RelationshipBrowser {
    func findAllChildrenOf(_ name: String) -> [Person]
}

class Relationships: RelationshipBrowser { // low-level
    
    var relations = [(Person, Relationship, Person)]()
    
    func addParentChild(_ p: Person, _ c: Person) {
        relations.append((p, .parent, c))
        relations.append((c, .child, p))
    }
    
    func findAllChildrenOf(_ name: String) -> [Person] {
        return relations.filter{$0.name == name && $1 == .parent && $2 === $2}.map{$2}
    }
}

class Research { // high-level
    
//    init(_ relationships: Relationships) {
//        let relations = relationships.relations
//        for r in relations where r.0.name == "John" && r.1 == .parent {
//            print("John has a child called: \(r.2.name)")
//        }
//    }
    
    init(_ browser: RelationshipBrowser) {
        for p in browser.findAllChildrenOf("John") {
            print("John has a child called: \(p.name)")
        }
    }
}

func main() {
    let parent = Person("John")
    let child1 = Person("Chris")
    let child2 = Person("Matt")
    
    let relationships = Relationships()
    relationships.addParentChild(parent, child1)
    relationships.addParentChild(parent, child2)
    
    let _ = Research(relationships)
}

main()
