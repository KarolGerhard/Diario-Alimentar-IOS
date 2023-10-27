//
//  TesteView.swift
//  Diario Alimentar
//
//  Created by Sydy on 18/10/23.
//

import SwiftUI

struct TesteView: View {
    let buttonHeight: CGFloat = 55
    @Binding var isShowing: Bool
    
    var content: AddRefeicaoView
    
    var body: some View {
        ZStack(alignment: .bottom) {
                    if (isShowing) {
                        Color.black
                            .opacity(0.3)
                            .ignoresSafeArea()
                            .onTapGesture {
                                isShowing.toggle()
                            }
                        content
                            .padding(.bottom, 42)
                            .transition(.move(edge: .bottom))
                            .background(
                                Color(uiColor: .white)
                            )
//                            .cornerRadius(16, corners: [.topLeft, .topRight])
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                .ignoresSafeArea()
                .animation(.easeInOut, value: isShowing)
    }}
        
        


//struct TesteView_Previews: PreviewProvider {
//    static var previews: some View {
//        TesteView()
//    }
//}
