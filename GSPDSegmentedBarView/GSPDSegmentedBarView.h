#import <UIKit/UIKit.h>

@class GSPDSegmentedBarSegment;

@interface GSPDSegmentedBarView : UIView

@property (nonatomic, strong) NSNumber *value;
@property (nonatomic, strong) NSAttributedString *unit;
@property (nonatomic, strong) NSArray *segments;
@property (nonatomic) NSInteger valueSegmentIndex;

//Customize appearance
@property (nonatomic, assign) CGFloat distanceBetweenSegments;
@property (nonatomic, strong) NSString *noSegmentsText;
@property (nonatomic, strong) UIColor *noSegmentsBackgroundColor;
@property (nonatomic, strong) UIColor *valuesTextColor;
@property (nonatomic, strong) UIColor *descriptionsTextColor;
@property (nonatomic, strong) UIColor *balloonTextColor;
@property (nonatomic, strong) UIFont *valuesFont;
@property (nonatomic, strong) UIFont *descriptionsFont;
@property (nonatomic, strong) UIFont *balloonFont;

- (instancetype)initWithValue:(NSNumber *)value unit:(NSAttributedString *)unit segments:(NSArray *)segments;
- (void)addSegment:(GSPDSegmentedBarSegment *)segment;

@end
