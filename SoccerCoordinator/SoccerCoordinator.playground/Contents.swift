// Soccer Coordinator

import Foundation

// Dictionary for each individual player
let joeSmith: [String : Any] = ["name": "Joe Smith", "height": 42, "isExperienced": true, "guardians": "Jim and Jan Smith"]

let jillTanner: [String : Any] = ["name": "Jill Tanner", "height": 36, "isExperienced": true, "guardians": "Clara Tanner"]

let billBon: [String : Any] = ["name": "Bill Bon", "height": 43, "isExperienced": true, "guardians": "Sara and Jenny Bon"]

let evaGordon: [String : Any] = ["name": "Eva Gordon", "height": 45, "isExperienced": false, "guardians": "Wendy and Mike Gordon"]

let mattGill: [String : Any] = ["name": "Matt Gill", "height": 40, "isExperienced": false, "guardians": "Charles and Sylvia Gill"]

let kimmyStein: [String : Any] = ["name": "Kimmy Stein", "height": 41, "isExperienced": false, "guardians": "Bill and Hillary Stein"]

let sammyAdams: [String : Any] = ["name": "Sammy Adams", "height": 45, "isExperienced": false, "guardians": "Jeff Adams"]

let karlSaygan: [String : Any] = ["name": "Karl Saygan", "height": 42, "isExperienced": true, "guardians": "Heather Bledsoe"]

let suzaneGreenberg: [String : Any] = ["name": "Suzane Greenberg", "height": 44, "isExperienced": true, "guardians": "Henrietta Dumas"]

let salDali: [String : Any] = ["name": "Sal Dali", "height": 41, "isExperienced": false, "guardians": "Gala Dali"]

let joeKavalier: [String : Any] = ["name": "Joe Kavalier", "height": 39, "isExperienced": false, "guardians": "Sam and Elaine Kavalier"]

let benFinkelstein: [String : Any] = ["name": "Ben Finkelstein", "height": 44, "isExperienced": false, "guardians": "Aaron and Jill Finkelstein"]

let diegoSoto: [String : Any] = ["name": "Diego Soto", "height": 41, "isExperienced": true, "guardians": "Robin and Sarika Soto"]

let chloeAlaska: [String : Any] = ["name": "Chloe Alaska", "height": 47, "isExperienced": false, "guardians": "David and Jamie Alaska"]

let arnoldWillis: [String : Any] = ["name": "Arnold Willis", "height": 43, "isExperienced": false, "guardians": "Claire Willis"]

let phillipHelm: [String : Any] = ["name": "Phillip Helm", "height": 44, "isExperienced": true, "guardians": "Thomas and Eva Jones"]

let lesClay: [String : Any] = ["name": "Les Clay", "height": 42, "isExperienced": true, "guardians": "Wynonna Brown"]

let herschelKrustofski: [String : Any] = ["name": "Herschel Krustofski", "height": 45, "isExperienced": true, "guardians": "Hyman and Rachel Krustofski"]

// string constants for each team's practice date/time
let dragonPracticeDate = "March 17th at 1pm"
let sharkPracticeDate = "March 17th at 3pm"
let raptorPracticeDate = "March 18th at 1pm"

// Array for all available players
let allPlayers = [
  joeSmith, jillTanner, billBon, evaGordon, mattGill, kimmyStein,
  sammyAdams, karlSaygan, suzaneGreenberg, salDali, joeKavalier, benFinkelstein,
  diegoSoto, chloeAlaska, arnoldWillis, phillipHelm, lesClay, herschelKrustofski
]

// collections for players/teams
var experiencedPlayers: [[String: Any]] = []
var inexperiencedPlayers: [[String: Any]] = []
var dragons: [[String: Any]] = []
var sharks: [[String: Any]] = []
var raptors: [[String: Any]] = []
// each of the above team dictionaries when populated goes to the value for the appropriate name key in the below teams dictionary,
// I did this way because I used the key (name of the team) when creating the letters for the players. Each team still has it's own dictionary in the
// teams variable
var teams = ["dragons": dragons, "sharks": sharks, "raptors": raptors]


// return true if player is experienced
func isExperienced(player: [String: Any]) -> Bool {
  return player["isExperienced"] as! Bool
}

// returns shortest out of two players (used to sort players by height when assigning to teams
func isShortest(player1: [String:Any], player2: [String:Any]) -> Bool {
  return (player1["height"] as! Int) < (player2["height"] as! Int)
}

// Sorts players into experienced and inexperienced players
func sortPlayersByExperience() {
  for player in allPlayers {
    isExperienced(player: player) ? experiencedPlayers.append(player) : inexperiencedPlayers.append(player)
  }
}

// Build letter for an individual player
func letterFor(player: [String: Any], on team: String) -> String {
  var practiceDate = ""
  let playerName = player["name"] as! String
  let guardians = player["guardians"] as! String
  switch team.lowercased() {
    case "sharks": practiceDate = sharkPracticeDate
    case "dragons": practiceDate = dragonPracticeDate
    case "raptors": practiceDate = raptorPracticeDate
    default: "to be announced"
  }
  return "Dear \(guardians),\nWe are happy to inform you that your child \(playerName) has been selected to play for the \(team.capitalized).\nPractices are scheduled to start \(practiceDate). We look forward to seeing you then!\nRegards,\nThe \(team.capitalized)\n"
}

// print letters for a given team
func printLettersFor(team: [[String:Any]], teamName name: String) {
  for player in team {
    print(letterFor(player: player, on: name))
  }
}

sortPlayersByExperience()

// calculate number of experienced players/team based on number of teams
let experiencedPlayersPerTeam = experiencedPlayers.count / teams.count

func assignExperiencedPlayers() {
  // assign experienced shorter players first
  experiencedPlayers.sort(by: isShortest)
  while experiencedPlayers.count > 0 {
    for (key, _) in teams {
      if (teams[key]?.count)! < experiencedPlayersPerTeam {
        teams[key]?.append(experiencedPlayers.removeFirst())
      }
    }
  }
}

// put inexperienced taller players first
func assignInExperiencedPlayers() {
  inexperiencedPlayers.sort(by: isShortest)
  inexperiencedPlayers.reverse()
  while inexperiencedPlayers.count > 0 {
    for (key, _) in teams {
      teams[key]?.append(inexperiencedPlayers.removeFirst())
    }
  }
}

// assign both experienced and inexperienced players to teams
func assignTeams() {
  assignExperiencedPlayers()
  assignInExperiencedPlayers()
}

assignTeams()

// calculates average height for a team
func averageHeight(forTeam team: [[String:Any]]) -> Double {
  var totalHeightInInches:Double = 0
  for player in team {
    totalHeightInInches += Double(player["height"] as! Int)
  }
  return Double(totalHeightInInches / Double(team.count))
}

// check to make sure heights for each team within 1.5 inches
print("Average Height for Sharks: \(averageHeight(forTeam: teams["sharks"]!)) inches")
print("Average Height for Dragons: \(averageHeight(forTeam: teams["dragons"]!)) inches")
print("Average Height for Raptors: \(averageHeight(forTeam: teams["raptors"]!)) inches")
print("Average Height for allPlayers: \(averageHeight(forTeam: allPlayers)) inches\n")

// print letters for all players in each team
for (name, team) in teams {
  printLettersFor(team: team, teamName: name)
}
