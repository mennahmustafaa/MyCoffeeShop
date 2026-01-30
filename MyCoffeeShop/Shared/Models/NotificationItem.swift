//
//  NotificationItem.swift
//  MyCoffeeShop
//
//  Created by Antigravity on 30/01/2026.
//

import Foundation

struct NotificationItem: Identifiable {
    let id = UUID()
    let title: String
    let message: String
    let time: String
    let type: NotificationType
    let isRead: Bool
    
    enum NotificationType {
        case order
        case promotion
        case delivery
        case general
        
        var iconName: String {
            switch self {
            case .order: return "bag.fill"
            case .promotion: return "tag.fill"
            case .delivery: return "shippingbox.fill"
            case .general: return "bell.fill"
            }
        }
        
        var color: String {
            switch self {
            case .order: return "orange"
            case .promotion: return "green"
            case .delivery: return "blue"
            case .general: return "gray"
            }
        }
    }
}

// Dummy Data
extension NotificationItem {
    static let dummyNotifications: [NotificationItem] = [
        NotificationItem(
            title: "Order Delivered! ☕",
            message: "Your Cappuccino order has been delivered. Enjoy your coffee!",
            time: "5 min ago",
            type: .delivery,
            isRead: false
        ),
        NotificationItem(
            title: "Special Offer! 🎉",
            message: "Get 20% off on all Espresso drinks today only!",
            time: "1 hour ago",
            type: .promotion,
            isRead: false
        ),
        NotificationItem(
            title: "Order Confirmed",
            message: "Your order #12345 for Latte (Medium) has been confirmed.",
            time: "2 hours ago",
            type: .order,
            isRead: true
        ),
        NotificationItem(
            title: "New Menu Items! 🆕",
            message: "Check out our new seasonal drinks - Pumpkin Spice Latte is here!",
            time: "3 hours ago",
            type: .promotion,
            isRead: true
        ),
        NotificationItem(
            title: "Order Ready for Pickup",
            message: "Your Americano is ready! Please collect from the counter.",
            time: "Yesterday",
            type: .order,
            isRead: true
        ),
        NotificationItem(
            title: "Delivery Update 🚚",
            message: "Your order is on the way! Expected arrival in 15 minutes.",
            time: "Yesterday",
            type: .delivery,
            isRead: true
        ),
        NotificationItem(
            title: "Loyalty Reward! 🌟",
            message: "You've earned 50 points! Redeem for a free coffee.",
            time: "2 days ago",
            type: .general,
            isRead: true
        ),
        NotificationItem(
            title: "Flash Sale! ⚡",
            message: "Buy 1 Get 1 Free on all Frappuccinos for the next 2 hours!",
            time: "2 days ago",
            type: .promotion,
            isRead: true
        ),
        NotificationItem(
            title: "Order Delivered",
            message: "Your Mocha order has been successfully delivered.",
            time: "3 days ago",
            type: .delivery,
            isRead: true
        ),
        NotificationItem(
            title: "Welcome to MyCoffeeShop! 👋",
            message: "Thanks for joining us! Enjoy 10% off your first order.",
            time: "1 week ago",
            type: .general,
            isRead: true
        )
    ]
}
