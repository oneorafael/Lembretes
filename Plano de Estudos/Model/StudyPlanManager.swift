//
//  StudyPlanManager.swift
//  Plano de Estudos
//
//  Created by Rafael Oliveira on 20/08/20.
//

import Foundation
class StudyPlanManager {
    static let shared = StudyPlanManager()
    let ud = UserDefaults.standard
    
    var studyPlans: [StudyPlan] = []
    private init(){
        if let data = ud.data(forKey: "studyPlans"), let plans = try? JSONDecoder().decode([StudyPlan].self, from: data) {
            self.studyPlans = plans
        }
    }
    
    func savePlan(){
        if let data = try? JSONEncoder().encode(studyPlans) {
            ud.setValue(data, forKey: "studyPlans")
        }
    }
    
    func addPlan(_ studyPlan: StudyPlan){
        studyPlans.append(studyPlan)
        savePlan()
        
    }
    
    func removePlan(at index: Int){
        studyPlans.remove(at: index)
        savePlan()
    }
    
    func setPlanDone(id:String){
        if let studyPlan = studyPlans.first(where: {$0.id == id}){
            studyPlan.done = true
            savePlan()
        }
    }
    
}
