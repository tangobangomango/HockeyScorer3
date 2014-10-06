//
//  TeamResultsViewController.h
//  HockeyScorerTD
//
//  Created by Anne West on 9/8/14.
//  Copyright (c) 2014 TDG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Game.h"

@interface TeamResultsViewController : UIViewController <UITextViewDelegate>

@property (nonatomic, strong) Game *gameToEditPerformance;// Will be used in viewDidLoad of the TRVC and loaded in the delegate methods in GLVC


@end
