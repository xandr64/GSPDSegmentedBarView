#import "GSPDSegmentView.h"
#import "GSPDAngularView.h"
#import "GSPDSegmentedBarSegment.h"

@interface GSPDSegmentView ()

@property (nonatomic, strong) GSPDAngularView *angularView;
@property (nonatomic, strong) UITextField *valueTextField;
@property (nonatomic, strong) UITextField *descriptionTextField;

@end

@implementation GSPDSegmentView

- (instancetype)initWithSegment:(GSPDSegmentedBarSegment *)segment angleStyle:(GSPDSegmentViewAngleStyle)style {
    self = [super init];
    if (self) {
        self.segment = segment;
        self.angleStyle = style;
        [self generateLayout];
    }
    return self;
}

- (void)layoutSubviews {
    self.angularView.frame = (CGRect){{0, 0}, {self.frame.size.width, self.frame.size.height / 2}};
}

- (void)generateLayout {
    self.angularView = [[GSPDAngularView alloc] initWithAngularPartWidth:15.0f style:(GSPDAngularViewStyle)_angleStyle backgroundColor:_segment.color];
    [self addSubview:self.angularView];
}

@end
