//
//  ViewController.m
//  WordPuzzle
//
//  Created by Harish Kn on 17/01/17.
//  Copyright © 2017 Harish Kn. All rights reserved.
//

#import "ViewController.h"
#import "UIButton+Glossy.h"
#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()



@property (strong, nonatomic) IBOutlet UIButton *button1;

@property (strong, nonatomic) IBOutlet UIButton *button2;
@property (strong, nonatomic) IBOutlet UIButton *button3;
@property (strong, nonatomic) IBOutlet UIButton *button4;
@property (strong, nonatomic) NSMutableString* compareString;

@property(strong,nonatomic)NSMutableArray* mutableArrayContainingNumbers;

@property(strong,nonatomic)NSString* letter;




@property(strong,nonatomic)NSArray* list;

@property (strong,nonatomic) NSMutableArray *numbers;

@end

@implementation ViewController
{
    NSString *ichar;
    NSMutableArray *characters;
    int i,score,bestScor,wAttempts;
    int r;
   
        TestView *m_testView;
        NSTimer* m_timer;
   

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
     i=0;
    
    self.numbers = [[NSMutableArray alloc]init];
    self.compareString = [[NSMutableString alloc]init];
    characters = [[NSMutableArray alloc] initWithCapacity:[self.letter length]];
   
    self.list = [[NSArray alloc]initWithObjects:@"note",@"tone",@"word",@"gone",@"nice",@"came",@"pick",@"kick",@"kill",@"loop",@"mood",@"luck",@"temp",@"hide", @"jazz",@"fuzz",@"fizz",@"hajj",@"juju",@"quiz",@"razz",@"jeez",@"jeux",@"jinx",@"jock",@"able",@"know",@"kiwi",@"wiki",@"kite",@"lack",@"lacs",@"lacy",@"lade",@"lead",@"deal",@"lads",@"lady",@"lags",@"laic",@"laid",@"lain",@"lard",@"fork",@"form",@"fort",@"foul",@"four",@"fowl",@"foxy",@"fray",@"free",@"fret",@"friz",@"frog",@"from",@"fuel",@"full",@"fume",@"fumy",@"fund",@"funk",@"furs",@"fury", @"gulp",@"plug",@"gums",@"gunk",@"guns",@"guru",@"gush",@"clay", @"gust",@"guys",@"gyms",@"gyps",@"gyre",@"gyro",@"hack",@"hags",@"hail",@"hair",@"half",@"hall",@"halo",@"halt",@"hams",@"hand",@"hang",@"gang",@"mage",@"magi",@"maid",@"mail",@"maim",@"main",@"make",@"male",@"mall",@"malt",@"pool",@"loop",@"polo",@"game",@"gusy",@"flow",@"wolf",@"slag",@"nail",@"guts",@"lame",nil];
  
    
    [self.startButton makeGlossy];
    [self.button1 makeGlossy];
    [self.button2 makeGlossy];
    [self.button3 makeGlossy];
    [self.button4 makeGlossy];
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger bestScore = [defaults integerForKey:@"HighScore"];
    
    self.bestScoreLbl.text = [NSString stringWithFormat:@"%ld",(long)bestScore];
    
   }
- (void)decrementSpin
{
   //  If we can decrement our percentage, do so, and redraw the view
    if (self.percentage>0.0) {
        self.percentage-=1.0;
        
        
        self.secondView.percent+=1.0;
        [self.secondView setNeedsDisplayInRect:self.secondView.bounds];
        [self.view addSubview:self.secondView];
    
    }

    else
    {
        [m_timer invalidate];
      //  [self.secondView setHidden:NO];
        m_timer = nil;
      
       
       
        UIAlertController* controller = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"%d",score] message:@"Time Over" preferredStyle:UIAlertControllerStyleAlert];
       
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.startButton setHidden:NO];
        }];
        
        [controller addAction:action];
        
         AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        [self presentViewController:controller animated:YES completion:^{
            NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
            
            self.correctWord.text =[NSString stringWithFormat:@"%@",self.letter];
            
            NSInteger bestScore = [defaults integerForKey:@"HighScore"];
            
            if (score>=bestScore)
            {
                [defaults setInteger:score forKey:@"HighScore"];
                [defaults synchronize];
            }
            score = 0;
            
           
            
            self.mutableArrayContainingNumbers = [[NSMutableArray alloc]init];
            self.numbers=[[NSMutableArray alloc]init];
            characters=[[NSMutableArray alloc]init];
            _letter=[[NSString alloc]init];
            [self clearingAllLabelContent];
            [self disAbleAllButtons];
           NSInteger bestScore2 = [defaults integerForKey:@"HighScore"];
            self.bestScoreLbl.text = [NSString stringWithFormat:@"%ld",(long)bestScore2];
            self.wordScore.text = [NSString stringWithFormat:@"0"];
             self.wAttempLbl.text = [NSString stringWithFormat:@"0"];
        }];
        
       
       
        
    }
    
}

