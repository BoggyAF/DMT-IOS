//
//  Constants.swift
//  DMT
//
//  Created by Boggy on 04/03/2018.
//  Copyright © 2018 Boggy. All rights reserved. 
//

import Foundation
import UIKit
struct UserDefaultsKeys {
    static let rememberSwitchState = "switchState"
    static let savedEmail = "savedEmail"
    static let savedPassword = "passwordEmail"
    static let noEmail = ""
    static let noPassword = ""
}

struct pushNotification{
    static let gcmMessageIDKey = "gcm.message_id"
    static let name = "name"
    static let location = "location"
    static let message = "google.c.a.c_l"
    static let aps = "aps"
    static let receivedNotification = Notification.Name(rawValue:"NotificationReceived")
}


struct Constraints{
    
    static let topBarHeight = UIApplication.shared.statusBarFrame.size.height + 44.0
}
