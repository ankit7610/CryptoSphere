//
//  LoginPage.swift
//  SwiftCoin
//
//  Created by Ankit Kaushik on 02/01/24.
//

import SwiftUI

struct LoginPage: View {
    @State var email=""
    @State var password=""
    @Binding var login:Bool
    var body: some View {
        NavigationView{
            ZStack{
                Color.black.opacity(01).ignoresSafeArea()
                VStack{
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
                        VStack(alignment:.leading){
                            Text("Login to your account✨")
                                .font(.title)
                                .bold()
                                .foregroundColor(.white)
                                .offset(x:-20,y:-20)
                            Text("Welcome back! Please enter your details")
                                .foregroundColor(Color.gray)
                                .offset(x:-20)
                        }
                        Spacer()
                        VStack{
                            Text("Email")
                                .bold()
                                .offset(x:-160,y:20)
                            TextField("Enter your email", text:$email)
                                .padding()
                                .accentColor(.black)
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
                            Text("Forgot Password")
                                .bold()
                                .offset(x:110)
                            Spacer()
                        }
                        .foregroundColor(.white)
                        VStack(spacing:25){
                            Button{
                                withAnimation(.spring()){
                                    login.toggle()
                                }
                            } label: {
                                RoundedRectangle(cornerRadius:10)
                                    .fill(
                                        LinearGradient(colors:[.pink.opacity(0.8),.purple.opacity(0.8)], startPoint:.leading, endPoint:.trailing)
                                    )
                                    .frame(width:400,height:60)
                                    .overlay {
                                        Text("Log In")
                                            .foregroundColor(.white)
                                            .font(.system(size:25))
                                            .bold()
                                    }
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
                                    .offset(x:-4)
                                }
                            RoundedRectangle(cornerRadius:10)
                                .stroke(Color.white,lineWidth:1)
                                .frame(width:400,height:60)
                                .overlay {
                                    HStack{
                                        Image("apple")
                                            .resizable()
                                            .frame(width:45,height:45)
                                        Text("Log in with Apple")
                                            .foregroundColor(.white)
                                            .font(.system(size:25))
                                            .bold()
                                    }
                                    .offset(x:-10)
                                }
                        }
                    }
                    .offset(y:-40)
                        Spacer(minLength:50)
                        HStack{
                            Text("Don't have an account?")
                                .foregroundColor(.gray)
                            NavigationLink{
                                SignUp()
                            } label: {
                                Text("Sign up")
                                    .foregroundColor(.white)
                                    .bold()
                            }
                        }
                    }
                }
        }
    }
}

#Preview {
    LoginPage(login:.constant(true))
}
