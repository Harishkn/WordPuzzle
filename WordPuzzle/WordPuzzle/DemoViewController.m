//
//  DemoViewController.m
//  WordPuzzle
//
//  Created by Harish Kn on 19/01/17.
//  Copyright © 2017 Harish Kn. All rights reserved.
//

#import "DemoViewController.h"

@interface DemoViewController ()
@property(assign,nonatomic)int percentage;

@end

@implementation DemoViewController{
    TestView *m_testView;
    NSTimer* m_timer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    m_testView = [[TestView alloc]init];
    m_testView.percent=60.0;
    
    m_testView.totalTime=60;
    m_timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(decrementSpin) userInfo:nil repeats:YES];
    self.percentage = 100;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)decrementSpin
{
    // If we can decrement our percentage, do so, and redraw the view
    if (self.percentage>0.0) {
        self.percentage-=1.0;
        self.secondView.percent+=1.0;
        [self.secondView setNeedsDisplayInRect:self.secondView.bounds];
        [self.view addSubview:self.secondView];
    }
    else
    {
//        self.totAnsDisplayLbl.hidden=NO;
//        self.totAnsDisplayLbl.text=[NSString stringWithFormat:@"%@ Out of %@ Questions Are Correct",_ansStr,_quesStr];
    }
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
