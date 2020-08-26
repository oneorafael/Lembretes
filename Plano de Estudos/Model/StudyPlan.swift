//
//  StudyPlan.swift
//  Plano de Estudos
//
//  Created by Rafael Oliveira on 20/08/20.
//

import Foundation
class StudyPlan: Codable {
    
    // MARK - Properthies
    var course: String
    var topic: String
    var date: Date
    var done: Bool = false
    var id: String
    
    init(course:String, topic: String, date: Date, done: Bool, id: String) {
        self.course = course
        self.date = date
        self.done = done
        self.id = id
        self.topic = topic
    }
}
