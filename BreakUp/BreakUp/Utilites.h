//
//  Utilites.h
//  BreakUp
//
//  Created by Apple on 4/27/15.
//  Copyright (c) 2015 Randall Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utilites : NSObject

typedef NS_OPTIONS(uint32_t, CollisionCategory)
{
    CollisionCategoryBall       = 0x1 << 0,   // 0000?
    CollisionCategoryDrain      = 0x1 << 1,   // 0010?
    CollisionCategoryBrick      = 0x1 << 2,   // 0100?
    CollisionCategoryFlipper    = 0x1 << 3,   // 1000?
    CollisionCategoryWall       = 0x1 << 4
};

@end
