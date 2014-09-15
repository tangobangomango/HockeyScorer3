//
//  SeasonsViewController.h
//  HockeyScorerTD
//
//  Created by Anne West on 9/13/14.
//  Copyright (c) 2014 TDG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SeasonFactsViewController.h"

@class DataModel;

@interface SeasonsViewController : UITableViewController <SeasonFactsViewControllerDelegate>

//note that isn't an array, but the top level DataModel which defines itself as the array 
@property (nonatomic, strong) DataModel *dataModel;

@end
