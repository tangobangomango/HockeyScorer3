//
//  PlayerResultsViewController.m
//  HockeyScorerTD
//
//  Created by Anne West on 9/11/14.
//  Copyright (c) 2014 TDG. All rights reserved.
//

#import "PlayerResultsViewController.h"

@interface PlayerResultsViewController ()

//label outlets
@property (weak, nonatomic) IBOutlet UILabel *labelGoals;
@property (weak, nonatomic) IBOutlet UILabel *labelAssists;
@property (weak, nonatomic) IBOutlet UILabel *labelPlus;
@property (weak, nonatomic) IBOutlet UILabel *labelMinus;
@property (weak, nonatomic) IBOutlet UILabel *labelPenaltyMinutes;
@property (weak, nonatomic) IBOutlet UILabel *labelPenaltiesDrawn;
@property (weak, nonatomic) IBOutlet UILabel *labelPPShifts;
@property (weak, nonatomic) IBOutlet UILabel *labelPKShifts;

//stepper outlets
@property (weak, nonatomic) IBOutlet UIStepper *outletGoalsStepper;
@property (weak, nonatomic) IBOutlet UIStepper *outletAssistsStepper;
@property (weak, nonatomic) IBOutlet UIStepper *outletPlusStepper;
@property (weak, nonatomic) IBOutlet UIStepper *outletMinusStepper;
@property (weak, nonatomic) IBOutlet UIStepper *outletPenaltyMinutesStepper;
@property (weak, nonatomic) IBOutlet UIStepper *outletPenaltiesDrawnStepper;
@property (weak, nonatomic) IBOutlet UIStepper *outletPPShifts;
@property (weak, nonatomic) IBOutlet UIStepper *outletPKShifts;

//stepper actions
- (IBAction)stepperGoals:(UIStepper *)sender;
- (IBAction)stepperAssists:(UIStepper *)sender;
- (IBAction)stepperPlus:(UIStepper *)sender;
- (IBAction)stepperMinus:(UIStepper *)sender;
- (IBAction)stepperPenaltyMinutes:(UIStepper *)sender;
- (IBAction)stepperPenaltiesDrawn:(UIStepper *)sender;
- (IBAction)stepperPPShifts:(UIStepper *)sender;
- (IBAction)stepperPKShifts:(UIStepper *)sender;


