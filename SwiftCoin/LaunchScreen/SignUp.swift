//
//  SignUp.swift
//  SwiftCoin
//
//  Created by Ankit Kaushik on 02/01/24.
//

import SwiftUI

struct SignUp: View {
    @State var email=""
    @State var password=""
    @State var name=""
    var body: some View {
        NavigationView{
            ZStack{
                Color.black.ignoresSafeArea()
                    VStack{
                        HStack{
                            Text("✨")
                                .font(.system(size:50))
                            Spacer()
                            RoundedRectangle(cornerRadius:1)
                                .fill(.white)
                                .frame(width:250,height:2)
                        }
                        .padding(40)
                        VStack{
                            Text("Create an account✨")
                                .font(.title)
                                .bold()
                                .foregroundColor(.white)
                                .offset(x:-50,y:-20)
                            Text("Welcome! Please enter your details")
                                .foregroundColor(Color.gray)
                                .offset(x:-50)
                        }
                        VStack{
                            Text("Name")
                                .bold()
                                .offset(x:-160,y:20)
                            TextField("Enter your name", text:$name)
                                .accentColor(.black)
                                .padding()
                                .foregroundColor(.black)
                                .background(Color.white.opacity(0.8))
                                .cornerRadius(10)
                                .padding()
                            Text("Email")
                                .bold()
                                .offset(x:-160,y:20)
                            TextField("Enter your email", text:$email)
                                .accentColor(.black)
                                .padding()
                                .foregroundColor(.black)
                                .background(Color.white.opacity(0.8))
                                .cornerRadius(10)
                                .padding()
                            Text("Password")
                                .bold()
                                .offset(x:-145,y:20)
                            SecureField("Enter your password", text:$password)
                                .padding()
                                .accentColor(.black)
                                .foregroundColor(.black)
                                .background(Color.white.opacity(0.8))
                                .cornerRadius(10)
                                .padding()
                        }
                        .foregroundColor(.white)
                        Spacer()
                        VStack(spacing:25){
                            RoundedRectangle(cornerRadius:10)
                                .fill(
                                    LinearGradient(colors:[.pink.opacity(0.8),.purple.opacity(0.8)], startPoint:.leading, endPoint:.trailing)
                                )
                                .frame(width:400,height:60)
                                .overlay {
                                    Text("Sign up")
                                        .foregroundColor(.white)
                                        .font(.system(size:25))
                                        .bold()
                                }
                            RoundedRectangle(cornerRadius:10)
                                .stroke(Color.white,lineWidth:1)
                                .frame(width:400,height:60)
                                .overlay {
                                    HStack{
                                        Image("google")
                                            .resizable()
                                            .frame(width:60,height:60)
                                        Text("Log in with Google")
                                            .foregroundColor(.white)
                                            .font(.system(size:25))
                                            .bold()
                                    }
                                }
                            Spacer(minLength:10)
                        }
                    }
                }
        }
    }
}

#Preview {
    SignUp()
}
