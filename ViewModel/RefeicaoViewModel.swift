

import Foundation
import FirebaseFirestore
import GoogleSignIn

class RefeicaoViewModel: ObservableObject{
    @Published var refeicoes = [Refeicao]()
    private let userLogado = GIDSignIn.sharedInstance.currentUser

    private var db = Firestore.firestore()
    
    func getAllData() {
           db.collection("refeicoes").addSnapshotListener { (querySnapshot, error) in
               guard let documents = querySnapshot?.documents else {
                   print("No documents")
                   return
               }

               self.refeicoes = documents.map { (queryDocumentSnapshot) -> Refeicao in
                   let data = queryDocumentSnapshot.data()
                   let nomeDaRefeicao = data["nomeDaRefeicao"] as? String ?? ""
                   let alimento = data["alimento"] as? String ?? ""
                   let valorCalorico = data["valorCalorico"] as? String ?? ""
                   let id = queryDocumentSnapshot.documentID
                   return Refeicao(id: id, nomeDaRefeicao: nomeDaRefeicao, alimento: alimento, valorCalorico: valorCalorico)
               }
           }
       }
    
    func addRefeicao(nomeDaRefeicao: String, alimento: String, valorCalorico: String) {
            do {
                _ = try db.collection("refeicoes").addDocument(data: ["nomeDaRefeicao": nomeDaRefeicao, "alimento": alimento, "valorCalorico": valorCalorico])

            }
            catch {
                fatalError("Problema ao adicionar: \(error.localizedDescription).")
            }
        }
    
    func updateRefeicao(refeicao: Refeicao) {
        let refeicaoDoc = db.collection("refeicoes").document(refeicao.id)
        refeicaoDoc.setData(["nomeDaRefeicao": refeicao.nomeDaRefeicao, "alimento": refeicao.alimento, "valorCalorico": refeicao.valorCalorico]){ error in
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


