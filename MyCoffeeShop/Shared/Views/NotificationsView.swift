//
//  NotificationsView.swift
//  MyCoffeeShop
//
//  Created by Antigravity on 30/01/2026.
//

import SwiftUI

struct NotificationsView: View {
    @StateObject private var viewModel = NotificationViewModel()
    @Environment(\.dismiss) private var dismiss
    @State private var showContent = false
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .font(.title3)
                        .foregroundColor(.black)
                }
                
                Spacer()
                
                Text("Notifications")
                    .font(.system(size: 18, weight: .semibold))
                
                Spacer()
                
                if viewModel.unreadCount > 0 {
                    Button(action: {
                        withAnimation {
                            viewModel.markAllAsRead()
                        }
                    }) {
                        Text("Mark all")
                            .font(.caption)
                            .foregroundColor(AppTheme.Colors.primaryBrown)
                    }
                } else {
                    Color.clear
                        .frame(width: 50)
                }
            }
            .padding()
            .background(Color.white)
            
            if viewModel.notifications.isEmpty {
                // Empty state
                VStack(spacing: 16) {
                    Spacer()
                    
                    Image(systemName: "bell.slash")
                        .font(.system(size: 60))
                        .foregroundColor(.gray.opacity(0.5))
                    
                    Text("No Notifications")
                        .font(.title3)
                        .fontWeight(.semibold)
                    
                    Text("You're all caught up!")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Spacer()
                }
                .scaleFadeIn(delay: 0.2)
            } else {
                // Notifications list
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(Array(viewModel.notifications.enumerated()), id: \.element.id) { index, notification in
                            NotificationRow(notification: notification) {
                                viewModel.markAsRead(notification)
                            } onDelete: {
                                withAnimation {
                                    viewModel.deleteNotification(notification)
                                }
                            }
                            .staggeredFadeIn(index: index, delay: 0.05)
                            
                            if index < viewModel.notifications.count - 1 {
                                Divider()
                                    .padding(.leading, 70)
                            }
                        }
                    }
                    .padding(.top, 8)
                }
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            withAnimation(.easeOut(duration: 0.5).delay(0.1)) {
                showContent = true
            }
        }
    }
}

struct NotificationRow: View {
    let notification: NotificationItem
    let onTap: () -> Void
    let onDelete: () -> Void
    @State private var isPressed = false
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            // Icon
            ZStack {
                Circle()
                    .fill(iconBackgroundColor)
                    .frame(width: 50, height: 50)
                
                Image(systemName: notification.type.iconName)
                    .font(.system(size: 20))
                    .foregroundColor(iconColor)
            }
            
            // Content
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(notification.title)
                        .font(.system(size: 15, weight: notification.isRead ? .regular : .semibold))
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    if !notification.isRead {
                        Circle()
                            .fill(Color.orange)
                            .frame(width: 8, height: 8)
                    }
                }
                
                Text(notification.message)
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                    .lineLimit(2)
                
                Text(notification.time)
                    .font(.system(size: 12))
                    .foregroundColor(.gray.opacity(0.7))
                    .padding(.top, 2)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(notification.isRead ? Color.white : Color.orange.opacity(0.05))
        .scaleEffect(isPressed ? 0.98 : 1.0)
        .onTapGesture {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                isPressed = true
            }
            
            let impact = UIImpactFeedbackGenerator(style: .light)
            impact.impactOccurred()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                    isPressed = false
                }
                onTap()
            }
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
            Button(role: .destructive) {
                onDelete()
            } label: {
                Label("Delete", systemImage: "trash")
            }
        }
    }
    
    private var iconBackgroundColor: Color {
        switch notification.type {
        case .order: return Color.orange.opacity(0.1)
        case .promotion: return Color.green.opacity(0.1)
        case .delivery: return Color.blue.opacity(0.1)
        case .general: return Color.gray.opacity(0.1)
        }
    }
    
    private var iconColor: Color {
        switch notification.type {
        case .order: return .orange
        case .promotion: return .green
        case .delivery: return .blue
        case .general: return .gray
        }
    }
}

#Preview {
    NavigationStack {
        NotificationsView()
    }
}
