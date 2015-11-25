//
//  GSPDSegmentedBarSegment.m
//  GSPDSegmentedBarViewDemo
//
//  Created by Alexander Kiyaykin on 25.11.15.
//  Copyright © 2015 GSPD. All rights reserved.
//

#import "GSPDSegmentedBarSegment.h"

@implementation GSPDSegmentedBarSegment

- (BOOL)isPoint {
    return [self.minValue isEqualToNumber:self.maxValue];
}

@end
