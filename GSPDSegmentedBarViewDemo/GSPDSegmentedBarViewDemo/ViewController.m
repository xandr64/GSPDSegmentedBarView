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
#import "GSPDSegmentedBarView.h"
#import "GSPDSegmentedBarSegment.h"
#import <CoreText/CTStringAttributes.h>

@interface ViewController ()

@property (nonatomic, strong) GSPDSegmentedBarView *segmentedBarView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSMutableAttributedString *value = [[NSMutableAttributedString alloc] initWithString:@"1012/l"
                                                                              attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:10],
                                                                                           NSBackgroundColorAttributeName : [UIColor clearColor],
                                                                                           NSForegroundColorAttributeName : [UIColor whiteColor]}];
    NSDictionary *superscriptAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:10],
                                            NSBackgroundColorAttributeName : [UIColor clearColor],
                                            NSForegroundColorAttributeName : [UIColor whiteColor],
                                            (NSString *)kCTSuperscriptAttributeName : @(1)};
    [value setAttributes:superscriptAttributes range:NSMakeRange(2, 2)];
    self.balloonView.attributedText = value;
    
    self.angularView.customBackgroundColor = [UIColor yellowColor];
    self.angularView.anglularPartWidth = 25.0f;
    self.angularView.style = GSPDAngularViewStyleTwoSided;
    
    GSPDSegmentedBarSegment *segment1 = [[GSPDSegmentedBarSegment alloc] initWithMinValue:@(0.1) maxValue:@(1) color:[UIColor colorWithRed:0.94 green:0.24 blue:0.18 alpha:1]];
    segment1.segmentDescription = @"Segment 1";
    segment1.sideTextStyle = GSPDSegmentedBarSegmentSideTextStyleOneSided;
    GSPDSegmentedBarSegment *segment2 = [[GSPDSegmentedBarSegment alloc] initWithMinValue:@(1.1) maxValue:@(2.1) color:[UIColor colorWithRed:0.55 green:0.78 blue:0.24 alpha:1]];
    GSPDSegmentedBarSegment *segment3 = [[GSPDSegmentedBarSegment alloc] initWithMinValue:@(2.1) maxValue:@(3.1) color:[UIColor colorWithRed:0.94 green:0.24 blue:0.18 alpha:1]];
    segment3.segmentDescription = @"Segment 3";
    segment3.sideTextStyle = GSPDSegmentedBarSegmentSideTextStyleTwoSided;
    self.segmentedBarView = [[GSPDSegmentedBarView alloc] initWithValue:@(2.2) unit:nil segments:@[segment1, segment2, segment3]];
    self.segmentedBarView.valueSegmentIndex = 1;
    self.segmentedBarView.frame = (CGRect){{0, self.view.frame.size.height - 200}, {self.view.frame.size.width, 85}};
    self.segmentedBarView.value = @(0.1);
    [self.view addSubview:self.segmentedBarView];
    
    GSPDSegmentedBarView *sbv = [[GSPDSegmentedBarView alloc] initWithFrame:CGRectNull];
    sbv.frame = (CGRect){{0, self.view.frame.size.height - 110}, {self.view.frame.size.width, 185}};
    sbv.segments = @[segment1];
    [self.view addSubview:sbv];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
