

import Foundation
import FirebaseFirestore

class RefeicaoViewModel: ObservableObject{
    @Published var refeicoes = [Refeicao]()

    private var db = Firestore.firestore()
    
    func getAllData() {
           db.collection("refeicoes").addSnapshotListener { (querySnapshot, error) in
               guard let documents = querySnapshot?.documents else {
                   print("No documents")
                   return
               }

               self.refeicoes = documents.map { (queryDocumentSnapshot) -> Refeicao in
                   let data = queryDocumentSnapshot.data()
                   let nome = data["nome"] as? String ?? ""
                   let quantidade = data["quantidade"] as? String ?? ""
                   let id = queryDocumentSnapshot.documentID
                   return Refeicao(id: id, nome: nome, quantidade: quantidade)
               }
           }
       }
    
    func addRefeicao(nome: String, quantidade: String) {
            do {
                _ = try db.collection("refeicoes").addDocument(data: ["nome": nome, "quantidade": quantidade])

            }
            catch {
                fatalError("Unable to add card: \(error.localizedDescription).")
            }
        }
    
    func updateRefeicao(refeicao: Refeicao) {
        let refeicaoDoc = db.collection("refeicoes").document(refeicao.id)
        refeicaoDoc.setData(["nome": refeicao.nome, "quantidade": refeicao.quantidade!]){ error in
              if let error = error {
                  print("Error updating document: \(error)")
              } else {
                  print("Document successfully updated!")
              }
          }

    }

    
    func deleteRefeicao(refeicao: Refeicao){
        db.collection("refeicoes").document(refeicao.id).delete(){ err in
            if let err = err {
                   print("Error updating document: \(err)")
               } else {
                   print("Document successfully updated")
               }
            
        }
    }
    
}


