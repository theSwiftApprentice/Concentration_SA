import Foundation

struct Card: Hashable {
    
    var hashValue: Int {return identifier}
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    private var identifier: Int
    var isFaceUp = false
    var isMatched = false
    
    private static var identifierFactroy = 0
    
    private static func getUniqueIdentifier() -> Int{
        
        identifierFactroy += 1
        return identifierFactroy
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}

