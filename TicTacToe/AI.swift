//
//  AI.swift
//  TicTacToe
//
//  Created by Matheus Almeida on 08/03/2022.
//

import SwiftUI

struct AI: View {
    
    @StateObject private var viewModel = GameViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack{
                    Text("AI")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .multilineTextAlignment(.leading)
                        .padding(.top)
                    Spacer()
                }
                    
                Spacer()
                LazyVGrid(columns: viewModel.colums, spacing: 5) {
                    ForEach(0..<9) { i in
                        ZStack {
                            GameSquareView(proxy: geometry)
                                
                            Image(systemName: viewModel.moves[i]?.indicator ?? "")
                                .resizable()
                                .padding()
                                .background(Circle().fill((viewModel.moves[i] != nil) ? Color.primary.opacity(0) : Color(.secondarySystemBackground)))
                                .frame(width: geometry.size.width/3 - 25, height: geometry.size.width/3 - 25)
                                .foregroundColor(Color(.secondarySystemBackground))
                        }
                        .onTapGesture {
                            viewModel.processPlayerMove(for: i)
                        }
                    }
                }
                Spacer()
            }
            .disabled(viewModel.isGameboardDisabled)
            .padding()
            .alert(item: $viewModel.alertItem, content: { alertItem in
                Alert(title: alertItem.title,
//                         message: alertItem.message,
                        dismissButton: .default(alertItem.buttonTitle, action: { viewModel.resetGame() }))
            })
        }
    }
}

enum Player {
    case human, computer
}

struct Move {
    let player: Player
    let boardIndex: Int
    
    var indicator: String {
        return player == .human ? "xmark" : "circle"
    }
}

struct AI_Previews: PreviewProvider {
    static var previews: some View {
        AI()
            
    }
}

struct GameSquareView: View {
    
    var proxy: GeometryProxy
    
    var body: some View {
        Circle()
            .foregroundColor(.primary.opacity(0))
            .frame(width: proxy.size.width/3 - 30,
                   height: proxy.size.width/3)
    }
}
