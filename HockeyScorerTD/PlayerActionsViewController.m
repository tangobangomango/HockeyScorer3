//
//  PlayerActionsViewController.m
//  HockeyScorerTD
//
//  Created by Anne West on 9/8/14.
//  Copyright (c) 2014 TDG. All rights reserved.
//

#import "PlayerActionsViewController.h"
#import "Game.h"

@interface PlayerActionsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *opponentLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;


//Collection used here so can change button labels via fast enumeration
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *actionButtonCollection;

//Label outlets
@property (weak, nonatomic) IBOutlet UILabel *labelShotsOnGoal;
@property (weak, nonatomic) IBOutlet UILabel *labelShotsNotOnGoal;
@property (weak, nonatomic) IBOutlet UILabel *labelPassesComplete;
@property (weak, nonatomic) IBOutlet UILabel *labelPassesNotComplete;
@property (weak, nonatomic) IBOutlet UILabel *labelTakeaways;
@property (weak, nonatomic) IBOutlet UILabel *labelGiveaways;
@property (weak, nonatomic) IBOutlet UILabel *labelFaceoffsWon;
@property (weak, nonatomic) IBOutlet UILabel *labelFaceoffsLost;
@property (weak, nonatomic) IBOutlet UILabel *labelShifts;
@property (weak, nonatomic) IBOutlet UILabel *labelBlocks;

//Button outlets. These are used to attach gesture recognizers
@property (weak, nonatomic) IBOutlet UIButton *outletShotsOnGoal;
@property (weak, nonatomic) IBOutlet UIButton *outletShotsNotOnGoal;
@property (weak, nonatomic) IBOutlet UIButton *outletPassesComplete;
@property (weak, nonatomic) IBOutlet UIButton *outletPassesNotComplete;
@property (weak, nonatomic) IBOutlet UIButton *outletTakeaways;
@property (weak, nonatomic) IBOutlet UIButton *outletGiveaways;
@property (weak, nonatomic) IBOutlet UIButton *outletFaceoffsWon;
@property (weak, nonatomic) IBOutlet UIButton *outletFaceoffsLost;
@property (weak, nonatomic) IBOutlet UIButton *outletShifts;
@property (weak, nonatomic) IBOutlet UIButton *outletBlocks;


//Button actions. These will all be empty methods since there is no action on click, just on long press
- (IBAction)buttonShotsOnGoal:(UIButton *)sender;
- (IBAction)buttonShotsNotOnGoal:(UIButton *)sender;
- (IBAction)buttonPassesComplete:(UIButton *)sender;
- (IBAction)buttonPassesNotComplete:(id)sender;
- (IBAction)buttonTakeaways:(UIButton *)sender;
- (IBAction)buttonGiveaways:(UIButton *)sender;
- (IBAction)buttonFaceoffsWon:(UIButton *)sender;
- (IBAction)buttonFaceoffsLost:(UIButton *)sender;
- (IBAction)buttonShifts:(UIButton *)sender;
- (IBAction)buttonBlocks:(UIButton *)sender;

//Subtraction switch
@property (weak, nonatomic) IBOutlet UISwitch *subtractionSwitch;
- (IBAction)changeSubtractionSwitch:(UISwitch *)sender;
@property (weak, nonatomic) IBOutlet UILabel *labelSubtractionAbleState;


@end

@implementation PlayerActionsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//if breakpoints are in project it will appear to crash when you call play
- (AVAudioPlayer *) setupAudioPlayerWithFile: (NSString *) file type: (NSString *) type
{
    //Need full path to sound file. [NSBundle mainbundle] is where to look
    NSString *path = [[NSBundle mainBundle] pathForResource: file ofType:type];
    //full path in format of a url
    NSURL *url = [NSURL fileURLWithPath: path];
    //just in case there is an error
    NSError *error;
    //sets up the player.  Returns nil if there is an error
    AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    //test error
    if (!audioPlayer) {
        NSLog(@"%@", [error description]);
    }
    
    return audioPlayer;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.parentViewController.navigationItem setTitle:self.gameToEditPerformance.opponent];//Puts the name of opponent in the top nave bar for all three tabs
    self.dateLabel.text = [self convertDateOf:self.gameToEditPerformance.dateOfGame toFormat:@"MMM d, yyyy"];
    [self setupGestureRecognizers];//for long presses
    self.subtractionSwitch.on = NO;//to be sure not enabled
    [self loadDataInLabels];
    
    //setup sound to play when log press released
    buttonBeep = [self setupAudioPlayerWithFile:@"ButtonTap" type:@"wav"];
    [buttonBeep setVolume:0.5];
    [buttonBeep prepareToPlay];
}

