//
//  ContentView.swift
//  TicTacToe
//
//  Created by Matheus Almeida on 08/03/2022.
//

import SwiftUI

struct GameView: View {
    @State var TicTacToeAI: Bool = false
    @State var TicTacToeTwoPlayers: Bool = false
    @Environment(\.presentationMode) var presentationMode


        var body: some View {
                VStack {
                    TabView {
                        AI()
                        TwoPlayers()
                            }
                    .tabViewStyle(PageTabViewStyle())
                }
            }
        }

struct TicTacToe_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
