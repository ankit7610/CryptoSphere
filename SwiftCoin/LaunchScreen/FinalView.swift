//
//  FinalView.swift
//  SwiftCoin
//
//  Created by Ankit Kaushik on 02/01/24.
//
import SwiftUI
struct FinalView: View {
    let timer=Timer.publish(every:1, on:.main, in:.common).autoconnect()
    @State var count=0
    var body: some View {
        ZStack{
            withAnimation(.default){
                LoginPage(login:.constant(true))
            }
                if(count<=2){
                    LaunchV()
                }
        }
        .onReceive(timer, perform:{ value in
            withAnimation(.spring()){
                count=count+1
            }
        }
        )
    }
    }
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        FinalView()
    }
}

