//
//  LaunchV.swift
//  SwiftCoin
//
//  Created by Ankit Kaushik on 01/01/24.
//

import SwiftUI

struct LaunchV: View {
    @State var loadingText:[String]="Loading...".map{String($0)}
    @State var timer = Timer.publish(every:0.1, on:.main, in:.common).autoconnect()
    @State var showloadingView:Bool=false
    @State var counter=0
    var body: some View {
        ZStack{
            Color.launch.background
                .ignoresSafeArea()
            Image("logo")
                .resizable()
                .frame(width:100,height:100)
            ZStack{
                if showloadingView{
                    HStack(spacing:0){
                        ForEach(loadingText.indices){ index in
                            Text(loadingText[index])
                                .font(.headline)
                                .fontWeight(.heavy)
                                .foregroundColor(Color.launch.accent)
                                .offset(y:counter == index ? -5:0)
                        }
                    }
                    .transition(AnyTransition.scale.animation(.easeIn))
                }
            }
            .offset(y:70)
        }
        .onAppear{
            showloadingView.toggle()
        }
        .onReceive(timer, perform: { _ in
            withAnimation(.spring){
                counter=counter+1
                if(counter==10){
                    counter=0
                }
            }
        })
    }
}

#Preview {
    LaunchV()
}
