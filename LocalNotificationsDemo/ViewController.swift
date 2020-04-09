//
//  ViewController.swift
//  LocalNotificationsDemo

import UIKit
import UserNotifications

class ViewController: UIViewController {
    
    let minutesBeforeBell = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        scheduleNotification(isZeroHour: isTuesday())
        
    }
    
    func scheduleNotification(isZeroHour: Bool) {
        
        // Ask for notification permission
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            if granted {
                print("Yay! These notifications actually might work.")
            } else {
                print("Screw you, matey!")
            }
        }
        
        // Create notification content
        let content = UNMutableNotificationContent()
        content.title = "Mr. Blue Sky says..."
        content.body = "Put Monitors Away! Beep Boop!"
        //content.sound = UNNotificationSound.default
        content.sound = UNNotificationSound.init(named: UNNotificationSoundName(rawValue: "baby.wav"))
        
        
        // Create notification trigger
        var dateComponents = DateComponents()
        if isZeroHour {
            dateComponents.hour = 11
            dateComponents.minute = 21 - minutesBeforeBell
            dateComponents.second = 0
            print("Planning on Running a Zero Hour Schedule.")
        } else {
            //dateComponents.hour = 10
            //dateComponents.minute = 53 - minutesBeforeBell
            dateComponents.hour = 10
            dateComponents.minute = 32
            dateComponents.second = 0
            print("Planning on Running a Regular Schedule.")
        }
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        // Create the request
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        // Register (Schedule) the request
        center.add(request) { (error) in
            if error != nil {
                print("There were errors.")
            } else {
                print("Error-free!")
            }
        }
        
        print ("Scheduled for Hours: \(dateComponents.hour!), Minutes: \(dateComponents.minute!), Seconds: \(dateComponents.second!)")
    }
    
    func isTuesday() -> Bool {
        let date = Date()
        let calendar = Calendar.current
        return calendar.component(.weekday, from: date) == 3
    }
    
}

