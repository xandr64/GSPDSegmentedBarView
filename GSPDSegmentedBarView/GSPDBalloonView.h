//
//  GSPDBalloonView.h
//  GSPDSegmentedBarViewDemo
//
//  Created by Alexander Kiyaykin on 25.11.15.
//  Copyright © 2015 GSPD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GSPDBalloonView : UIView

@property (nonatomic, assign) CGFloat arrowHeight;
@property (nonatomic, assign) CGFloat cornerRadius;
@property (nonatomic, strong) NSAttributedString *attributedText;
@property (nonatomic, strong) UIColor *balloonBackroundColor;

@end
