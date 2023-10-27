import SwiftUI

struct BottomMenuView: View {
    var body: some View {
        TabView{
            Home()
                .tabItem(){
                    Image(systemName: "house")
                    Text("Home")
                }
            AdicionaRefeicaoView()
                .tabItem(){
                    Image(systemName: "plus.circle.fill")
                    Text("Refeição")
                }
            PerfilView()
                .tabItem(){
                    Image(systemName: "person")
                    Text("Perfil")
                }
        }
    }
}

struct BottomMenuView_Previews: PreviewProvider {
    static var previews: some View {
        BottomMenuView()
    }
}
