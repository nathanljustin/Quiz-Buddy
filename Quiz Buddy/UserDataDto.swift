//
//  UserDataDto.swift
//  Quiz Buddy
//
//  Created by Nathan Justin on 6/13/17.
//  Copyright © 2017 Nathan Justin. All rights reserved.
//

import Gloss

class QuestionDto: Decodable, Glossy {
    var question: String
    var correct: String
    var incorrect: Array<String>
    var prevScore: Int
    
    init?() {
        self.question = ""
        self.correct = ""
        self.incorrect = ["","",""]
        self.prevScore = 0
    }
    
    required init?(json: JSON) {
        self.question = ("question" <~~ json)!
        self.correct = ("correct" <~~ json)!
        self.incorrect = ("incorrect" <~~ json)!
        self.prevScore = ("prevScore" <~~ json)!
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            "question" ~~> self.question,
            "correct" ~~> self.correct,
            "incorrect" ~~> self.incorrect
            ])
    }
}

class QuizDto: Decodable, Glossy {
    var name: String
    var questions: [QuestionDto]
    var prevScore = 0
    
    init?() {
        self.name = ""
        self.questions = []
        self.prevScore = 0
    }
    
    required init?(json: JSON) {
        self.name = ("name" <~~ json)!
        self.questions = ("questions" <~~ json)!
        self.prevScore = ("prevScore" <~~ json)!
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            "name" ~~> self.name,
            "questions" ~~> self.questions,
            "prevScore" ~~> self.prevScore
            ])
    }
}
/*
class UserDataDto: Decodable, Glossy {
    var userID: String
    var photoURL: URL
    var quizzes: List<Quiz>
    
    init?() {
        self.userID = ""
        self.photoURL = nil
        self.quizzes = List<Quiz>()
    }
    
    required init?(json: JSON) {
        self.userID = "userID" <~~ json
        self.photoURL = "photoURL" <~~ json
        self.quizzes = "quizzes" <~~ json
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            "userID" ~~> self.userID,
            "photoURL" ~~> self.photoURL,
            "quizzes" ~~> self.quizzes
            ])
    }

    
}
*/
