
import SwiftUI
import Firebase
import FirebaseCore
import GoogleSignIn


@main
struct Diario_AlimentarApp: App {
    init(){
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView().onOpenURL{ url in
                GIDSignIn.sharedInstance.handle(url)
            }
          
        }
    }
}


