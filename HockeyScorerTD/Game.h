//
//  Game.h
//  HockeyScorerTD
//
//  Created by Anne West on 9/2/14.
//  Copyright (c) 2014 TDG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Game : NSObject <NSCoding>//conforms to this protocol so data can be prepared for read/write to file

@property (nonatomic, strong) NSString *opponent;
@property (nonatomic, strong) NSDate *dateOfGame;

@end
