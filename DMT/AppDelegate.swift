//
//  AppDelegate.swift
//  ServerRequestManager
//
//  Created by Synergy on 27/03/18. 
//  Copyright © 2018 Synergy.com.nl. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseMessaging
import FirebaseInstanceID
import UserNotifications

class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow? 
    var instanceIDTokenMessage: String?
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound] ) { (isGranted, error) in
            if error != nil {
                print("Eroare aparuta la autorizare!")
            } else {
                UNUserNotificationCenter.current().delegate = self
                Messaging.messaging().delegate = self
                DispatchQueue.main.async(execute: {
                    application.registerForRemoteNotifications()
                })
                
            }
            
        }
        FirebaseApp.configure()
        return true
    }

    func connectToFirebase() {
        Messaging.messaging().shouldEstablishDirectChannel = true
        
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        
        Messaging.messaging().shouldEstablishDirectChannel = false
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        
        connectToFirebase()
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
    }
    
}

extension AppDelegate {
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        if(application.applicationState == UIApplicationState.inactive)
        {
            print("Inactive")
            //Show the view with the content of the push
            completionHandler(.newData)
            
        }else if (application.applicationState == UIApplicationState.background){
            
            print("Background")
            //Refresh the local model
            completionHandler(.newData)
            
        }else{
            
            print("Active")
            //Show an in-app banner
            completionHandler(.newData)
        }
        
        
        if let messageID = userInfo[pushNotification.gcmMessageIDKey],
            let name = userInfo[pushNotification.name],
            let location = userInfo[pushNotification.location],
            let message = userInfo[pushNotification.message]{
            print("Message ID  : \(messageID)")
            print("Message name : \(name)")
            print("Message location : \(location)")
            print("Message  : \(message)")
            
        }
        if let aps = userInfo[pushNotification.aps] {
            print("Message aps  : \(aps)")
            
        }
        
        print("userInfo = \(userInfo)")
        
        NotificationCenter.default.post(name: pushNotification.receivedNotification, object: nil)
        
    }
    
}


extension AppDelegate:MessagingDelegate {
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("nu avem token!!!")
    }
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        
        InstanceID.instanceID().instanceID { (result, error) in
            if let error = error {
                print("Error fetching remote instange ID: \(error)")
            } else if let result = result {
                print(" --- Remote instance ID token: \(result.token) --- ")
                self.instanceIDTokenMessage  = "Remote InstanceID token: \(result.token)"
            }
        }
        connectToFirebase()
        
    }
    
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        print("Received data message: \(remoteMessage.appData)")
    }
}



