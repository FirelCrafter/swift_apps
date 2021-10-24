import Foundation

class CodeBuilder : CustomStringConvertible
{
    var type = [String]()
    var name = [String]()
    var rootName = ""
    
  init(_ rootName: String)
  {
  self.rootName = rootName
  }

  func addField(called name: String, ofType type: String) -> CodeBuilder
  {
    self.name.append(name)
    self.type.append(type)
    return self
  }

  public var description: String
  {
    var description = "class \(rootName)\n"
    
    description += "{\n"
    
    for i in (0...type.count - 1) {
        description += "  var \(name[i]): \(type[i]) \n"
    }
    description += "}"
    
    return description
  }
}

func main() {
    var cb = CodeBuilder("Person").addField(called: "name", ofType: "String").addField(called: "age", ofType: "Int")
    print(cb.description)
}

main()
