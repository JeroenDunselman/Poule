//
//  TeamResult.swift
//  Poule
//
//  Created by Jeroen Dunselman on 02/06/2019.
//  Copyright © 2019 Jeroen Dunselman. All rights reserved.
//

import Foundation
class TeamResult: Comparable {
    var team: Team?
    var points = 0
    var lost = 0
    var won = 0
    var draw = 0
    var goal = 0
    var countergoal = 0
    var scoreInterval = 0 //doelsaldo
    var match: [Match] = []
    var rank = 0
    
    init() {}
    
    static func <(lhs: TeamResult, rhs: TeamResult) -> Bool {
        
        if lhs.points != rhs.points {
            return lhs.points > rhs.points
        } else if lhs.scoreInterval != rhs.scoreInterval {
            return lhs.scoreInterval > rhs.scoreInterval
        } else if lhs.goal != rhs.goal {
            return lhs.goal > rhs.goal
        } else if lhs.countergoal != rhs.countergoal {
            return lhs.countergoal > rhs.countergoal
        } else if let match: Match = lhs.match.first(where: {$0.teamX == rhs.team || $0.teamY == rhs.team}){
            if let winner = match.winner {
                return winner == lhs.team
            } else  {
                //match resulted in draw
                //fully equal teamresults, so toss
                return Bool.random()
            }
        }
        
        return true
        
    }
    
    static func ==(lhs: TeamResult, rhs: TeamResult) -> Bool {
        
        if lhs.points == rhs.points &&
            lhs.scoreInterval == rhs.scoreInterval &&
            lhs.goal == rhs.goal &&
            lhs.countergoal == rhs.countergoal {
            
            if let match: Match = lhs.match.first(where: {$0.teamX == rhs.team || $0.teamY == rhs.team}){
                if let _ = match.winner {
                    return false
                }
            }
            
            return true
        }
        
        return false
    }
    
}
