//
//  Season.m
//  HockeyScorerTD
//
//  Created by Anne West on 9/13/14.
//  Copyright (c) 2014 TDG. All rights reserved.
//

#import "Season.h"

@implementation Season


//Used if the user adds a new season
- (id) init
{
    self = [super init];
    
    if (self) {
        self.games = [[NSMutableArray alloc] initWithCapacity:30];
    }
    return self;
}

//used if season already exists
- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    if (self) {
        self.seasonName = [aDecoder decodeObjectForKey:@"SeasonName"];
        self.games =[aDecoder decodeObjectForKey:@"Games"];
    }
    return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.seasonName forKey:@"SeasonName"];
    [aCoder encodeObject:self.games forKey:@"Games"];
}

@end
