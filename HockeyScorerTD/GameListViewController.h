//
//  GameListViewController.h
//  HockeyScorerTD
//
//  Created by Anne West on 9/1/14.
//  Copyright (c) 2014 TDG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameFactsViewController.h"
#import "PlayerActionsViewController.h"

//So can add a property with the season in it so can display the season name in the title
@class Season;


@interface GameListViewController : UITableViewController <GameFactsViewControllerDelegate, PlayerActionsViewControllerDelegate>

@property (nonatomic, strong) Season *season;


@end
