import SwiftUI

struct RefeicaoView: View {
    @ObservedObject private var viewModel = RefeicaoViewModel()
    @State private var isShowingAddRefeicaoView = false
    @State var isShowingBottomSheet = false
    
    var body: some View {
        NavigationView{
            
            Text("").navigationTitle("Suas refeições")
            List(viewModel.refeicoes) { refeicao in
                HStack(spacing: 10) {
                    Text("Refeição: " + refeicao.nomeDaRefeicao + "\n").frame(alignment: .leading)
                    Text("Alimento \n" + refeicao.alimento + "\n").frame(alignment: .center)
                    Text(refeicao.valorCalorico).frame(alignment: .trailing)
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


struct RefeicaoView_Previews: PreviewProvider {
    static var previews: some View {
        RefeicaoView()
    }
}
