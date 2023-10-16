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
    @State var path = NavigationPath()
      
    var body: some View {
        NavigationStack(path: $path){
            VStack{
                Text("Acompanhe seus registros diarios!")
                
                    .navigationTitle("Diario Alimentar")
                    .toolbar{
                        ToolbarItem{
                            Menu {
                                Button{
                                    self.showView1.toggle()
                                }label: {
                                    Label("Adicionar Refeições", systemImage: "plus")
                                }
                                Button{
                                    Task {
                                        do {
                                            try await Authentication().logout()
                                        } catch let e {
                                            err = e.localizedDescription
                                        }
                                    }
                                } label: {
                                    Label("Sair", systemImage: "arrow.right.square")
                                }
                            } label: {
                                Label("Menu", systemImage: "ellipsis.circle")
                            }
                            .navigationDestination(isPresented: $showView1) {
                                AddRefeicaoView()
                            }
                        }
                    }
            }
            
            Spacer()
            
            List(viewModel.refeicoes) { refeicao in
                    HStack(spacing: 10) {
                        Text(refeicao.nome + " - Consumo:" ?? "").frame(alignment: .leading)
                        Text(refeicao.quantidade ?? "").frame(alignment: .trailing)
                    }.swipeActions(allowsFullSwipe: false){
                        Button{
                            isShowingAddRefeicaoView = true
                        } label: {
                            Label("Editar", systemImage: "pencil")
                        }
                        .tint(.blue)
                        Button(role: .destructive){
                            viewModel.deleteRefeicao(refeicao: refeicao)
                        }label: {
                            Label("Delete", systemImage: "trash.fill")
                        }
                        
                    }.navigationDestination(isPresented: $isShowingAddRefeicaoView, destination: {AddRefeicaoView(refeicaoId: refeicao.id, nome: refeicao.nome, quantidade: refeicao.quantidade ?? "")})
                }.onAppear() {
                    self.viewModel.getAllData()
                }
            
        }
    }
    
}




struct AddRefeicaoView: View{
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var viewModel = RefeicaoViewModel()
    
    @State var refeicaoId: String = ""
    @State var nome: String = ""
    @State var quantidade: String = ""
  
    var body: some View {
        VStack{
            Text("Informe sua refeição")
                .fontWeight(.medium)
                .font(.largeTitle)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding([.top], 50)
                .padding()
            
            VStack(alignment: .leading, spacing: 10){
                TextField("Qual refeição", text: $nome)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                TextField("Quantidade ingerida", text: $quantidade)
                    .textFieldStyle(.roundedBorder)
                    .padding()
               
            }
            Spacer()
            VStack(spacing: 16){
                Button(action: {
                    if (refeicaoId.isEmpty){
                        self.viewModel.addRefeicao(nome: nome, quantidade: quantidade)
                    }else{
                        let refeicao = Refeicao(id: refeicaoId, nome: nome, quantidade: quantidade)
                        self.viewModel.updateRefeicao(refeicao: refeicao)
                    }
                    self.presentationMode.wrappedValue.dismiss()
                    
                }){
                    HStack(spacing: 10){
                        Image(systemName: "checkmark")
                        
                        Text("Salvar")
                            .fontWeight(.bold)
                            .font(.title2)
                    }
                }
                .padding()
                .cornerRadius(10)
                .buttonStyle(.borderedProminent)
            
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding([.bottom], 50)
        }
    }
}


struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
