//
//  UserData.swift
//  Quiz Buddy
//
//  Created by Nathan Justin on 6/13/17.
//  Copyright © 2017 Nathan Justin. All rights reserved.
//

import Realm

class Question: RLMObject {
    dynamic var question = ""
    dynamic var correct = ""
    dynamic var incorrect = RLMArray(objectClassName: "RLMString")
}

class Quiz: RLMObject {
    dynamic var name = ""
    let questions = RLMArray(objectClassName: "Question")
    dynamic var prevScore = 0
}

/*
class UserData: RLMObject {
    dynamic var userID = ""
    dynamic var photoURL: URL? = nil
    let quizzes = List<Quiz>()
}
*/
