//
//  XmarkView.swift
//  SwiftCoin
//
//  Created by Ankit Kaushik on 28/12/23.
//

import SwiftUI

struct XmarkView: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        Button{
            presentationMode.wrappedValue.dismiss()
        } label: {
            Image(systemName:"xmark")
                .font(.headline)
        }
    }
}

#Preview {
    XmarkView()
}
