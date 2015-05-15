//
//  TapToContinueNode.m
//  BreakUp
//
//  Created by Apple on 5/14/15.
//  Copyright (c) 2015 Randall Lee. All rights reserved.
//

#import "TapToContinueNode.h"

@implementation TapToContinueNode

+ (instancetype)tapToContinueLabelAtPosition:(CGPoint)position
{
    TapToContinueNode *tap = [self node];
    
    SKLabelNode *tapLabel = [SKLabelNode labelNodeWithFontNamed:@"Futura-CondensedExtraBold"];
    tapLabel.name = @"PausedTap";
    tapLabel.text = @"Paused - Tap To Continue";
    tapLabel.color = [SKColor whiteColor];
    tapLabel.fontSize = 48;
    tapLabel.position = position;
    tapLabel.zPosition = 11;
    [tap addChild:tapLabel];
    
    return tap;
}

@end
