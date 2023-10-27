
import Foundation

struct Refeicao: Codable, Identifiable {
    var id: String = UUID().uuidString
    var nomeDaRefeicao: String
    var alimento: String
    var valorCalorico: String
}
