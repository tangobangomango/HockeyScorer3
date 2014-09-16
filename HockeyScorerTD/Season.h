//
//  Season.h
//  HockeyScorerTD
//
//  Created by Anne West on 9/13/14.
//  Copyright (c) 2014 TDG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Season : NSObject <NSCoding>

@property (nonatomic, copy) NSString *seasonName;
@property (nonatomic, copy) NSString *seasonDescription;

@property (nonatomic, strong) NSMutableArray *games; //of Games object

//- (void) sortGames;


@end
