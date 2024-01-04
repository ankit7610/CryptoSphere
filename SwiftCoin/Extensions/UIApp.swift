//
//  UIApp.swift
//  SwiftCoin
//
//  Created by Ankit Kaushik on 24/12/23.
//

import Foundation
import SwiftUI
extension UIApplication{
    func endEditing(){
        sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
    }
}
