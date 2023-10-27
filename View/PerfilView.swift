import SwiftUI
import GoogleSignIn
import CoreData

struct PerfilView: View {

    private let user = GIDSignIn.sharedInstance.currentUser
    @Environment(\.managedObjectContext) private var viewContext

    @State private var err : String = ""
    @State private var nome: String = ""
    @State private var email: String = ""
        
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.nome),
        SortDescriptor(\.email)
    ])
    
    var users: FetchedResults<Users>
     
    var body: some View {
        NavigationView {
          VStack {
            HStack {
              NetworkImage(url: user?.profile?.imageURL(withDimension: 200))
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100, alignment: .center)
                .cornerRadius(8)
              
              VStack(alignment: .leading) {
                  ForEach(users){
                      user in
                      Text(user.nome ?? "Nome")
                          .font(.headline)
                      Text(user.email ?? "Email")
                          .font(.subheadline)
                  }
              }
              
              Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(12)
            .padding()
            
            Spacer()
            
            
            Button(action: {
                Task {
                    do {
                        try await Authentication().logout()
                        deleteUser()
                    } catch let e {
                        err = e.localizedDescription
                    }
                }
            }) {
                HStack(){
                    Image(systemName: "arrow.right.square").foregroundColor(.white)
                    
                    Text("Sair")
                      .foregroundColor(.white)
                      .padding()
                      
            
                }
                .frame(maxWidth: .infinity)
                .background(Color(.systemOrange))
                .cornerRadius(12)
                .padding()
                
              
            }
          }
          .navigationTitle("Seus dados")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func deleteUser(){

        let user = users
        
        for user in users {
            viewContext.delete(user)
        }

        do{
            try viewContext.save()
        }catch{
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
struct NetworkImage: View {
  let url: URL?

  var body: some View {
    if let url = url,
       let data = try? Data(contentsOf: url),
       let uiImage = UIImage(data: data) {
      Image(uiImage: uiImage)
        .resizable()
        .aspectRatio(contentMode: .fit)
    } else {
      Image(systemName: "person.circle.fill")
        .resizable()
        .aspectRatio(contentMode: .fit)
    }
  }
}

struct PerfilView_Previews: PreviewProvider {
    static var previews: some View {
        PerfilView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
