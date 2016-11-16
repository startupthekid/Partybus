//
//  ApplicationProtocol.swift
//  Partybus
//
//  Created by Brendan Conron on 11/15/16.
//  Copyright © 2016 Swoopy Studios. All rights reserved.
//

import Foundation
import UIKit

protocol ApplicationProtocol {

    var applicationState: UIApplicationState { get }
    var applicationIconBadgeNumber: Int { get }
    var keyWindow: UIWindow? { get }
    var statusBarHidden: Bool { get }
    var statusBarFrame: CGRect { get }
    var scheduledLocalNotifications: [UILocalNotification]? { get set }

    func registerUserNotificationSettings(_ settings: UIUserNotificationSettings)

    func beginBackgroundTaskWithExpirationHandler(_ handler: (() -> Void)?) -> UIBackgroundTaskIdentifier
    func endBackgroundTask(_ identifier: UIBackgroundTaskIdentifier)

    func registerForRemoteNotifications()
    func unregisterForRemoteNotifications()
    var isRegisteredForRemoteNotifications: Bool { get }
    var currentUserNotificationSettings: UIUserNotificationSettings? { get }

    func cancelLocalNotification(_ notification: UILocalNotification)
    func scheduleLocalNotification(_ notification: UILocalNotification)

    func openURL(_ url: URL) -> Bool
    func canOpenURL(_ url: URL) -> Bool
    func sendEvent(_ event: UIEvent)
}

extension UIApplication: ApplicationProtocol {}
