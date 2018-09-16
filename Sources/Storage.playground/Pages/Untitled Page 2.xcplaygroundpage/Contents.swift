class User {
    
    var name: String
    
    init(name: String) { self.name = name }
    
}

struct Foo {
    
    let user: User
    
    init(user: User) { self.user = user }
    
}

var a = Foo(
    user: User(name: "Hello")
)

var b = a

a.user.name = "World"

print(a.user.name)

print(b.user.name)
