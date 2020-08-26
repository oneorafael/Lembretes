//
//  StudyPlanTableViewController.swift
//  Plano de Estudos
//
//  Created by Rafael Oliveira on 20/08/20.
//

import UIKit

class StudyPlanTableViewController: UITableViewController {
    
    let sm = StudyPlanManager.shared
    let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "dd.MMM  HH:mm"
        return df
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(onReceive(notification:)), name: NSNotification.Name("Confirmed"), object: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    @objc func onReceive(notification:Notification) {
        if let userInfo = notification.userInfo, let id = userInfo["id"] as? String {
            sm.setPlanDone(id: id)
            tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sm.studyPlans.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let sp = sm.studyPlans[indexPath.row]
        cell.textLabel?.text = sp.topic
        cell.detailTextLabel?.text = dateFormatter.string(from: sp.date)
        cell.backgroundColor = sp.done ? .systemBlue : .white
        cell.textLabel?.textColor = sp.done ? .white : .black
        cell.detailTextLabel?.textColor = sp.done ? .white : .black
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            sm.removePlan(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .bottom)        }
    }
   

}
