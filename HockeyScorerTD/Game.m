//
//  Game.m
//  HockeyScorerTD
//
//  Created by Anne West on 9/2/14.
//  Copyright (c) 2014 TDG. All rights reserved.
//

#import "Game.h"

@implementation Game

#pragma mark - NSCoding protocol methods

//keys in these two methods must match

//needed by HSVC to prepare data for loading in loadGames method
//NSKeyedUnarchiver there defaults to this init method becuase of protocol
- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.opponent = [aDecoder decodeObjectForKey:@"Opponent"];
        self.dateOfGame = [aDecoder decodeObjectForKey:@"DateOfGame"];
        self.shotsOnGoal = [aDecoder decodeIntegerForKey:@"ShotsOnGoal"];
    }
    return self;
}


//needed by HSVC to prepare data for saving in saveGames method
- (void) encodeWithCoder:(NSCoder *)aCoder
{
    //separate encoder for each property
    [aCoder encodeObject:self.opponent forKey:@"Opponent"];
    [aCoder encodeObject:self.dateOfGame forKey:@"DateOfGame"];
    [aCoder encodeInteger:self.shotsOnGoal forKey:@"ShotsOnGoal"];
    
    
}

@end
