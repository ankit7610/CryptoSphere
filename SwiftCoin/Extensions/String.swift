//
//  String.swift
//  SwiftCoin
//
//  Created by Ankit Kaushik on 01/01/24.
//
import Foundation

extension String {
    
    
    var removingHTMLOccurances: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    
}

