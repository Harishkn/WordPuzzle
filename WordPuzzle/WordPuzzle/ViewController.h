//
//  ViewController.h
//  WordPuzzle
//
//  Created by Harish Kn on 17/01/17.
//  Copyright © 2017 Harish Kn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestView.h"

@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *lableCollection;
@property (strong, nonatomic) IBOutlet UILabel *wordScore;
@property (strong, nonatomic) IBOutlet TestView *secondView;

@property (strong, nonatomic) IBOutlet UILabel *label1;
@property (strong, nonatomic) IBOutlet UILabel *label2;
@property (strong, nonatomic) IBOutlet UILabel *label3;
@property (strong, nonatomic) IBOutlet UILabel *label4;


@property(assign,nonatomic)int percentage;
@property (strong, nonatomic) IBOutlet UIButton *startButton;

@property (strong, nonatomic) IBOutlet UIImageView *resultImage;
@property (strong, nonatomic) IBOutlet UIButton *button5;
@property (strong, nonatomic) IBOutlet UILabel *wAttempLbl;
@property (strong, nonatomic) IBOutlet UILabel *bestScoreLbl;
@property (strong, nonatomic) IBOutlet UILabel *correctWord;

@end

