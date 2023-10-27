import SwiftUI

struct AdicionaRefeicaoView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var viewModel = RefeicaoViewModel()
    
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
            VStack(spacing: 16){
                Button(action: {
                    if (refeicaoId.isEmpty){
                        self.viewModel.addRefeicao(nomeDaRefeicao: nomeDaRefeicao, alimento: alimento, valorCalorico: valorCalorico)
                    }else{
                        let refeicao = Refeicao(id: refeicaoId, nomeDaRefeicao: nomeDaRefeicao, alimento: alimento, valorCalorico: valorCalorico)
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

struct AdicionaRefeicaoView_Previews: PreviewProvider {
    static var previews: some View {
        AdicionaRefeicaoView()
    }
}
