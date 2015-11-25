//
//  GSPDSegmentedBarView.m
//  GSPDSegmentedBarViewDemo
//
//  Created by Alexander Kiyaykin on 25.11.15.
//  Copyright © 2015 GSPD. All rights reserved.
//

#import "GSPDSegmentedBarView.h"
#import "GSPDSegmentedBarSegment.h"

static NSInteger const NO_VALUE_SEGMENT_INDEX = -1;

@interface GSPDSegmentedBarView ()

@property (nonatomic, strong) NSOrderedSet *segmentViews;

@end

@implementation GSPDSegmentedBarView

- (instancetype)initWithValue:(NSNumber *)value unit:(NSAttributedString *)unit segments:(NSOrderedSet *)segments {
    return [self initWithValue:value unit:unit segments:segments valueSegmentIndex:NO_VALUE_SEGMENT_INDEX];
}

- (instancetype)initWithValue:(NSNumber *)value unit:(NSAttributedString *)unit segments:(NSOrderedSet *)segments valueSegmentIndex:(NSUInteger)index {
    self = [super init];
    if (self) {
        self.value = value;
        self.unit = unit;
        self.segments = segments;
        self.valueSegmentIndex = index;
    }
    return self;
}

- (NSInteger)segmentIndexForValue:(NSNumber *)value {
    NSInteger currentIndex = 0;
    for (GSPDSegmentedBarSegment *segment in self.segments) {
        currentIndex++;
        if (([value compare:segment.minValue] == NSOrderedDescending || ([value compare:segment.minValue] == NSOrderedSame && segment.containsMinValue)) && ([value compare:segment.maxValue] == NSOrderedAscending || ([value compare:segment.maxValue] == NSOrderedSame && segment.containsMinValue))) {
            return currentIndex;
        }
    }
    return NO_VALUE_SEGMENT_INDEX;
}

- (void)layoutSubviews {
    
}

@end
