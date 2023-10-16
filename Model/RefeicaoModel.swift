
import Foundation

struct Refeicao: Codable, Identifiable {
    var id: String = UUID().uuidString
    var nome: String
    var quantidade: String?
}
