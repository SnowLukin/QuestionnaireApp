//
//  Question.swift
//  QuestionnaireApp
//
//  Created by Snow Lukin on 21.12.2021.
//

import UIKit

struct Question {
    let title: String
    let type: ResponseType
    let answers: [Answer]
    
    static func getQuestions() -> [Question] {
        [
            Question(
                title: "What meal you prefer?",
                type: .single,
                answers: [
                    Answer(title: "Steak", type: .dog),
                    Answer(title: "Fish", type: .cat),
                    Answer(title: "Carrot", type: .rabbit),
                    Answer(title: "Corn", type: .turtle)
                         ]
            ),
            Question(
                title: "What do you like the most?",
                type: .multiple,
                answers: [
                    Answer(title: "Swim", type: .dog),
                    Answer(title: "Sleep", type: .cat),
                    Answer(title: "Hug", type: .rabbit),
                    Answer(title: "Eat", type: .turtle)
                ]
            ),
            Question(
                title: "Do you like driving?",
                type: .ranged,
                answers: [
                    Answer(title: "Hate", type: .cat),
                    Answer(title: "Nervous", type: .rabbit),
                    Answer(title: "Not interested", type: .turtle),
                    Answer(title: "Adore", type: .dog)
                ]
            )
        ]
    }
}

enum ResponseType {
    case single
    case multiple
    case ranged
}

struct Answer {
    let title: String
    let type: AnimalType
}

enum AnimalType: Character {
    case dog = "🐶"
    case cat = "🐱"
    case rabbit = "🐰"
    case turtle = "🐢"
    
    var definition: String {
        switch self {
        case .dog:
            return "You like being with friends. You love being among people who you like and who always ready to help."
        case .cat:
            return "You enjoy being lonely and especially take a walk alone."
        case .rabbit:
            return "You love everything soft. You healthy and full of joy."
        case .turtle:
            return "Your power – wiseness. Slow and thoughtful people win long distanses"
        }
    }
}
