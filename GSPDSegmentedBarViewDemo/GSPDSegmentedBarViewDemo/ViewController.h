//
//  ViewController.h
//  GSPDSegmentedBarViewDemo
//
//  Created by Alexander Kiyaykin on 25.11.15.
//  Copyright © 2015 GSPD. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GSPDBalloonView;
@class GSPDAngularView;
@class GSPDSegmentedBarView;

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet GSPDBalloonView *balloonView;
@property (strong, nonatomic) IBOutlet GSPDAngularView *angularView;
@property (strong, nonatomic) IBOutlet GSPDSegmentedBarView *segmentedBarViewFromStoryboard;

@end
