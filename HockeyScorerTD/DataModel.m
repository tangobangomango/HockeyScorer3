//
//  DataModel.m
//  HockeyScorerTD
//
//  Created by Anne West on 9/15/14.
//  Copyright (c) 2014 TDG. All rights reserved.
//

#import "DataModel.h"

//so can deal with first time user
#import "Season.h"

@implementation DataModel

#pragma mark - file operations

//Generic method to get location of apps documents directory
- (NSString *) documentsDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths firstObject];
    return documentsDirectory;
}

//set name of data file and construct full path
- (NSString *) dataFilePath
{
    //NSLog(@"%@", [[self documentsDirectory] stringByAppendingPathComponent:@"HockeyScorer.plist"]);
    return [[self documentsDirectory] stringByAppendingPathComponent:@"HockeyScorer.plist"];
}

//Must remember to adopt NSCoding in Season class and implement all keys for decoding and encodong

- (void) loadSeasons
{
    NSString *path = [self dataFilePath];//for convenience below
    
    //if there is already a data file, unarchive/decode and load seasons array
    //else create an empty array to hold seasons
    if ([[NSFileManager defaultManager] fileExistsAtPath: path]) {
        
        NSData *data = [[NSData alloc] initWithContentsOfFile: path];//data structure created and loaded with file data
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData: data];//archiver created and connected to data
        
        self.seasons = [unarchiver decodeObjectForKey:@"Seasons"];
        NSLog(@"Reading");
        
        
        [unarchiver finishDecoding];//data now in seasons array
        
    } else {
        NSLog(@"Creating");
        self.seasons = [[NSMutableArray alloc] initWithCapacity:5];
    }
}

- (void) saveSeasons
{
    NSMutableData *data = [[NSMutableData alloc] init];//data structure to hold the data to be saved after encoding
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    
    [archiver encodeObject:self.seasons forKey:@"Seasons"];//I believe key here needs to match class name that will be saved. It tells archiver how to encode object properly
    
    [archiver finishEncoding];//finish encoding, with data now in data structure
    NSLog(@"Writing");
    [data writeToFile:[self dataFilePath] atomically:YES];//write data structure to file determined above
    
}

//prepare user defaults method
- (void) registerDefaults
{
    NSDictionary *dictionary = @{@"SeasonIndex" : @-1,
                                 @"FirstTime" : @YES};
    
    [[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];
}

- (id) init
{
    self = [super init];
    
    if (self) {
        [self loadSeasons];
        [self registerDefaults];
        [self handleFirstTime];
    }
    return self;
}

- (NSInteger) indexOfSelectedSeason
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"SeasonIndex"];
}

- (void) setIndexOfSelectedSeason:(NSInteger)index
{
    [[NSUserDefaults standardUserDefaults] setInteger:index forKey:@"SeasonIndex"];
}

- (void) handleFirstTime
{
    BOOL firstTime = [[NSUserDefaults standardUserDefaults] boolForKey:@"FirstTime"];
    
    //Default is Yes, so if is first time, create a season and go to it
    
    if (firstTime) {
        Season *season = [[Season alloc] init];
        season.seasonName = @"Season";
        
        [self.seasons addObject:season];
        [self setIndexOfSelectedSeason:0];
        
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"FirstTime"];
    }
    
    
}



@end
