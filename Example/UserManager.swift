//
//  UserManager.swift
//  TinyKitExample
//
//  Created by Roy Hsu on 17/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UserManager

import Foundation
import Hydra

public final class UserManager {
    
    public final func fetchUser(
        in context: Context,
        userId: String
    )
    -> Promise<User> {
        
        return Promise(in: context) { fulfill, _, _ in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                
                let user = User(
                    pictureURL: nil,
                    name: "Maecenas sed diam eget risus varius blandit sit amet non magna. Vestibulum id ligula porta felis euismod semper.",
                    introduction: "Nullam quis risus eget urna mollis ornare vel eu leo. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Sed posuere consectetur est at lobortis. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Maecenas sed diam eget risus varius blandit sit amet non magna. Cras justo odio, dapibus ac facilisis in, egestas eget quam."
                )
                
                fulfill(user)
                
            }
            
        }
        
    }
    
}
