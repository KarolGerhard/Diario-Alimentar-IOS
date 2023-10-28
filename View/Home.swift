import SwiftUI
import Firebase
import FirebaseAuth
import GoogleSignIn
  
struct Home: View {
    @State private var err : String = ""
    @State private var showView1 = false
    @State private var showView2 = false
    @ObservedObject private var viewModel = RefeicaoViewModel()
    @State private var isShowingAddRefeicaoView = false
    
    var body: some View {

        NavigationStack(){
            VStack{
                Text("Acompanhe seus registros diarios!").padding()
                
                    .navigationTitle("Home")
            }
            
            Spacer()
            
            List(viewModel.refeicoes) { refeicao in
                VStack(alignment: .leading) {
                    Text(refeicao.nomeDaRefeicao).font(.headline)
                    Text(refeicao.alimento)
                    Text(refeicao.valorCalorico + " kcal")
                }.swipeActions(allowsFullSwipe: false){
                    Button{
                        isShowingAddRefeicaoView = true
                    } label: {
                        Label("Editar", systemImage: "pencil.circle.fill")
                    }
                    .tint(.blue)
                    Button(role: .destructive){
                        viewModel.deleteRefeicao(refeicao: refeicao)
                    }label: {
                        Label("Delete", systemImage: "trash.fill")
                    }
                    
                }
               
                .navigationDestination(isPresented: $isShowingAddRefeicaoView, destination: {
                    AdicionaRefeicaoView(refeicaoId: refeicao.id, nomeDaRefeicao: refeicao.nomeDaRefeicao, alimento: refeicao.alimento, valorCalorico: refeicao.valorCalorico)}
                )
            }.onAppear() {
                self.viewModel.getAllData()
            }
            
        }
    }
    
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
