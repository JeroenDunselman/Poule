
//
//  Poule.swift
//  Poule
//
//  Created by Jeroen Dunselman on 29/05/2019.
//  Copyright © 2019 Jeroen Dunselman. All rights reserved.
//

import Foundation
enum Team : CaseIterable {case A, B, C, D }

class Poule {
    
    var matches: [Match] = []
    var probableNumberOfGoals = 2.5
    var averageStrengthInterval: Double = 0.0
    
    var pouleResult: [TeamResult] = []
    var equality:[Match] = []
    
    init(goals: Double?) {
        
        if let goals = goals { probableNumberOfGoals = goals }
        
        defineMatchesFromParticipants()
        playMatches()
        getTeamResults()
    }
    
    func getTeamResults() {
        
        //get results for each team
        for team in Team.allCases {
            let result = TeamResult()
            
            for match in matches {
                //participant of match?
                guard (team == match.teamX || team == match.teamY) else { continue }
                
                result.team = team
                result.match.append(match)
                
                //win/loose/draw; scoreInterval 'doelsaldo'
                if let w = match.winner {
                    if w == team {
                        result.won += 1
//                        result.scoreInterval += match.scoreInterval
                    } else {
                        result.lost += 1
//                        result.scoreInterval -= match.scoreInterval
                    }
                } else { result.draw += 1 }
                
                //goal count
                result.goal += match.teamX == team ? match.goalCountX : match.goalCountY
                result.countergoal += match.teamX == team ? match.goalCountY : match.goalCountX
                
            }
            
            //points: 3 for a win, plus 1 for a draw
            result.points = (result.won * 3) + result.draw
            result.scoreInterval = result.goal - result.countergoal
            pouleResult.append(result)
            
        }
        
        //Do any team results compare fully equal?
        for match in matches {
            if let x: TeamResult = pouleResult.first(where: {$0.team == match.teamX}),
                let y: TeamResult = pouleResult.first(where: {$0.team == match.teamY}) {
                if x == y { equality.append(match) }
            }
        }
    }
    
    func playMatches() {
        
        for match in matches {
            
            // Determine expected number of goals in match
            if averageStrengthInterval != 0 {
                // According to match's strengthInterval deviation from average of Poule
                let ratio = Double(match.participantsStrengthInterval) / averageStrengthInterval
                match.expectedGoals = probableNumberOfGoals * ratio
            } else {
                // all teams could be equal strength
                match.expectedGoals = probableNumberOfGoals
            }
            
            match.play()
        }
    }
    
    func defineMatchesFromParticipants() {
        matches.append(Match(teamX: Team.A, teamY: Team.B))
        matches.append(Match(teamX: Team.C, teamY: Team.D))
        
        matches.append(Match(teamX: Team.A, teamY: Team.D))
        matches.append(Match(teamX: Team.C, teamY: Team.B))
        
        matches.append(Match(teamX: Team.A, teamY: Team.C))
        matches.append(Match(teamX: Team.B, teamY: Team.D))
        
        //Determine average strengthInterval of Poule.matches
        let summedTotalOfStrengthIntervals = matches.reduce(0, {total, match in return total + match.participantsStrengthInterval})
        averageStrengthInterval = Double(summedTotalOfStrengthIntervals / matches.count)
    }
}


