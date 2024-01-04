//
//  HapticManager.swift
//  SwiftCoin
//
//  Created by Ankit Kaushik on 30/12/23.
//

import Foundation
import SwiftUI
class HapticManager{
    static private let Generator = UINotificationFeedbackGenerator()
    static func notification(type:UINotificationFeedbackGenerator.FeedbackType){
        Generator.notificationOccurred(type)
    }
}