//segmented control
@property (weak, nonatomic) IBOutlet UISegmentedControl *outletPositionSegCont;
- (IBAction)segcontPosition:(UISegmentedControl *)sender;
@property (weak, nonatomic) IBOutlet UILabel *labelEnabled;


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
    [self loadDataInControls];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) loadDataInControls
{
    //set labels
    self.labelGoals.text = [NSString stringWithFormat:@"%ld", (long) self.gameToEditPerformance.goals];
    self.labelAssists.text = [NSString stringWithFormat:@"%ld", (long) self.gameToEditPerformance.assists];
    self.labelPlus.text = [NSString stringWithFormat:@"%ld", (long) self.gameToEditPerformance.plus];
    self.labelMinus.text = [NSString stringWithFormat:@"%ld", (long) self.gameToEditPerformance.minus];
    self.labelPenaltyMinutes.text = [NSString stringWithFormat:@"%ld", (long) self.gameToEditPerformance.penaltyMinutes];
    self.labelPenaltiesDrawn.text = [NSString stringWithFormat:@"%ld", (long) self.gameToEditPerformance.penaltiesDrawn];
    self.labelPPShifts.text = [NSString stringWithFormat:@"%ld", (long) self.gameToEditPerformance.shiftsPP];
    self.labelPKShifts.text = [NSString stringWithFormat:@"%ld", (long) self.gameToEditPerformance.shiftsPK];
    
    //set steppers
    [self.outletGoalsStepper setValue:(double) self.gameToEditPerformance.goals];
    [self.outletAssistsStepper setValue:self.gameToEditPerformance.assists];
    [self.outletPlusStepper setValue:(double) self.gameToEditPerformance.plus];
    [self.outletMinusStepper setValue:self.gameToEditPerformance.minus];
    [self.outletPenaltyMinutesStepper setValue:(double) self.gameToEditPerformance.penaltyMinutes];
    [self.outletPenaltiesDrawnStepper setValue:self.gameToEditPerformance.penaltiesDrawn];
    [self.outletPPShifts setValue:(double) self.gameToEditPerformance.shiftsPP];
    [self.outletPKShifts setValue:self.gameToEditPerformance.shiftsPK];
  
    //set segmented control
    if ([self.gameToEditPerformance.position isEqualToString:@"W"]) {
        self.outletPositionSegCont.selectedSegmentIndex = 0;
    } else if ([self.gameToEditPerformance.position isEqualToString:@"C"]) {
        self.outletPositionSegCont.selectedSegmentIndex = 1;
    } else if ([self.gameToEditPerformance.position isEqualToString:@"D"]){
        self.outletPositionSegCont.selectedSegmentIndex = 2;
    } else {
        self.outletPositionSegCont.selectedSegmentIndex = 0; //if nil set to W
    }
    
    if (self.gameToEditPerformance.editingEnabled == YES) {
        self.labelEnabled.text = @"Enabled";
    } else {
        self.labelEnabled.text = @"Disabled";
    }
    
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



- (IBAction)stepperGoals:(UIStepper *)sender {
    self.gameToEditPerformance.goals = sender.value;
    self.labelGoals.text = [NSString stringWithFormat:@"%ld", (long) self.gameToEditPerformance.goals];
}

- (IBAction)stepperAssists:(UIStepper *)sender {
    self.gameToEditPerformance.assists = sender.value;
    self.labelAssists.text = [NSString stringWithFormat:@"%ld", (long) self.gameToEditPerformance.assists];
}

- (IBAction)stepperPlus:(UIStepper *)sender {
    self.gameToEditPerformance.plus = sender.value;
    self.labelPlus.text = [NSString stringWithFormat:@"%ld", (long) self.gameToEditPerformance.plus];
}

- (IBAction)stepperMinus:(UIStepper *)sender {
    self.gameToEditPerformance.minus = sender.value;
    self.labelMinus.text = [NSString stringWithFormat:@"%ld", (long) self.gameToEditPerformance.minus];
}

- (IBAction)stepperPenaltyMinutes:(UIStepper *)sender {
    self.gameToEditPerformance.penaltyMinutes = sender.value;
    self.labelPenaltyMinutes.text = [NSString stringWithFormat:@"%ld", (long) self.gameToEditPerformance.penaltyMinutes];
}

- (IBAction)stepperPenaltiesDrawn:(UIStepper *)sender {
    self.gameToEditPerformance.penaltiesDrawn = sender.value;
    self.labelPenaltiesDrawn.text = [NSString stringWithFormat:@"%ld", (long) self.gameToEditPerformance.penaltiesDrawn];
}

- (IBAction)stepperPPShifts:(UIStepper *)sender {
    self.gameToEditPerformance.shiftsPP = sender.value;
    self.labelPPShifts.text = [NSString stringWithFormat:@"%ld", (long) self.gameToEditPerformance.shiftsPP];
}

- (IBAction)stepperPKShifts:(UIStepper *)sender {
    self.gameToEditPerformance.shiftsPK = sender.value;
    self.labelPKShifts.text = [NSString stringWithFormat:@"%ld", (long) self.gameToEditPerformance.shiftsPK];
}
- (IBAction)segcontPosition:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        self.gameToEditPerformance.position = @"W";
    } else if (sender.selectedSegmentIndex == 1) {
        self.gameToEditPerformance.position = @"C";
    } else {
        self.gameToEditPerformance.position = @"D";
    }
}
@end
