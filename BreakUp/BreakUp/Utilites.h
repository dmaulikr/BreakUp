//
//  Utilites.h
//  BreakUp
//
//  Created by Apple on 4/27/15.
//  Copyright (c) 2015 Randall Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

static const int BrickDurationSpeed = 0.001;
static const float BrickDropSpeed = -0.4;
static const int MaxLives = 3;
static const int ApplyFlipperVelocity = 30;

typedef NS_OPTIONS(uint32_t, CollisionCategory)
{
    CollisionCategoryBall               = 0x1 << 0,   // 0000?
    CollisionCategoryDrain              = 0x1 << 1,   // 0010?
    CollisionCategoryBrick              = 0x1 << 2,   // 0100?
    CollisionCategoryFlipperLeft        = 0x1 << 3,   // 1000?
    CollisionCategoryFlipperRight       = 0x1 << 4,
    CollisionCategoryWall               = 0x1 << 5,
    CollisionCategoryFlipperGuard       = 0x1 << 6
};


@interface Utilites : NSObject

+ (NSInteger) randomWithMin:(NSInteger)min max:(NSInteger)max;

@end
