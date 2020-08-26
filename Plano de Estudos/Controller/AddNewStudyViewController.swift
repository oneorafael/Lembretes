//
//  AddNewStudyViewController.swift
//  Plano de Estudos
//
//  Created by Rafael Oliveira on 20/08/20.
//

import UIKit
import UserNotifications

class AddNewStudyViewController: UIViewController {
    @IBOutlet weak var tfcourse: UITextField!
    @IBOutlet weak var tfTopic: UITextField!
    @IBOutlet weak var dpDate: UIDatePicker!
    @IBOutlet weak var btAdd: UIButton!
    
    let sm = StudyPlanManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dpDate.minimumDate = Date()
    }
    
    
    // MARK: - Navigation

    @IBAction func AddNewTopic(_ sender: UIButton) {
        let id = String(Date().timeIntervalSince1970)
        let studyPlan = StudyPlan(course: tfcourse.text! , topic: tfTopic.text!, date: dpDate.date, done: false, id:id)
    
        
        let content = UNMutableNotificationContent()
        content.title = "Lembrete"
        content.subtitle = "Materia: \(studyPlan.course)"
        content.body = "Estudar \(studyPlan.topic)"
        
        content.categoryIdentifier = "Lembrete"
        
        let dateComponent = Calendar.current.dateComponents([.year , .month, .day , .hour, .minute], from: dpDate.date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: false)
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
        
        sm.addPlan(studyPlan)
        navigationController?.popViewController(animated: true)
        
    }
    

}
