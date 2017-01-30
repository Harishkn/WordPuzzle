//
//  TestView.m
//  QuizApplication
//
//  Created by test on 11/7/16.
//  Copyright © 2016 neorays. All rights reserved.
//

#import "TestView.h"

@interface TestView(){
    CGFloat startAngle;
    CGFloat endAngle;
}

@end

@implementation TestView


-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    
    if(self)
    {
        self.backgroundColor=[UIColor blueColor];
        startAngle = M_PI * 1.5;
        endAngle = startAngle + (M_PI * 2);
    }
    
    return self;
}


- (void)drawRect:(CGRect)rect
{
    
    startAngle = M_PI * 1.5;
    endAngle = startAngle + (M_PI * 2);
    // Display our percentage as a string
//    NSString* textContent = [NSString stringWithFormat:@"%d:%02d", (int)_minutes,(int)_seconds];
//    NSString *textContent1=[NSString stringWithFormat:@"%@",@"sec"];
    
    UIBezierPath* bezierPath1 = [UIBezierPath bezierPath];
    
    // Create our arc, with the correct angles
    [bezierPath1 addArcWithCenter:CGPointMake(rect.size.width / 2, rect.size.height / 2)
                          radius:100
                      startAngle:0
                        endAngle:2 * M_PI
                       clockwise:NO];
    
    // Set the display for the path, and stroke it
    bezierPath1.lineWidth = 3;
    [[UIColor grayColor] setStroke];
    [bezierPath1 stroke];
   // self.totalTime = (float)_percent;
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    
    // Create our arc, with the correct angles
    [bezierPath addArcWithCenter:CGPointMake(rect.size.width / 2, rect.size.height / 2)
                          radius:100
                      startAngle:startAngle
                        endAngle:(endAngle - startAngle) * (_percent / 60.0) + startAngle
                       clockwise:NO];
    
    // Set the display for the path, and stroke it
    bezierPath.lineWidth = 3;
    [[UIColor whiteColor] setStroke];
    [bezierPath stroke];
   
}

@end
