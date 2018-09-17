struct User {
    
    var name: String
    
    var bio: String
    
}

func updateName(_ name: String, keyPath: WritableKeyPath<User, String>, for user: inout User) {
    
    user[keyPath: keyPath] = name
    
}

var user = User(name: "Roy", bio: "Awesome")

updateName("Nice", keyPath: \.bio, for: &user)

user[keyPath: \User.name] = "Roy Hsu"

print(user)

print("End")
