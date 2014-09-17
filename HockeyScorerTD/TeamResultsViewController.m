//
//  TeamResultsViewController.m
//  HockeyScorerTD
//
//  Created by Anne West on 9/8/14.
//  Copyright (c) 2014 TDG. All rights reserved.
//

#import "TeamResultsViewController.h"

@interface TeamResultsViewController ()

//label outlets
@property (weak, nonatomic) IBOutlet UILabel *labelTeamGoals;

@property (weak, nonatomic) IBOutlet UILabel *labelOpponentGoals;


//stepper outlets
@property (weak, nonatomic) IBOutlet UIStepper *outletTeamGoalsStepper;

@property (weak, nonatomic) IBOutlet UIStepper *outletOpponentGoalsStepper;


//stepper actions
- (IBAction)stepperTeamGoals:(UIStepper *)sender;

- (IBAction)stepperOpponentGoals:(UIStepper *)sender;




@end

@implementation TeamResultsViewController

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
    [self loadDataInLabelsAndSteppers];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) loadDataInLabelsAndSteppers
{
    self.labelTeamGoals.text = [NSString stringWithFormat:@"%ld", (long) self.gameToEditPerformance.teamGoals];
    self.labelOpponentGoals.text = [NSString stringWithFormat:@"%ld", (long) self.gameToEditPerformance.opponentGoals];
    
    [self.outletTeamGoalsStepper setValue:(double) self.gameToEditPerformance.teamGoals];
    [self.outletOpponentGoalsStepper setValue:self.gameToEditPerformance.opponentGoals];
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



- (IBAction)stepperTeamGoals:(UIStepper *)sender {
    self.gameToEditPerformance.teamGoals = sender.value;
    NSLog(@"%f", sender.value);
    self.labelTeamGoals.text = [NSString stringWithFormat:@"%ld", (long) self.gameToEditPerformance.teamGoals];
}

- (IBAction)stepperOpponentGoals:(UIStepper *)sender {
    self.gameToEditPerformance.opponentGoals = sender.value;
    self.labelOpponentGoals.text = [NSString stringWithFormat:@"%ld", (long) self.gameToEditPerformance.opponentGoals];
}
@end
