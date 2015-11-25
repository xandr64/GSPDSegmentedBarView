//
//  GSPDSegmentedBarSegment.h
//  GSPDSegmentedBarViewDemo
//
//  Created by Alexander Kiyaykin on 25.11.15.
//  Copyright © 2015 GSPD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GSPDSegmentedBarSegment : NSObject

@property (nonatomic, strong) NSNumber *minValue;
@property (nonatomic, strong) NSNumber *maxValue;
@property (nonatomic, strong) NSString *segmentDescription;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, assign) BOOL containsMinValue;
@property (nonatomic, assign) BOOL containsMaxValue;

- (BOOL)isPoint;

@end
