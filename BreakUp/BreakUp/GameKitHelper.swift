//
//  GameKitHelper.swift
//  BreakUp
//
//  via Ray Wenderlich PDF tutorial
//
//  Created by Apple on 9/10/15.
//  Copyright (c) 2015 Randall Lee. All rights reserved.
//

import GameKit
import Foundation

let PresentAuthenticationViewController = "PresentAuthenticationViewController"
let singleton = GameKitHelper()

protocol GameKitHelperDelegate {
    func matchStarted()
    func matchEnded()
    func matchReceivedData(match: GKMatch, data: NSData, fromPlayer player: String)
}

class GameKitHelper: NSObject, GKGameCenterControllerDelegate, GKMatchmakerViewControllerDelegate, GKMatchDelegate {
    var authenticationViewController: UIViewController?
    var lastError: NSError?
    var gameCenterEnabled: Bool
    
    var delegate: GameKitHelperDelegate?
    var multiplayerMatch: GKMatch?
    var presentingViewController: UIViewController?
    var multiplayerMatchStarted: Bool
    
    lazy var playerDetails: Dictionary<String, GKPlayer> = {
        return Dictionary<String, GKPlayer>()
        }()
    
    class var sharedInstance: GameKitHelper {
        return singleton
    }
    
    override init() {
        gameCenterEnabled = true
        multiplayerMatchStarted = false
        super.init()
    }
    
    func authenticateLocalPlayer () {
        
        //1
        let localPlayer = GKLocalPlayer.localPlayer()
        localPlayer.authenticateHandler = {(viewController, error) in
            
            //2
            self.lastError = error
            
            if viewController != nil {
                //3
                self.authenticationViewController = viewController
                
                NSNotificationCenter.defaultCenter().postNotificationName(PresentAuthenticationViewController,
                    object: self)
            } else if localPlayer.authenticated {
                //4
                self.gameCenterEnabled = true
            } else {
                //5
                self.gameCenterEnabled = false
            }
        }
    }
    
    func showGKGameCenterViewController(viewController: UIViewController!) {
        
        if !gameCenterEnabled {
            println("Local player is not authenticated")
            return
        }
        
        //1
        let gameCenterViewController = GKGameCenterViewController()
        
        //2
        gameCenterViewController.gameCenterDelegate = self
        
        //3
        gameCenterViewController.viewState = .Leaderboards
        
        //4
        viewController.presentViewController(gameCenterViewController,
            animated: true, completion: nil)
    }
    
    func reportAchievements(achievements: [GKAchievement]) {
        if !gameCenterEnabled {
            println("Local player is not authenticated")
            return
        }
        GKAchievement.reportAchievements(achievements) {(error) in
            self.lastError = error
        }
    }
    
    func reportScore(score: Int64, forLeaderBoardId leaderBoardId: String) {
        
        if !gameCenterEnabled {
            println("Local player is not authenticated")
            return
        }
        
        //1
        let scoreReporter =
        GKScore(leaderboardIdentifier: leaderBoardId)
        scoreReporter.value = score
        scoreReporter.context = 0
        
        let scores = [scoreReporter]
        
        //2
        GKScore.reportScores(scores) {(error) in
            self.lastError = error
        }
    }
    
    func findMatch(minPlayers: Int, maxPlayers: Int, presentingViewController viewController: UIViewController, delegate: GameKitHelperDelegate) {
        //1
        if !gameCenterEnabled {
            println("Local player is not authenticated")
            return
        }
        
        //2
        multiplayerMatchStarted = false
        multiplayerMatch = nil
        self.delegate = delegate
        presentingViewController = viewController
        
        //3
        let matchRequest = GKMatchRequest()
        matchRequest.minPlayers = minPlayers
        matchRequest.maxPlayers = maxPlayers
        
        //4
        let matchMakerViewController = GKMatchmakerViewController(matchRequest: matchRequest)
        matchMakerViewController.matchmakerDelegate = self
        presentingViewController?.presentViewController(matchMakerViewController, animated: false, completion:nil)
    }
    
    func lookupPlayersOfMatch(match: GKMatch!) {
        println("Looking up \(match.players.count) players")
        
        GKPlayer.loadPlayersForIdentifiers(match.players) {(players, error) in
            if error != nil {
                println("Error: \(error.localizedDescription)")
                self.multiplayerMatchStarted = false
                self.delegate?.matchEnded()
            } else {
                for player in players as! [GKPlayer] {
                    println("Found player: \(player.alias)")
                    self.playerDetails[player.playerID] = player
                }
                self.playerDetails[GKLocalPlayer.localPlayer().playerID] = GKLocalPlayer.localPlayer()
                self.multiplayerMatchStarted = true
                self.delegate?.matchStarted()
            }
        }
    }
    
    // MARK: GKGameCenterControllerDelegate methods
    func gameCenterViewControllerDidFinish(gameCenterViewController: GKGameCenterViewController!) {
        
        gameCenterViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: GKMatchmakerViewControllerDelegate methods
    func matchmakerViewControllerWasCancelled(viewController: GKMatchmakerViewController!) {
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
        delegate?.matchEnded()
    }
    
    func matchmakerViewController(viewController: GKMatchmakerViewController!, didFailWithError error: NSError!) {
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
        println("Error creating a match: \(error.localizedDescription)")
        delegate?.matchEnded()
    }
    
    func matchmakerViewController(viewController: GKMatchmakerViewController!, didFindMatch match: GKMatch!) {
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
        multiplayerMatch = match
        multiplayerMatch!.delegate = self
        
        if !multiplayerMatchStarted && multiplayerMatch?.expectedPlayerCount == 0 {
            println("Ready to start the match")
            lookupPlayersOfMatch(multiplayerMatch)
        }
    }
    
    // MARK: GKMatchDelegate methods
    func match(match: GKMatch!, didReceiveData data: NSData!, fromPlayer playerID: String!) {
        if multiplayerMatch != match {
            return
        }
        delegate?.matchReceivedData(match, data: data, fromPlayer: playerID)
    }
    
    func match(match: GKMatch!, didFailWithError error: NSError!) {
        if multiplayerMatch != match {
            return
        }
        multiplayerMatchStarted = false
        delegate?.matchEnded()
    }
    
    func match(match: GKMatch!, player playerID: String!, didChangeState state: GKPlayerConnectionState) {
        if multiplayerMatch != match {
            return
        }
        switch state {
        case .StateConnected:
            println("Player connected")
            if !multiplayerMatchStarted && multiplayerMatch?.expectedPlayerCount == 0 {
                println("Ready to start the match")
                lookupPlayersOfMatch(multiplayerMatch)
            }
        case .StateDisconnected:
            println("Player disconnected")
            multiplayerMatchStarted = false
            delegate?.matchEnded()
        case .StateUnknown:
            println("Initial player state")
        }
    }
}