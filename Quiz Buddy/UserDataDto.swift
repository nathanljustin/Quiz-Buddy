//
//  UserDataDto.swift
//  Quiz Buddy
//
//  Created by Nathan Justin on 6/13/17.
//  Copyright © 2017 Nathan Justin. All rights reserved.
//
import Gloss
import RealmSwift

class QuestionDto: Decodable, Glossy {
    var question: String
    var correct: String
    var incorrect: [RLMString]
    var prevScore: Int
    
    init?() {
        self.question = ""
        self.correct = ""
        self.incorrect = []
        self.prevScore = 0
    }
    
    // Deserialize
    required init?(json: JSON) {
        self.question = ("question" <~~ json)!
        self.correct = ("correct" <~~ json)!
        self.incorrect = ("incorrect" <~~ json)!
        self.prevScore = ("prevScore" <~~ json)!
    }
    
    // Serialize
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
    var numberOfQuestions = 0
    
    init?() {
        self.name = ""
        self.questions = []
        self.prevScore = 0
        self.numberOfQuestions = 0
    }
    
    // Deserialize
    required init?(json: JSON) {
        self.name = ("name" <~~ json)!
        self.questions = ("questions" <~~ json)!
        self.prevScore = ("prevScore" <~~ json)!
        self.numberOfQuestions = ("numberOfQuestions" <~~ json)!
    }
    
    // Serialize
    func toJSON() -> JSON? {
        return jsonify([
            "name" ~~> self.name,
            "questions" ~~> self.questions,
            "prevScore" ~~> self.prevScore,
            "numberOfQuestions" ~~> self.numberOfQuestions
            ])
    }
}
