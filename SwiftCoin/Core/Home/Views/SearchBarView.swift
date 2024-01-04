//
//  SearchBarView.swift
//  SwiftCoin
//
//  Created by Ankit Kaushik on 24/12/23.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText:String
    var body: some View {
        HStack{
            Image(systemName:"magnifyingglass")
                .foregroundColor(
                    searchText.isEmpty ? Color.theme.Secondary:Color.theme.accent
                )
            TextField("Search by name or symbol", text:$searchText)
                .autocorrectionDisabled()
                .overlay(
                    Image(systemName:"xmark.circle.fill")
                        .padding()
                        .offset(x:10)
                        .foregroundColor(Color.theme.accent)
                        .opacity(searchText.isEmpty ? 0.0:1.0)
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                            searchText.removeAll()
                        }
                    ,alignment:.trailing
                )
        }
        .font(.headline)
        .padding()
        .background(
        RoundedRectangle(cornerRadius:25)
            .fill(Color.theme.background)
            .shadow(
                color:Color.theme.accent.opacity(0.15),
                radius:10,x:0,y:0)
            )
        .padding()
    }
}

#Preview {
    SearchBarView(searchText:.constant(""))
}
