//
//  GSPDSegmentedBarView.h
//  GSPDSegmentedBarViewDemo
//
//  Created by Alexander Kiyaykin on 25.11.15.
//  Copyright © 2015 GSPD. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GSPDSegmentedBarSegment;

@interface GSPDSegmentedBarView : UIView

@property (nonatomic, strong) NSNumber *value;
@property (nonatomic, strong) NSAttributedString *unit;
@property (nonatomic, strong) NSOrderedSet *segments;
@property (nonatomic) NSInteger valueSegmentIndex;

//Customize appearance
@property (nonatomic, assign) CGFloat distanceBetweenSegments;

- (instancetype)initWithValue:(NSNumber *)value unit:(NSAttributedString *)unit segments:(NSOrderedSet *)segments;
- (void)addSegment:(GSPDSegmentedBarSegment *)segment;

@end
