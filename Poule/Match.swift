//
//  Match.swift
//  Poule
//
//  Created by Jeroen Dunselman on 02/06/2019.
//  Copyright © 2019 Jeroen Dunselman. All rights reserved.
//

import Foundation

class Match {
    var teamX: Team
    var teamY: Team
    
    var teamPower = Power()
    var participantsStrengthInterval = 0
    
    var expectedGoals: Double = 0.0
    // expected goals in match are divided between teams as shots
    var shotCountX = 0
    var shotCountY = 0
    // toss for each shot whether to count as a goal
    var goalCountX = 0
    var goalCountY = 0
    
    var winner: Team?
    var scoreInterval = 0
    
    init(teamX: Team, teamY: Team) {
        self.teamX = teamX
        self.teamY = teamY
        if let a = teamPower.strength[teamX], let b = teamPower.strength[teamY] {
            participantsStrengthInterval = abs(a - b)
        }
    }
    
    func play() {
        
        //Toss twice for each expected goal
        let numberOfSidesToACoin = 2
        let tossCount: Double = Double(numberOfSidesToACoin) * expectedGoals
        
        if let a = teamPower.strength[teamX], let b = teamPower.strength[teamY] {
            
            //divide shots between teams according to relative teampower
            shotCountX = Int( tossCount * ( Double(a) /  ( Double(a) + Double(b) )) )
            shotCountY = Int( tossCount * ( Double(b) /  ( Double(a) + Double(b) )) )
            
            //** - not quite sure about this yet:
            //due to rounding, we have 1 shot left to assign, randomly
            if Bool.random() {shotCountX += 1} else {  shotCountY += 1  }
            //** -
            
            //toss for each shot whether to count as goal
            _ = (0..<shotCountX).map({_ in if Bool.random() {  goalCountX += 1 } })
            _ = (0..<shotCountY).map({_ in if Bool.random() {  goalCountY += 1 } })
            
            //determine winner
            if goalCountX > goalCountY {    winner = teamX }
            if goalCountY > goalCountX {    winner = teamY }
            scoreInterval = abs(goalCountX - goalCountY)
        }
    }
    
    func report() -> String {
        //        print("exp: \(expectedGoals), (\(shotCountX), \(shotCountY))")
        var reportString = "\(teamX)-\(teamY): \(goalCountX)-\(goalCountY)"  + "\n"
//        reportString += "exp: \(expectedGoals), (\(shotCountX), \(shotCountY))"   + "\n"
        return reportString
    }
    
}


