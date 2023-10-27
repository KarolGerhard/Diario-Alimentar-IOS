import SwiftUI
import GoogleSignIn
import CoreData

struct Login: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var err: String = ""
    
    @Environment(\.dismiss) private var dismiss
    
    func saveUser(){
        let user = GIDSignIn.sharedInstance.currentUser
        
        let newUser = Users(context: viewContext)
        newUser.email = user?.profile?.email
        newUser.nome = user?.profile?.name
        
        do {
            try viewContext.save()
            dismiss()
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    
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
                       saveUser()
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
        Login().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
