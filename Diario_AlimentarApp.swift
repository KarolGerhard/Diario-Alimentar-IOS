
import SwiftUI
import Firebase
import FirebaseCore
import GoogleSignIn



private struct SafeAreaInsetsEnvironmentKey: EnvironmentKey {
    static let defaultValue: (top: CGFloat, bottom: CGFloat) = (0, 0)
}

extension EnvironmentValues {
    var safeAreaInsets: (top: CGFloat, bottom: CGFloat) {
        get { self[SafeAreaInsetsEnvironmentKey.self] }
        set { self[SafeAreaInsetsEnvironmentKey.self] = newValue }
    }
}

@main
struct Diario_AlimentarApp: App {
    @State private var safeAreaInsets: (top: CGFloat, bottom: CGFloat) = (0, 0)
    let persistenceController = PersistenceController.shared
    
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                GeometryReader { proxy in
                    Color.clear.onAppear {
                        safeAreaInsets = (proxy.safeAreaInsets.top, proxy.safeAreaInsets.bottom)
                    }
                }
                ContentView()
                    .onOpenURL{ url in GIDSignIn.sharedInstance.handle(url)}
                .environment(\.safeAreaInsets, safeAreaInsets)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
              }
           
        }
    }
}


