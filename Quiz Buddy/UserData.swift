//
//  UserData.swift
//  Quiz Buddy
//
//  Created by Nathan Justin on 6/13/17.
//  Copyright © 2017 Nathan Justin. All rights reserved.
//
import RealmSwift

class Question: Object {
    dynamic var question = "" // question
    dynamic var correct = "" // correct answer
    let incorrect = List<RLMString>() // list of incorrect answers
}

class Quiz: Object {
    dynamic var name = "" // name of quiz
    let questions = List<Question>() // list of questions
    dynamic var prevScore = 0 // previous score on quiz
    dynamic var numberOfQuestions = 0 // number of questions in quiz
}