-(void)nextWord
{
    [self.resultImage setHidden:YES];
    self.wordScore.text=[NSString stringWithFormat:@"%d",score];
    self.mutableArrayContainingNumbers = [[NSMutableArray alloc]init];
    self.numbers=[[NSMutableArray alloc]init];
    characters=[[NSMutableArray alloc]init];
    _letter=[[NSString alloc]init];
    NSMutableArray *uniqueNumbers = [[NSMutableArray alloc] init];
    
    while ([uniqueNumbers count] < [self.list count]-1) {
        r= arc4random_uniform((int)[self.list count]-1);
        if (![uniqueNumbers containsObject:[NSNumber numberWithInt:r]]) {
            [uniqueNumbers addObject:[NSNumber numberWithInt:r]];
        }
    }
    
    self.letter = [self.list objectAtIndex:r];
    
  
    
    while ([self.numbers count] < 4) {
        [self generateRandomNumber];
    }
    
   
    [self buttonTitle];
    [self enableAllButtons];
}

-(void)sameWord
{
    self.mutableArrayContainingNumbers = [[NSMutableArray alloc]init];
    self.numbers=[[NSMutableArray alloc]init];
    characters=[[NSMutableArray alloc]init];
    _letter=[[NSString alloc]init];
}

#pragma generating random Number

-(void)generateRandomNumber
{
    int k = arc4random_uniform(4);
    if ([_numbers count]<4) {
        if ([self.numbers containsObject:[NSNumber numberWithInt:k]])
        {
            
            [self generateRandomNumber];
        }
        else
        {
            [self.numbers addObject:[NSNumber numberWithInt:k]];
            
            
         
             ichar = [NSString stringWithFormat:@"%c", [self.letter characterAtIndex:k]];
            
            [characters addObject:ichar];
            
           
        }
        

    }

    
}

#pragma - assigning title for button

-(void)buttonTitle
{
    [self.button1 setTitle:[characters objectAtIndex:0] forState:UIControlStateNormal];
    [self.button2 setTitle:[characters objectAtIndex:1] forState:UIControlStateNormal];
    [self.button3 setTitle:[characters objectAtIndex:2] forState:UIControlStateNormal];
    [self.button4 setTitle:[characters objectAtIndex:3] forState:UIControlStateNormal];
}

   
    




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)button1:(id)sender {
    
    [[self.lableCollection objectAtIndex:i] setText:[NSString stringWithFormat:@"%@",self.button1.currentTitle]];
    i++;
    [self.compareString appendString:[NSString stringWithFormat:@"%@",self.button1.currentTitle]];
   
    [self.button1 setEnabled:NO];
 
    [self delayFunction];
}
- (IBAction)button2:(id)sender {
   
   
    [[self.lableCollection objectAtIndex:i] setText:[NSString stringWithFormat:@"%@",self.button2.currentTitle]];
    i++;
    [self.compareString appendString:[NSString stringWithFormat:@"%@",self.button2.currentTitle]];
    [self.button2 setEnabled:NO];
  
    [self delayFunction];
}
- (IBAction)button3:(id)sender {
  
    
    [[self.lableCollection objectAtIndex:i] setText:[NSString stringWithFormat:@"%@",self.button3.currentTitle]];
    i++;
    [self.compareString appendString:[NSString stringWithFormat:@"%@",self.button3.currentTitle]];
    [self.button3 setEnabled:NO];
   
    [self delayFunction];
}
- (IBAction)button4:(id)sender {
   
    [[self.lableCollection objectAtIndex:i] setText:[NSString stringWithFormat:@"%@",self.button4.currentTitle]];
     i++;
    [self.compareString appendString:[NSString stringWithFormat:@"%@",self.button4.currentTitle]];
    [self.button4 setEnabled:NO];
    [self delayFunction];
    
}

-(void)delayFunction
{
    
    if(i==4)
    {
       
        double delayInSecond = 0.03;
        dispatch_time_t popTym = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSecond * NSEC_PER_SEC));
        dispatch_after(popTym, dispatch_get_main_queue(), ^(void){
            
            [self checkingResults];
        });
        
    }
}

