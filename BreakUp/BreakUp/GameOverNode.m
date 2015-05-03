//
//  GameOverNode.m
//  BreakUp
//
//  Created by Apple on 5/3/15.
//  Copyright (c) 2015 Randall Lee. All rights reserved.
//

#import "GameOverNode.h"

@implementation GameOverNode

+ (instancetype) gameOverAtPosition:(CGPoint)position
{
    GameOverNode *gameOver = [self node];
    
    SKLabelNode *gameOverLabel = [SKLabelNode labelNodeWithFontNamed:@"Futura-CondensedExtraBold"];
    gameOverLabel.name = @"GameOver";
    gameOverLabel.text = @"Game Over";
    gameOverLabel.fontSize = 48;
    gameOverLabel.position = position;
    
    [gameOver addChild:gameOverLabel];
    
    return gameOver;
}

@end
