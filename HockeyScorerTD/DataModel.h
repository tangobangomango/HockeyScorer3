//
//  DataModel.h
//  HockeyScorerTD
//
//  Created by Anne West on 9/15/14.
//  Copyright (c) 2014 TDG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataModel : NSObject

@property (nonatomic, strong) NSMutableArray *seasons;// of Seasons

- (void) saveSeasons;

//for tracking index of selected season
-(NSInteger) indexOfSelectedSeason;
-(void) setIndexOfSelectedSeason: (NSInteger) index;

@end