//can load without checking to see if data exists since nil will be treated as zero
- (void) loadDataInLabels
{
    NSLog(@"Shots to load %@", [NSString stringWithFormat:@"%ld", (long) self.gameToEditPerformance.shotsOnGoal]);
    self.labelShotsOnGoal.text = [NSString stringWithFormat:@"%ld", (long) self.gameToEditPerformance.shotsOnGoal];
    self.labelShotsNotOnGoal.text = [NSString stringWithFormat:@"%ld", (long) self.gameToEditPerformance.shotsNotOnGoal];
    self.labelPassesComplete.text = [NSString stringWithFormat:@"%ld", (long) self.gameToEditPerformance.passesCompleted];
    self.labelPassesNotComplete.text = [NSString stringWithFormat:@"%ld", (long) self.gameToEditPerformance.passesNotCompleted];
    self.labelTakeaways.text = [NSString stringWithFormat:@"%ld", (long) self.gameToEditPerformance.takeaways];
    self.labelGiveaways.text = [NSString stringWithFormat:@"%ld", (long) self.gameToEditPerformance.giveaways];
    self.labelFaceoffsWon.text = [NSString stringWithFormat:@"%ld", (long) self.gameToEditPerformance.faceoffsWon];
    self.labelFaceoffsLost.text = [NSString stringWithFormat:@"%ld", (long) self.gameToEditPerformance.faceoffsLost];
    self.labelShifts.text = [NSString stringWithFormat:@"%ld", (long) self.gameToEditPerformance.shifts];
    self.labelBlocks.text = [NSString stringWithFormat:@"%ld", (long) self.gameToEditPerformance.blockedShots];
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

#pragma mark - date conversion methods


- (NSString *) convertDateOf: (NSDate *) date toFormat: (NSString *) outputFormat
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: outputFormat];
    
    return [dateFormatter stringFromDate: date];
}

- (NSDate *) convertToDate: (NSString *) dateString withFormat: (NSString *) formatString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: formatString];
    
    return [dateFormatter dateFromString:dateString];
}

#pragma mark - Action elements (buttons and switches)



- (void) setupGestureRecognizers
//Need one recognizer instance for each action button
{
    UILongPressGestureRecognizer *longPress1 = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(buttonPressed:)];
    longPress1.minimumPressDuration = 0.5f;//how long have to hold
    longPress1.allowableMovement = 100.0f;//how close to button need to be
    [self.outletShotsOnGoal addGestureRecognizer:longPress1];
    
    UILongPressGestureRecognizer *longPress2 = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(buttonPressed:)];
    longPress2.minimumPressDuration = 0.5f;
    longPress2.allowableMovement = 100.0f;
    [self.outletShotsNotOnGoal addGestureRecognizer:longPress2];
    
    UILongPressGestureRecognizer *longPress3 = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(buttonPressed:)];
    longPress3.minimumPressDuration = 0.5f;
    longPress3.allowableMovement = 100.0f;
    [self.outletPassesComplete addGestureRecognizer:longPress3];
    
    UILongPressGestureRecognizer *longPress4 = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(buttonPressed:)];
    longPress4.minimumPressDuration = 0.5f;
    longPress4.allowableMovement = 100.0f;
    [self.outletPassesNotComplete addGestureRecognizer:longPress4];
    
    UILongPressGestureRecognizer *longPress5 = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(buttonPressed:)];
    longPress5.minimumPressDuration = 0.5f;
    longPress5.allowableMovement = 100.0f;
    [self.outletTakeaways addGestureRecognizer:longPress5];
    
    UILongPressGestureRecognizer *longPress6 = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(buttonPressed:)];
    longPress6.minimumPressDuration = 0.5f;
    longPress6.allowableMovement = 100.0f;
    [self.outletGiveaways addGestureRecognizer:longPress6];
    
    UILongPressGestureRecognizer *longPress7 = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(buttonPressed:)];
    longPress7.minimumPressDuration = 0.5f;
    longPress7.allowableMovement = 100.0f;
    [self.outletFaceoffsWon addGestureRecognizer:longPress7];
    
    UILongPressGestureRecognizer *longPress8 = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(buttonPressed:)];
    longPress8.minimumPressDuration = 0.5f;
    longPress8.allowableMovement = 100.0f;
    [self.outletFaceoffsLost addGestureRecognizer:longPress8];
    
    UILongPressGestureRecognizer *longPress9 = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(buttonPressed:)];
    longPress9.minimumPressDuration = 0.5f;
    longPress9.allowableMovement = 100.0f;
    [self.outletShifts addGestureRecognizer:longPress9];
    
    UILongPressGestureRecognizer *longPress10 = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(buttonPressed:)];
    longPress10.minimumPressDuration = 0.5f;
    longPress10.allowableMovement = 100.0f;
    [self.outletBlocks addGestureRecognizer:longPress10];
}

