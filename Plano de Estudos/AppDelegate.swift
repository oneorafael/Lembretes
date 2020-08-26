//
//  AppDelegate.swift
//  Plano de Estudos
//
//  Created by Rafael Oliveira on 20/08/20.
//

import UIKit
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var uncenter = UNUserNotificationCenter.current()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        uncenter.delegate = self
        uncenter.getNotificationSettings { (settings) in
            if settings.authorizationStatus == .notDetermined {
                let options: UNAuthorizationOptions = [.alert,.sound]
                self.uncenter.requestAuthorization(options: options) { (success, error) in
                    if error == nil {
                        print(success)
                    } else {
                        print(error!.localizedDescription)
                    }
                }
            }
            else if settings.authorizationStatus == .denied {
                print("usuario negou autorização")
            }
        }
        
        let confirmAction = UNNotificationAction(identifier: "Confirm", title: "Já Estudei", options: [.foreground])
        let cancelAction = UNNotificationAction(identifier: "Cancel", title: "Cancelar", options: [.destructive])
        let category = UNNotificationCategory(identifier: "Lembrete", actions: [confirmAction,cancelAction], intentIdentifiers: [], options: [.customDismissAction])
        uncenter.setNotificationCategories([category])
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert,.sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let id = response.notification.request.identifier
        print(id)
        
        print("DidReceive Response")
        switch response.actionIdentifier {
        case "Confirm":
            print("usuario já estudou a materia")
            NotificationCenter.default.post(name: NSNotification.Name("Confirmed"), object: nil, userInfo: ["id": id])
        case "Cancel":
            print("Usuario cancelou")
        case UNNotificationDefaultActionIdentifier:
            print("Tocou na propria notificação")
        default:
            break
        }
        completionHandler()

    }
}
