struct User {
    
    var id: Int
    
}

struct Customer {
    
    var id: String?
    
}

let user = User(id: 1)

var customer = Customer(id: nil)

let k1 = \User.id

let k2 = \Customer.id

customer[keyPath: k2] = String(user[keyPath: k1])

print(customer)

print("End")