- (void) buttonPressed: (UILongPressGestureRecognizer *) sender
{
    //set up buttons tags to determine which button pressed and which label to update
    self.outletShotsOnGoal.tag = 1001;
    self.outletShotsNotOnGoal.tag = 1002;
    self.outletPassesComplete.tag = 1003;
    self.outletPassesNotComplete.tag = 1004;
    self.outletTakeaways.tag = 1005;
    self.outletGiveaways.tag = 1006;
    self.outletFaceoffsWon.tag = 1007;
    self.outletFaceoffsLost.tag = 1008;
    self.outletShifts.tag = 1009;
    self.outletBlocks.tag = 1010;
    
    UIView *view = sender.view;
    long tag = view.tag;
    
    //when long press ended, update count and label
    if (sender.state == UIGestureRecognizerStateEnded) {
        if (tag == 1001) {
           if (!self.subtractionSwitch.on) {
               self.gameToEditPerformance.shotsOnGoal ++;
            } else if (self.subtractionSwitch.on && self.gameToEditPerformance.shotsOnGoal != 0){
                self.gameToEditPerformance.shotsOnGoal --;
            }
            self.labelShotsOnGoal.text = [NSString stringWithFormat:@"%ld", (long) self.gameToEditPerformance.shotsOnGoal];
            
        } else if (tag == 1002) {
            if (!self.subtractionSwitch.on) {
                self.gameToEditPerformance.shotsNotOnGoal ++;
            } else if (self.subtractionSwitch.on && self.gameToEditPerformance.shotsNotOnGoal != 0){
                self.gameToEditPerformance.shotsNotOnGoal --;
            }
            self.labelShotsNotOnGoal.text = [NSString stringWithFormat:@"%ld", (long) self.gameToEditPerformance.shotsNotOnGoal];
            
        } else if (tag == 1003) {
            if (!self.subtractionSwitch.on) {
                self.gameToEditPerformance.passesCompleted ++;
            } else if (self.subtractionSwitch.on && self.gameToEditPerformance.passesCompleted != 0){
                self.gameToEditPerformance.passesCompleted --;
            }
            self.labelPassesComplete.text = [NSString stringWithFormat:@"%ld", (long) self.gameToEditPerformance.passesCompleted];
            
        } else if (tag == 1004) {
            if (!self.subtractionSwitch.on) {
                self.gameToEditPerformance.passesNotCompleted ++;
            } else if (self.subtractionSwitch.on && self.gameToEditPerformance.passesNotCompleted != 0){
                self.gameToEditPerformance.passesNotCompleted --;
            }
            self.labelPassesNotComplete.text = [NSString stringWithFormat:@"%ld", (long) self.gameToEditPerformance.passesNotCompleted];
            
        } else if (tag == 1005) {
            if (!self.subtractionSwitch.on) {
                self.gameToEditPerformance.takeaways ++;
            } else if (self.subtractionSwitch.on && self.gameToEditPerformance.takeaways != 0){
                self.gameToEditPerformance.takeaways --;
            }
            self.labelTakeaways.text = [NSString stringWithFormat:@"%ld", (long) self.gameToEditPerformance.takeaways];
            
        } else if (tag == 1006) {
            if (!self.subtractionSwitch.on) {
                self.gameToEditPerformance.giveaways ++;
            } else if (self.subtractionSwitch.on && self.gameToEditPerformance.giveaways != 0){
                self.gameToEditPerformance.giveaways --;
            }
            self.labelGiveaways.text = [NSString stringWithFormat:@"%ld", (long) self.gameToEditPerformance.giveaways];
            
        } else if (tag == 1007) {
            if (!self.subtractionSwitch.on) {
                self.gameToEditPerformance.faceoffsWon ++;
            } else if (self.subtractionSwitch.on && self.gameToEditPerformance.faceoffsWon != 0){
                self.gameToEditPerformance.faceoffsWon --;
            }
            self.labelFaceoffsWon.text = [NSString stringWithFormat:@"%ld", (long) self.gameToEditPerformance.faceoffsWon];
            
        } else if (tag == 1008) {
            if (!self.subtractionSwitch.on) {
                self.gameToEditPerformance.faceoffsLost ++;
            } else if (self.subtractionSwitch.on && self.gameToEditPerformance.faceoffsLost != 0){
                self.gameToEditPerformance.faceoffsLost --;
            }
            self.labelFaceoffsLost.text = [NSString stringWithFormat:@"%ld", (long) self.gameToEditPerformance.faceoffsLost];
            
        } else if (tag == 1009) {
            if (!self.subtractionSwitch.on) {
                self.gameToEditPerformance.shifts ++;
            } else if (self.subtractionSwitch.on && self.gameToEditPerformance.shifts != 0){
                self.gameToEditPerformance.shifts --;
            }
            self.labelShifts.text = [NSString stringWithFormat:@"%ld", (long) self.gameToEditPerformance.shifts];
            
        } else if (tag == 1010) {
            if (!self.subtractionSwitch.on) {
                self.gameToEditPerformance.blockedShots ++;
            } else if (self.subtractionSwitch.on && self.gameToEditPerformance.blockedShots != 0){
                self.gameToEditPerformance.blockedShots --;
            }
            self.labelBlocks.text = [NSString stringWithFormat:@"%ld", (long) self.gameToEditPerformance.blockedShots];
            
        }
        
        [buttonBeep play];
        [self.delegate playerActionsViewController:self didEditGameData:self.gameToEditPerformance];
    }
}



