//
//  TapToStartNode.m
//  BreakUp
//
//  Created by Apple on 4/28/15.
//  Copyright (c) 2015 Randall Lee. All rights reserved.
//

#import "TapToStartNode.h"

@implementation TapToStartNode

+ (instancetype)tapToStartAtPosition:(CGPoint)position
{
    TapToStartNode *tapToStart = [self node];
    
    SKLabelNode *tapToStartLabel = [SKLabelNode labelNodeWithFontNamed:@"Futura-CondensedExtraBold"];
    tapToStartLabel.name = @"TapToStart";
    tapToStartLabel.text = @"Tap to Start";
    tapToStartLabel.fontSize = 48;
    tapToStartLabel.position = position;
    [tapToStart addChild:tapToStartLabel];
    
    return tapToStart;
}



@end
