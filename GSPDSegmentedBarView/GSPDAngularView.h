//
//  GSPDAngularView.h
//  GSPDSegmentedBarViewDemo
//
//  Created by Alexander Kiyaykin on 25.11.15.
//  Copyright © 2015 GSPD. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, GSPDAngularViewStyle) {
    GSPDAngularViewStyleDefault,
    GSPDAngularViewStyleLeftSided,
    GSPDAngularViewStyleRightSided,
    GSPDAngularViewStyleTwoSided
};

@interface GSPDAngularView : UIView

@property (nonatomic, assign) CGFloat anglularPartWidth;
@property (nonatomic, assign) GSPDAngularViewStyle style;
@property (nonatomic, assign) UIColor *customBackgroundColor;

@end
