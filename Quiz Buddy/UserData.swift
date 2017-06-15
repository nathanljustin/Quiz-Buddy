//
//  UserData.swift
//  Quiz Buddy
//
//  Created by Nathan Justin on 6/13/17.
//  Copyright © 2017 Nathan Justin. All rights reserved.
//
import RealmSwift

class Question: Object {
    dynamic var question = ""
    dynamic var correct = ""
    let incorrect = List<RLMString>()
}

class Quiz: Object {
    dynamic var name = ""
    let questions = List<Question>()
    dynamic var prevScore = 0
}
