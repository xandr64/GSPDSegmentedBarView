//
//  ViewController.m
//  GSPDSegmentedBarViewDemo
//
//  Created by Alexander Kiyaykin on 25.11.15.
//  Copyright © 2015 GSPD. All rights reserved.
//

#import "ViewController.h"
#import "GSPDBalloonView.h"
#import "GSPDAngularView.h"
#import <CoreText/CTStringAttributes.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSMutableAttributedString *value = [[NSMutableAttributedString alloc] initWithString:@"(a + b)2 = a2 + 2ab + b2"
                                                                              attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14],
                                                                                           NSBackgroundColorAttributeName : [UIColor clearColor],
                                                                                           NSForegroundColorAttributeName : [UIColor whiteColor]}];
    NSDictionary *superscriptAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:14],
                                            NSBackgroundColorAttributeName : [UIColor clearColor],
                                            NSForegroundColorAttributeName : [UIColor whiteColor],
                                            (NSString *)kCTSuperscriptAttributeName : @(1)};
    [value setAttributes:superscriptAttributes range:NSMakeRange(7, 1)];
    [value setAttributes:superscriptAttributes range:NSMakeRange(12, 1)];
    [value setAttributes:superscriptAttributes range:NSMakeRange(23, 1)];
    self.balloonView.attributedText = value;
    self.balloonView.balloonBackgroundColor = [UIColor redColor];
    
    self.angularView.customBackgroundColor = [UIColor yellowColor];
    self.angularView.anglularPartWidth = 25.0f;
    self.angularView.style = GSPDAngularViewStyleTwoSided;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
