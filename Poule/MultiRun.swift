//
//  MultiRun.swift
//  Poule
//
//  Created by Jeroen Dunselman on 03/06/2019.
//  Copyright © 2019 Jeroen Dunselman. All rights reserved.
//

import Foundation
class MultiRun {
    let numberOfRuns = 1000
    var pouleResults = ""
    var teamResult = ""
    var power = Power()
    var poules: [Poule] = []
    
    func run() {
        
        poules = []
        _ = (0..<numberOfRuns).map( {i in
            let poule = Poule(goals: 2.6)
            poules.append(poule)
        })
    }
    
    struct runResults {
        
        public var scoreIntervals: [Team: Int] = [Team.A: 0, Team.B: 0, Team.C: 0, Team.D: 0]
        public var avgScoreIntervals: [Team: Int] = [Team.A: 0, Team.B: 0, Team.C: 0, Team.D: 0]
        //not in use
        public var points: [Team: Int] = [Team.A: 0, Team.B: 0, Team.C: 0, Team.D: 0]
        public var avgPoints: [Team: Int] = [Team.A: 0, Team.B: 0, Team.C: 0, Team.D: 0]
    }
    
    func report() {
        var results = runResults()
        var runReport = ""
        
        
        for r: Poule in poules {
            runReport += runReport == "" ? "Results of \(numberOfRuns) poules \n" : "\n"
            
            //occurance of equality of team results?
            var equalTeamResults = false
            
            let rank = r.pouleResult.sorted()
            var rankReport = ""
            for i in (0..<rank.count) {
                rankReport += rankReport == "" ? "\n* Poule ranked: " : "-"
                rankReport += "\(rank[i].team!)"
            }
            runReport += rankReport + "\n"
            
            for j in (0..<r.pouleResult.count) {
                
                //rank in poule result
                let i = rank[j]
                //                i.rank = j
                
                //cumulative score numberOfRuns
                let cumulative = results.scoreIntervals[i.team!]! + i.scoreInterval
                results.scoreIntervals[i.team!] = cumulative
                
                //poule result
                var pouleReport: String = ("Team \(i.team!):\n-points: \(i.points)\n-draw: \(i.draw), lost: \(i.lost), won: \(i.won), ")
                pouleReport += ("\n-goal/countergoal/interval: \(i.goal)/\(i.countergoal)/\(i.scoreInterval) \n")
                //                print("\(report)")
                
                for m in r.matches {
                    if m.teamY == i.team || m.teamX == i.team {
                        pouleReport += m.report()
                    }
                }
                
                if r.equality.count > 0 {
                    equalTeamResults = true
                }
                runReport += pouleReport //+ "\n"
            }
            
            if equalTeamResults {
                for m in r.equality {
                    //                    print("equality: \(m.teamX)-\(m.teamY)")
                    runReport += "equality: \(m.teamX)-\(m.teamY)" //+ "\n"
                }
            }
            
        }
        pouleResults = runReport
        
        //under construction
        //Succes percentage from scoreIntervals
        //process scoreIntervals to account for negatives, add negative values to each
        var factor = 0
        _ = Team.allCases.map({
            if let score = results.scoreIntervals[$0] {
                if score < 0 {factor += abs(score)}
            }
        })
        _ = Team.allCases.map({
            if let score = results.scoreIntervals[$0] {
                results.scoreIntervals[$0] = score + factor
            }
        })
        
        let sum = Team.allCases.reduce(0, {total, team in
            if let a = results.scoreIntervals[team] { return total + a} else { return total}})
        var resultText = "Power/Success percentage from \(numberOfRuns) poules: \n"
        for team in Team.allCases {
            if let a = results.scoreIntervals[team] {
                let percentage = Int((Double(a) * 100.0) / Double(sum) )
                results.avgScoreIntervals[team] = percentage
                //                print("team \(team): \(percentage)")
                var strength: Int = 0
                if let p = power.strength[team] { strength = p}
                resultText += "\(team): \(strength)/\(percentage)" + "\n"
            }
        }
        teamResult = resultText
        
    }
    
}
