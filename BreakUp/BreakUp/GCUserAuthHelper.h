//
//  GCUserAuthHelper.h
//  BreakUp
//
//  Created by Apple on 9/1/15.
//  Copyright (c) 2015 Randall Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>

@interface GCUserAuthHelper : NSObject
{
    BOOL gameCenterAvailable;
    BOOL userAuthenticated;
}

@property (assign, readonly) BOOL gameCenterAvailable;

+ (GCUserAuthHelper *)sharedInstance;
- (void)authenticateLocalUser;

@end
