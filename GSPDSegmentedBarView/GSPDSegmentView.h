#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, GSPDSegmentViewAngleStyle) {
    GSPDSegmentViewAngleStyleDefault,
    GSPDSegmentViewAngleStyleLeftSided,
    GSPDSegmentViewAngleStyleRightSided,
    GSPDSegmentViewAngleStyleTwoSided
};

@class GSPDSegmentedBarSegment;

@interface GSPDSegmentView : UIView

@property (nonatomic, strong) GSPDSegmentedBarSegment *segment;
@property (nonatomic, assign) GSPDSegmentViewAngleStyle angleStyle;

- (instancetype)initWithSegment:(GSPDSegmentedBarSegment *)segment angleStyle:(GSPDSegmentViewAngleStyle)style;

@end
