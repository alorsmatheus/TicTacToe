//
//  TwoPlayers.swift
//  TicTacToe
//
//  Created by Matheus Almeida on 08/03/2022.
//

import SwiftUI

struct TwoPlayers: View {
    let colums: [GridItem] = [GridItem(.flexible()),
                              GridItem(.flexible()),
                              GridItem(.flexible()),]
    
    @State private var playerMoves: [Moves?] = Array(repeating: nil, count: 9)
    @State private var isHumansTurn = false
    @State private var alertItem: AlertItem?
//        @State private var isAnimated: Bool = false
    
    var body: some View {
            GeometryReader { geometry in
                VStack {
                    HStack {
                        Text("Two Players")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .multilineTextAlignment(.leading)
                            .padding(.top)
                        Spacer()
                    }
                    Spacer()
                    LazyVGrid(columns: colums, spacing: 5) {
                        ForEach(0..<9) { i in
                            ZStack {
                                Circle()
                                    .foregroundColor(.primary.opacity(0))
                                    .frame(width: geometry.size.width/3 - 15,
                                       height: geometry.size.width/3 - 15)
                                
                                Image(systemName: playerMoves[i]?.indicator ?? "")
                                    .resizable()
                                    .padding()
                                    .background(Circle().fill((playerMoves[i] != nil) ? Color.primary.opacity(0) : Color(.secondarySystemBackground)))
                                    .foregroundColor(checkWinConditions(for: .playerTwo, in: playerMoves) ? Color.green : Color(.secondarySystemBackground))
                                    .foregroundColor(checkForDraw(in: playerMoves) ? Color.blue : Color(.secondarySystemBackground))
                                    .frame(width: geometry.size.width/3 - 25, height: geometry.size.width/3 - 25)
                                    .foregroundColor(Color(.secondarySystemBackground))
                                
                            }
                            .onTapGesture {
//                                    withAnimation() {
//                                        isAnimated.toggle()
                                    
                                if isSquareOccupied(in: playerMoves, forIndex: i) { return }
                                
                                playerMoves[i] = Moves(player: !isHumansTurn ? .playerOne : .playerTwo, boardIndex: i)
                                isHumansTurn.toggle()
                                                                        
                                if checkWinConditions(for: .playerOne, in: playerMoves) {
                                    alertItem = AlertContext.humanWin
                                    return
                                }
                                
                                if checkWinConditions(for: .playerTwo, in: playerMoves) {
                                    alertItem = AlertContext.computerWin
                                    return
                                }
                                
                                if checkForDraw(in: playerMoves) {
                                    alertItem = AlertContext.draw
                                    return
                                }
//                                }
                        }
                    }
                }
                Spacer()
            }
            .padding()
            .alert(item: $alertItem, content: { alertItem in
                Alert(title: alertItem.title,
//                            message: alertItem.message,
                        dismissButton: .default(alertItem.buttonTitle, action: { resetGames() }))
            })
        }
    }

func isSquareOccupied(in moves: [Moves?], forIndex index: Int) -> Bool {
    return moves.contains(where: { $0?.boardIndex == index})
}

func checkWinConditions(for player: Players, in moves: [Moves?]) -> Bool {
    let winPatterns: Set<Set<Int>> = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
    
    let playerMoves = moves.compactMap { $0 }.filter { $0.player == player }
    let playerPositions = Set(playerMoves.map {$0.boardIndex })
    
    for pattern in winPatterns where pattern.isSubset(of: playerPositions) { return true }
    
    return false
}

func checkForDraw(in moves: [Moves?]) -> Bool {
    return moves.compactMap { $0 }.count == 9
}

func resetGames () {
    playerMoves = Array(repeating: nil, count: 9)
    }
}

enum Players {
case playerOne, playerTwo
}

struct Moves {
let player: Players
let boardIndex: Int

var indicator: String {
    return player == .playerOne ? "xmark" : "circle"
    }
}

struct TwoPlayers_Previews: PreviewProvider {
    static var previews: some View {
        TwoPlayers()
            .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}
