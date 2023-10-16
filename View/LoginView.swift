//
//  LoginView.swift
//  Diario Alimentar
//
//  Created by Sydy on 12/10/23.
//

import SwiftUI
import Firebase
import GoogleSignIn

struct LoginView: View {
    
//    @StateObject var loginModel: LoginViewModel = .init()
    @State private var err: String = ""
    @State var email = ""
    @State var senha = ""
    @State var lembrarSenha = false
    
    
    //    @State private var userLoggedIn = (Auth.auth().currentUser != nil)
    
    var logo: some View{
        HStack{
            Image("Logo")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(alignment: .center)
                .clipped()
        }
        .foregroundColor(.white)
    }
    
    var buttons: some View{
        VStack(spacing: 16){
            let bg = Color("purpleButton")
            let fg = Color.white
            
            
            Text(err).foregroundColor(.red).font(.caption)
            Button("Criar conta", action: {})
            //                .buttonStyle(FillButtonStyle(background: bg, foreground: fg))
                .font(.callout.bold())
            
            Button{
                Task {
                    do {
                        try await Authentication().googleOauth()
                    } catch let e {
                        print(e)
                        err = e.localizedDescription
                    }
                }
            }label: {
                    
                    HStack(spacing: 10) {
                        Image("Google").resizable()
                        Text("Continuar com Google")
                    }
                
            }.buttonStyle(.borderedProminent)
            
            Button(action: {}){
                HStack(spacing: 10){
                    Image(systemName: "apple.logo")
                    Text("Continuar com Apple")
                }
            }
                .foregroundColor(.white)
                .background(.black)
                .cornerRadius(100)
                .font(.headline.bold())
            
            
            
//            Button(action: {}){
//                Group{
//                    Text("Já possui uma conta?")
//                        .foregroundColor(Color(uiColor: .systemGray3))
//                    Text("Entre")
//                }
//            }
        }
    }
    
    var body: some View {
        
        VStack{
            Spacer()
            Image("Logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
            
//            Text("Crie sua conta")
//                .font(.title.bold())
//
//            VStack(alignment: .leading, spacing: 8){
//                TextField("Email", text: $email)
//                    .textFieldStyle(.plain)
//                    .frame(height: 40)
//                    .clipShape(Capsule())
//                    .padding()
//                    .overlay(RoundedRectangle(cornerRadius:10.0).strokeBorder(Color.gray, style: StrokeStyle(lineWidth: 1.0)))
//                    .padding()
//            }
//            VStack(alignment: .leading, spacing: 8){
//                HStack{
//                    TextField("Senha", text: $senha)
//                        .padding()
//                                    .overlay(
//                                        RoundedRectangle(cornerRadius: 15)
//                                            .stroke(Color.blue, lineWidth: 2)
//                                    ).padding()
//
//                    Spacer()
//                    Button("Recuperar Senha", action: {})
//                }
//                Toggle("Lembrar minha senha", isOn: $lembrarSenha)
//                    .font(.footnote)
//            }
            buttons
        }
        .padding(.top)
        .background(
            Color.white.ignoresSafeArea()
            )
    }
}

struct GoogleSignInButton: UIViewRepresentable {
  @Environment(\.colorScheme) var colorScheme
  
  private var button = GIDSignInButton()

  func makeUIView(context: Context) -> GIDSignInButton {
    button.colorScheme = colorScheme == .dark ? .dark : .light
    return button
  }

  func updateUIView(_ uiView: UIViewType, context: Context) {
    button.colorScheme = colorScheme == .dark ? .dark : .light
  }
}



struct LoginView_Previews:
    PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
