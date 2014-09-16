//
//  PlayerResultsViewController.h
//  HockeyScorerTD
//
//  Created by Anne West on 9/11/14.
//  Copyright (c) 2014 TDG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Game.h"

@interface PlayerResultsViewController : UIViewController

@property (nonatomic, strong) Game *gameToEditPerformance;// Will be used in viewDidLoad of the PRVC and loaded in the delegate methods in GLVC

@end
