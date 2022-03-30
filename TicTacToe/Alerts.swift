//
//  Alerts.swift
//  TicTacToe
//
//  Created by Matheus Almeida on 08/03/2022.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    var title: Text
//    var message: Text
    var buttonTitle: Text
}

struct AlertContext {
    static let humanWin = AlertItem(title: Text("You Win!"),
                             buttonTitle: Text("Congratulations"))
    
    static let computerWin = AlertItem(title: Text("You Lost"),
                             buttonTitle: Text("Try again"))
    
    static let draw = AlertItem(title: Text("Draw"),
                             buttonTitle: Text("Rematch"))
}
