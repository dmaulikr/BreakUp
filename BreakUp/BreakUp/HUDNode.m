//
//  HUDNode.m
//  BreakUp
//
//  Created by Apple on 5/2/15.
//  Copyright (c) 2015 Randall Lee. All rights reserved.
//

#import "HUDNode.h"

@implementation HUDNode

// Considering not having a HUD and just display score at the end

+ (instancetype)hudAtPosition:(CGPoint)position inFrame:(CGRect)frame
{
    HUDNode *hud = [self node];
    hud.position = position;
    hud.zPosition = 999;
    hud.name = @"HUD";
    
    SKLabelNode *scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Futura-CondensedExtraBold"];
    scoreLabel.name = @"Score";
    scoreLabel.text = @"0";
    scoreLabel.fontSize = 30;
    scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    [hud addChild:scoreLabel];
    
    return hud;
}

- (void)addPoints:(NSInteger)points
{
    self.score += points;
    
    SKLabelNode *scoreLabel = (SKLabelNode *)[self childNodeWithName:@"Score"];
    scoreLabel.text = [NSString stringWithFormat:@"%ld", (long)self.score]; //setting to point
}

@end
