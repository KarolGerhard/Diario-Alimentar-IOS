//
//  Login.swift
//  Diario Alimentar
//
//  Created by Sydy on 14/10/23.
//

import SwiftUI
import GoogleSignIn

struct Login: View {
//    @EnvironmentObject var viewModel: LoginViewModel
    @State private var err: String = ""
    
    var body: some View {
        Spacer()
        Image("Logo")
            .resizable()
            .aspectRatio(contentMode: .fit)
        
        Text("Bem Vindo")
            .fontWeight(.black)
            .foregroundColor(Color(.orange))
            .font(.largeTitle)
            .multilineTextAlignment(.center)
        
        Text("Agora você podera registrar sua refeições")
          .fontWeight(.light)
          .multilineTextAlignment(.center)
          .padding()

        Spacer()
        
        GoogleSignInButton()
           .padding()
           .onTapGesture {
               Task {
                   do {
                       try await Authentication().googleOauth()
                   } catch let e {
                       print(e)
                       err = e.localizedDescription
                   }
               }
           }

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

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
