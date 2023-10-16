//
//  ContentView.swift
//  Diario Alimentar
//
//  Created by Karol Gerhard on 12/10/23.
//

import SwiftUI
import Firebase

struct ContentView: View {
    @State private var userLoggedIn = (Auth.auth().currentUser != nil)
    
    var body: some View {
        VStack{
            if userLoggedIn {
                Home()
            }else{
                Login()
            }
        }
        .onAppear{
            Auth.auth().addStateDidChangeListener{ auth, user in
                if(user != nil){
                    userLoggedIn = true
                }else{
                    userLoggedIn = false
                }
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