-(void)checkingResults
{
    
    if (i ==4) {
        
    
            
            if ([self.list containsObject:self.compareString])
                
           
        {
            [self.button5 setHidden:NO];
            
            self.resultImage.image = [UIImage imageNamed:@"Checkmark-528"];
            
            [self.button5 setImage:[UIImage imageNamed:@"Checkmark-528"]forState:UIControlStateNormal];
            score+=1;
            self.percentage+=1.0;
            
            self.secondView.percent-=1.0;
            [self.secondView setNeedsDisplayInRect:self.secondView.bounds];
            [self.view addSubview:self.secondView];
            i=0;
            ichar=[[NSString alloc]init];
            double delayInSecond = 0.5;
            dispatch_time_t popTym = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSecond * NSEC_PER_SEC));
            dispatch_after(popTym, dispatch_get_main_queue(), ^(void){
                
                [self.button5 setHidden:YES];
            });
            
            [self showButtons];
            self.compareString =[[NSMutableString alloc]init];
            [self clearingAllLabelContent];
            [self nextWord];
            
            
        }
        else{
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
            [self.button5 setHidden:NO];
            wAttempts++;
            self.wAttempLbl.text = [NSString stringWithFormat:@"%d",wAttempts];
            [self.button5 setImage:[UIImage imageNamed:@"Delete-96"]forState:UIControlStateNormal];

            i=0;
            ichar=[[NSString alloc]init];
            [self showButtons];
            self.compareString =[[NSMutableString alloc]init];
            [self clearingAllLabelContent];
            [self sameWord];
            double delayInSecond = 0.5;
            dispatch_time_t popTym = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSecond * NSEC_PER_SEC));
            dispatch_after(popTym, dispatch_get_main_queue(), ^(void){
                
                [self.button5 setHidden:YES];
            });
            [self enableAllButtons];
            
            
        }
        
        
    }
}

#pragma Enabling Buttons
-(void)enableAllButtons
{
   
    [self.button1 setEnabled:YES];
    [self.button2 setEnabled:YES];
    [self.button3 setEnabled:YES];
    [self.button4 setEnabled:YES];
   
    
    
    
}

-(void)hideAllButtons
{
    [self.button1 setHidden:YES];
    [self.button2 setHidden:YES];
    [self.button3 setHidden:YES];
    [self.button4 setHidden:YES];
    [self.resultImage setHidden:NO];
}

-(void)disAbleAllButtons
{
    
    [self.button1 setEnabled:NO];
    [self.button2 setEnabled:NO];
    [self.button3 setEnabled:NO];
    [self.button4 setEnabled:NO];
    
}

-(void)showButtons
{
    [self.button1 setHidden:NO];
    [self.button2 setHidden:NO];
    [self.button3 setHidden:NO];
    [self.button4 setHidden:NO];
     [self.resultImage setHidden:YES];
}


-(void)clearingAllLabelContent
{
    [[self.lableCollection objectAtIndex:0] setText:[NSString stringWithFormat:@"%@",@""]];
    [[self.lableCollection objectAtIndex:1] setText:[NSString stringWithFormat:@"%@",@""]];
    [[self.lableCollection objectAtIndex:2] setText:[NSString stringWithFormat:@"%@",@""]];
    [[self.lableCollection objectAtIndex:3] setText:[NSString stringWithFormat:@"%@",@""]];
}


- (IBAction)startGame:(id)sender {
    
   // [self.secondView setHidden:NO];
    [self.startButton setHidden:YES];
    wAttempts=0;
    self.correctWord.text = [NSString stringWithFormat:@"Possible word"];
    //[self.startButton setEnabled:NO];
    
    [self enableAllButtons];
    self.mutableArrayContainingNumbers = [[NSMutableArray alloc]init];
    
   
    NSMutableArray *uniqueNumbers = [[NSMutableArray alloc] init];
    
    while ([uniqueNumbers count] < [self.list count]-1) {
        r= arc4random_uniform((int)[self.list count]-1);
        if (![uniqueNumbers containsObject:[NSNumber numberWithInt:r]]) {
            [uniqueNumbers addObject:[NSNumber numberWithInt:r]];
        }
    }
    
    self.letter = [self.list objectAtIndex:r];
    
   
    
    while ([self.numbers count] < 4) {
        [self generateRandomNumber];
    }
    
  
    [self buttonTitle];
    
    
    m_testView = [[TestView alloc]init];
    m_testView.percent=60.0;
    
    m_testView.totalTime=(float) m_testView.percent;
    m_timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(decrementSpin) userInfo:nil repeats:YES];
    
    self.percentage = 60;
    
}



@end
