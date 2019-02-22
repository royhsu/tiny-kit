import TinyKit
import TinyValidation

struct GreaterThanRule<Value> where Value: Comparable {
    
    private let lowerBound: Value
    
    init(lowerBound: Value) { self.lowerBound = lowerBound }
    
}

extension GreaterThanRule: ValidationRule {
    
    func validate(_ value: Value?) throws -> Value {
        
        let value = try value.explicitValidated(
            by: NonNullRule()
        )
        
        if value > lowerBound { return value }
        
        throw GreaterThanError()
        
    }
    
}

struct GreaterThanError: Error { }

do {

    let validValue = try GreaterThanRule(lowerBound: 5).validate(10)
    
    print(validValue)
    
}
catch { print("\(error)") }

struct Field<Value> {
    
    var value: Value
    
    var rules: [AnyValidationRule<Value>]
    
}

extension Field: Decodable where Value: Decodable {

    init(from decoder: Decoder) throws {

        let container = try decoder.singleValueContainer()

        self.value = try container.decode(Value.self)
        
        self.rules = []

    }

}

extension Field: Encodable where Value: Encodable {
    
    func encode(to encoder: Encoder) throws {
        
        var container = encoder.singleValueContainer()
        
        try container.encode(value)
        
    }
    
}

struct Form<Key, Value> where Key: Hashable {
    
    private var storage: [Key: Field<Value>]
    
}

extension Form: MutableCollection {
    
    var startIndex: Dictionary< Key, Field<Value> >.Index { return storage.startIndex }
    
    var endIndex: Dictionary< Key, Field<Value> >.Index { return storage.endIndex }
    
    func index(after i: Dictionary< Key, Field<Value> >.Index) -> Dictionary< Key, Field<Value> >.Index { return index(after: i) }
    
    subscript(position: Dictionary< Key, Field<Value> >.Index) -> Field<Value> {
        
        get { return storage[position].value }
        
        set {
            
            let pair = storage[position]
            
            storage[pair.key] = newValue
            
        }
        
    }
    
}

extension Form {
    
    subscript(key: Key) -> Field<Value>? {
     
        get { return storage[key] }
        
        set { storage[key] = newValue }
        
    }
    
}

typealias AnyValueForm<Key> = Form<Key, Any> where Key: Hashable

typealias AnyForm = Form<AnyHashable, Any>

extension Form: Encodable where Key: CodingKey, Value: Encodable {
    
    func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: Key.self)
        
        for pair in storage {
            
            let value = pair.value.value
            
            let validValue = try pair.value.rules.reduce(value) { result, rule in try rule.validate(result) }
            
            try container.encode(
                validValue,
                forKey: pair.key
            )
            
        }
        
    }
    
}

extension Form: ExpressibleByDictionaryLiteral {
    
    init(dictionaryLiteral pairs: (Key, Field<Value>)...) {
        
        self.init(
            storage: Dictionary(uniqueKeysWithValues: pairs)
        )
        
    }
    
}

//extension Form: Decodable where Key: CodingKey & Decodable, Value: Decodable {
//
//    init(decoder: Decoder) throws {
//
//        let container = try decoder.container(keyedBy: Key.self)
//
//        let pairs = try container.allKeys.map { key -> (Key, Field<Value>) in
//
//            let field = try container.decode(
//                Field<Value>.self,
//                forKey: key
//            )
//
//            return (key, field)
//
//        }
//
//        self.storage = Dictionary(uniqueKeysWithValues: pairs)
//
//    }
//
//}

enum ScalarValue: Codable, ExpressibleByNilLiteral, ExpressibleByStringLiteral, ExpressibleByIntegerLiteral, Comparable {

    case string(String)

    case integer(Int)
    
    case null
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.singleValueContainer()
        
        if let value = try? container.decode(String.self) { self = .string(value) }
        else if let value = try? container.decode(Int.self) { self = .integer(value) }
        else { self = .null }
        
    }
    
    func encode(to encoder: Encoder) throws {
        
        var container = encoder.singleValueContainer()
        
        switch self {
            
        case let .string(value): try container.encode(value)
            
        case let .integer(value): try container.encode(value)
            
        case .null: try container.encodeNil()
            
        }
        
    }
    
    init(stringLiteral value: String) { self = .string(value) }
    
    init(integerLiteral value: Int) { self = .integer(value) }
    
    init(nilLiteral: () ) { self = .null }
    
    static func < (lhs: ScalarValue, rhs: ScalarValue) -> Bool {
        
        switch (lhs, rhs) {
            
        case let ( .string(lhsValue), .string(rhsValue) ): return lhsValue < rhsValue
            
        case let ( .integer(lhsValue), .integer(rhsValue) ): return lhsValue < rhsValue
            
        case (.null, .null): return false
            
        default: return false
            
        }
    
    }
    
    public static func <= (lhs: ScalarValue, rhs: ScalarValue) -> Bool {
        
        switch (lhs, rhs) {
            
        case let ( .string(lhsValue), .string(rhsValue) ): return lhsValue <= rhsValue
            
        case let ( .integer(lhsValue), .integer(rhsValue) ): return lhsValue <= rhsValue
            
        case (.null, .null): return true
            
        default: return false
            
        }
        
    }
    
    static func >= (lhs: ScalarValue, rhs: ScalarValue) -> Bool {
        
        switch (lhs, rhs) {
            
        case let ( .string(lhsValue), .string(rhsValue) ): return lhsValue >= rhsValue
            
        case let ( .integer(lhsValue), .integer(rhsValue) ): return lhsValue >= rhsValue
            
        case (.null, .null): return true
            
        default: return false
            
        }
        
    }
    
    public static func > (lhs: ScalarValue, rhs: ScalarValue) -> Bool {
        
        switch (lhs, rhs) {
            
        case let ( .string(lhsValue), .string(rhsValue) ): return lhsValue > rhsValue
            
        case let ( .integer(lhsValue), .integer(rhsValue) ): return lhsValue > rhsValue
            
        case (.null, .null): return false
            
        default: return false
            
        }
        
    }

}

enum ProductKey: String, CodingKey, Decodable {
    
    case title, quantity
    
}

struct Product: Codable {
    
    var title: String
    
    var quantity: Int
    
    enum CodingKeys: String, CodingKey, Encodable {
        
        case title, quantity
        
    }
    
}

let form: Form<Product.CodingKeys, Any> = [
    .title: Field(
        value: "Chocolate",
        rules: []
    ),
    .quantity: Field(
        value: 2,
        rules: []
    )
]

let form2: AnyForm = [
    Product.CodingKeys.title: Field(
        value: "Chocolate",
        rules: []
    ),
    Product.CodingKeys.quantity: Field(
        value: 2,
        rules: []
    )
]

var form3: Form<Product.CodingKeys, ScalarValue> = [
    .title: Field(
        value: "Chocolate",
        rules: [ ]
    ),
    .quantity: Field(
        value: 2,
        rules: [
            AnyValidationRule( NonNullRule() ),
            AnyValidationRule( GreaterThanRule(lowerBound: 1) )
        ]
    )
]

form3[.title]?.rules.append(.nonNull)

let data = try JSONEncoder().encode(form3)

let product = try JSONDecoder().decode(
    Product.self,
    from: data
)

print(product)

print("End")
