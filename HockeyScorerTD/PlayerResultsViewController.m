//
//  PlayerResultsViewController.m
//  HockeyScorerTD
//
//  Created by Anne West on 9/11/14.
//  Copyright (c) 2014 TDG. All rights reserved.
//

#import "PlayerResultsViewController.h"

@interface PlayerResultsViewController ()
- (IBAction)goalsStepper:(UIStepper *)sender;

@end

@implementation PlayerResultsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%@",self.gameToEditPerformance.opponent);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)goalsStepper:(UIStepper *)sender {
}
@end
