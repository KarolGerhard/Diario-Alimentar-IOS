import SwiftUI
import SimpleToast

struct AdicionaRefeicaoView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var viewModel = RefeicaoViewModel()
    @State private var isShowingHomeView = false
    @Environment(\.dismiss) private var dismiss
    @State var showToast: Bool = false

    private let toastOptions = SimpleToastOptions(
        hideAfter: 3,
        modifierType: .fade
    )
    
    @State var refeicaoId: String = ""
    @State var nomeDaRefeicao: String = ""
    @State var alimento: String = ""
    @State var valorCalorico: String = ""
    
    
    var body: some View {
            VStack{
                Text("Informe sua refeição")
                    .fontWeight(.medium)
                    .font(.largeTitle)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.top], 50)
                    .padding()
                
                VStack(alignment: .leading, spacing: 10){
                    TextField("Refeição", text: $nomeDaRefeicao)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                    TextField("Alimento", text: $alimento, axis: .vertical)
                        .lineLimit(3, reservesSpace: true)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                    TextField("Valor calórico", text: $valorCalorico)
                        .keyboardType(.numberPad)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                    
                }
                Spacer()
                VStack{
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                        if (refeicaoId.isEmpty){
                            self.viewModel.addRefeicao(nomeDaRefeicao: nomeDaRefeicao, alimento: alimento, valorCalorico: valorCalorico)
                        }else{
                            let refeicao = Refeicao(id: refeicaoId, nomeDaRefeicao: nomeDaRefeicao, alimento: alimento, valorCalorico: valorCalorico)
                            self.viewModel.updateRefeicao(refeicao: refeicao)
                        }
                        nomeDaRefeicao = ""
                        alimento = ""
                        valorCalorico = ""
                        dismiss()
                        showToast = true
                        
                    }){
                        HStack{
                            Image(systemName: "checkmark").foregroundColor(.white)
                            Text("Salvar")
                                .foregroundColor(.white)
                                .padding()
                        }
                        .frame(maxWidth: .infinity)
                        .background(Color(.systemOrange))
                        .cornerRadius(12)
                        .padding()
                    }
                }
                .simpleToast(isPresented: $showToast, options:toastOptions){
                    Label("Refeição salva com sucesso", systemImage: "info.circle")
                        .padding()
                        .background(Color.green.opacity(0.8))
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                        .padding(.top)
                        
                }
            }
        }
}


struct AdicionaRefeicaoView_Previews: PreviewProvider {
    static var previews: some View {
        AdicionaRefeicaoView()
    }
}
