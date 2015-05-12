//
//  TapLabelNode.m
//  BreakUp
//
//  Created by Apple on 5/12/15.
//  Copyright (c) 2015 Randall Lee. All rights reserved.
//

#import "TapLabelNode.h"

@implementation TapLabelNode

+ (instancetype)tapAtPosition:(CGPoint)position
{
    TapLabelNode *tap = [self node];
    
    SKLabelNode *tapLabel = [SKLabelNode labelNodeWithFontNamed:@"Futura-CondensedExtraBold"];
    tapLabel.name = @"Tap";
    tapLabel.text = @"Tap";
    tapLabel.fontSize = 48;
    tapLabel.position = position;
    [tap addChild:tapLabel];
    
    return tap;
}

@end
