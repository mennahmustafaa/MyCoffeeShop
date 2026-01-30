//
//  NotificationViewModel.swift
//  MyCoffeeShop
//
//  Created by Antigravity on 30/01/2026.
//

import Foundation

class NotificationViewModel: ObservableObject {
    @Published var notifications: [NotificationItem] = NotificationItem.dummyNotifications
    
    var unreadCount: Int {
        notifications.filter { !$0.isRead }.count
    }
    
    func markAsRead(_ notification: NotificationItem) {
        if let index = notifications.firstIndex(where: { $0.id == notification.id }) {
            notifications[index] = NotificationItem(
                title: notification.title,
                message: notification.message,
                time: notification.time,
                type: notification.type,
                isRead: true
            )
        }
    }
    
    func markAllAsRead() {
        notifications = notifications.map { notification in
            NotificationItem(
                title: notification.title,
                message: notification.message,
                time: notification.time,
                type: notification.type,
                isRead: true
            )
        }
    }
    
    func deleteNotification(_ notification: NotificationItem) {
        notifications.removeAll { $0.id == notification.id }
    }
}
