//
//  RLMString.swift
//  Quiz Buddy
//
//  Created by Nathan Justin on 6/16/17.
//  Copyright © 2017 Nathan Justin. All rights reserved.
//

import RealmSwift

class RLMString: Object {
    
    dynamic var string: String = ""
    
    func getString() -> String {
        return string
    }
    
    func setString(string: String) {
        self.string = string
    }
    
}