- (IBAction)changeSubtractionSwitch:(UISwitch *)sender {
    
    if (self.subtractionSwitch.on) {
        for (UIButton *button in self.actionButtonCollection) {
             [button setImage:[UIImage imageNamed:@"minus.png"] forState:UIControlStateNormal];
        }
        self.labelSubtractionAbleState.text = @"Subtraction Enabled";
    } else {
        for (UIButton *button in self.actionButtonCollection) {
             [button setImage:[UIImage imageNamed:@"plus.png"] forState:UIControlStateNormal];
        }
        self.labelSubtractionAbleState.text = @"Subtraction Disabled";
    }
}



- (IBAction)buttonShotsOnGoal:(UIButton *)sender {
    
}

- (IBAction)buttonShotsNotOnGoal:(UIButton *)sender {
}

- (IBAction)buttonPassesComplete:(UIButton *)sender {
}

- (IBAction)buttonPassesNotComplete:(id)sender {
}

- (IBAction)buttonTakeaways:(UIButton *)sender {
}

- (IBAction)buttonGiveaways:(UIButton *)sender {
}

- (IBAction)buttonFaceoffsWon:(UIButton *)sender {
}

- (IBAction)buttonFaceoffsLost:(UIButton *)sender {
}

- (IBAction)buttonShifts:(UIButton *)sender {
}

- (IBAction)buttonBlocks:(UIButton *)sender {
}


@end
