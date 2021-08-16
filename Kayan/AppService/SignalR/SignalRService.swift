//
//  SignalRService.swift
//  Kayan
//
//  Created by Sandal on 08/01/1443 AH.
//

import Foundation
import SwiftSignalRClient
import SwiftUI
import SwiftyJSON
var is_payment_success=false
public class SignalRService :ObservableObject{
    private var connection: HubConnection
//    @Published  var newOrder:Bag=Bag()
//    @Published var chatMessage:[StroryModal] = []
    public init(url: URL) {
        connection = HubConnectionBuilder(url:url).withLogging(minLogLevel: .error).build()
        connection.on(method: "ToNotfiyPayment", callback: { (message: JSON) in
            do {
                print(self.connection.connectionId)
                print(message)
                if message["status"].intValue == 1{
                     is_payment_success=true
                    self.setNotification(message: message["msg"].stringValue, messagetype: "")
                }
//                else {
//                    therAreNewState=true
//                    self.setNotification(message: message["msg"].stringValue, messagetype: "")
//                }
                print(message)
            } catch {
                print(error)
            }
        })
//        connection.on(method: "ToSendMsg", callback: { (message: JSON) in
//            do {
//                print(message)
////                self.setNotification(message: message.stringValue)
//                self.chatMessage.append(Message( message: message.stringValue, myMsg: true, profilePic: "logo", photo: nil))
//                self.setNotification(message: message["msg"].stringValue,messagetype:"chatMessage")
//            } catch {
//                print(error)
//            }
//        })
//
        connection.start()
    }
    func setNotification(message:String,messagetype:String?) -> Void {
//        getOrder()
            let manager = LocalNotificationManager()
            manager.addNotification(title: message)
        manager.scheduleNotifications(messagetype: messagetype)
        }
   

//func getOrder(){
//
//    RestAPI().getData(endUrl:Connection().getUrl(word: "GetNewOrder"), parameters: [:]) { result in
//
//       let sectionR = JSON(result!)
//        print(sectionR)
//        if sectionR["responseCode"].int == 200{
//
//
//                        let jsonDatas = try! JSONEncoder().encode(sectionR["response"])
//            let users = try! JSONDecoder().decode([NewOrder].self, from: jsonDatas)
////            self.newOrder.items=users
//
//            self.newOrder.objectWillChange.send()
//            self.newOrder.items=users
//            self.newOrder.objectWillChange.send()
//            print( self.newOrder.items)
//        }
//
//    } onError: { error in
//        print(error)
//    }
//}
}
class LocalNotificationManager {
    
    init ()
    {
        requestPermission()
    }
    var notifications = [Notification]()
    func requestPermission() -> Void {
        UNUserNotificationCenter
            .current()
            .requestAuthorization(options: [.sound, .badge, .alert]) { granted, error in
                if granted == true && error == nil {
                    
                }
        }
    }
    func addNotification(title: String) -> Void {
        notifications.append(Notification(id: UUID().uuidString, title: title))
    }
    func scheduleNotifications(messagetype:String?) -> Void {
        for notification in notifications {
            let content = UNMutableNotificationContent()
            content.sound = UNNotificationSound.default
            content.title = "تم الاشتراك بنجاح"
            content.subtitle = "استمتع معنا"
            content.body = notification.title
//            if messagetype != "chatMessage"{
//                content.sound=UNNotificationSound(named: UNNotificationSoundName(rawValue:"squirrel_sound.mpeg"))
//            }
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
            let request = UNNotificationRequest(identifier: notification.id, content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { error in
                guard error == nil else { return }
                print("Scheduling notification with id: \(notification.id)")
            }
            trigger.nextTriggerDate()
        }
    }
}

struct Notification {
    var id: String
    var title: String
}
