#import "GSPDSegmentedBarView.h"
#import "GSPDSegmentView.h"
#import "GSPDSegmentedBarSegment.h"
#import "GSPDBalloonView.h"

static NSInteger const NO_VALUE_SEGMENT_INDEX = -1;

@interface GSPDSegmentedBarView ()

@property (nonatomic, strong) NSArray *segmentViews;
@property (nonatomic, strong) GSPDBalloonView *valueView;

@end

@implementation GSPDSegmentedBarView {
    CGFloat balloonViewHeight;
    CGFloat balloonViewWidth;
    CGFloat arrowViewHeight;
    CGFloat segmentViewHeight;
}

- (instancetype)initWithValue:(NSNumber *)value unit:(NSAttributedString *)unit segments:(NSArray *)segments {
    return [self initWithValue:value unit:unit segments:segments valueSegmentIndex:NO_VALUE_SEGMENT_INDEX];
}

- (instancetype)initWithValue:(NSNumber *)value unit:(NSAttributedString *)unit segments:(NSArray *)segments valueSegmentIndex:(NSUInteger)index {
    self = [super init];
    if (self) {
        _value = value;
        _unit = unit;
        _segments = segments;
        _valueSegmentIndex = index;
        _distanceBetweenSegments = 3.0f;
        _noSegmentsText = @"Empty";
        _noSegmentsBackgroundColor = [UIColor lightGrayColor];
        balloonViewHeight = 32.0f;
        balloonViewWidth = 72.0f;
        arrowViewHeight = 5.0f;
        segmentViewHeight = 48.0f;
        [self generateSegmentViewsForSegments];
        [self generateValueView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        _value = nil;
        _unit = nil;
        _segments = nil;
        _valueSegmentIndex = NO_VALUE_SEGMENT_INDEX;
        _distanceBetweenSegments = 3.0f;
        _noSegmentsText = @"Empty";
        _noSegmentsBackgroundColor = [UIColor lightGrayColor];
        balloonViewHeight = 32.0f;
        balloonViewWidth = 72.0f;
        arrowViewHeight = 5.0f;
        segmentViewHeight = 48.0f;
        [self generateSegmentViewsForSegments];
        [self generateValueView];
    }
    return self;
}

- (NSInteger)segmentIndexForValue:(NSNumber *)value {
    NSInteger currentIndex = 0;
    for (GSPDSegmentedBarSegment *segment in self.segments) {
        if (([value compare:segment.minValue] == NSOrderedDescending || ([value compare:segment.minValue] == NSOrderedSame && segment.containsMinValue)) && ([value compare:segment.maxValue] == NSOrderedAscending || ([value compare:segment.maxValue] == NSOrderedSame && segment.containsMaxValue))) {
            return currentIndex;
        }
        currentIndex++;
    }
    return NO_VALUE_SEGMENT_INDEX;
}

- (CGFloat)offsetForValue:(NSNumber *)value insideSegmentWithIndex:(NSInteger)index withWidth:(CGFloat)width {
    GSPDSegmentedBarSegment *segment = [self.segments objectAtIndex:index];
    if (![segment isPoint]) {
        return width * ((value.doubleValue - segment.minValue.doubleValue) / (segment.maxValue.doubleValue - segment.minValue.doubleValue));
    } else {
        return width / 2;
    }
}

- (void)setSegments:(NSArray *)segments {
    _segments = [segments sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        GSPDSegmentedBarSegment *segment1 = (GSPDSegmentedBarSegment *)obj1;
        GSPDSegmentedBarSegment *segment2 = (GSPDSegmentedBarSegment *)obj2;
        NSComparisonResult result = [segment1.minValue compare:segment2.minValue];
        if (result == NSOrderedSame) {
            if (segment1.containsMinValue) {
                return NSOrderedAscending;
            } else {
                return NSOrderedDescending;
            }
        } else {
            return result;
        }
    }];
    [self generateSegmentViewsForSegments];
    [self generateValueView];
}

- (void)generateSegmentViewsForSegments {
    if (_segmentViews.count > 0) {
        for (GSPDSegmentView *segmentView in _segmentViews) {
            [segmentView removeFromSuperview];
        }
    }
    if (!self.segments || self.segments.count == 0) {
        GSPDSegmentedBarSegment *emptySegment = [[GSPDSegmentedBarSegment alloc] initWithMinValue:@(0.0) maxValue:@(0.0) color:self.noSegmentsBackgroundColor];
        emptySegment.text = self.noSegmentsText;
        GSPDSegmentView *segmentView = [[GSPDSegmentView alloc] initWithSegment:emptySegment angleStyle:GSPDSegmentViewAngleStyleTwoSided];
        [self addSubview:segmentView];
        _segmentViews = @[segmentView];
    } else {
        NSMutableArray *segmentViews = [NSMutableArray arrayWithCapacity:self.segments.count];
        NSUInteger index = 0;
        for (GSPDSegmentedBarSegment *segment in self.segments) {
            GSPDSegmentViewAngleStyle angleStyle;
            if (index == 0) {
                if (self.segments.count == 1) {
                    angleStyle = GSPDSegmentViewAngleStyleTwoSided;
                } else {
                    angleStyle = GSPDSegmentViewAngleStyleLeftSided;
                }
            } else {
                if (index < self.segments.count - 1) {
                    angleStyle = GSPDSegmentViewAngleStyleDefault;
                } else {
                    angleStyle = GSPDSegmentViewAngleStyleRightSided;
                }
            }
            GSPDSegmentView *segmentView = [[GSPDSegmentView alloc] initWithSegment:segment angleStyle:angleStyle];
            [self addSubview:segmentView];
            [segmentViews addObject:segmentView];
            index++;
        }
        _segmentViews = segmentViews;
    }
    [self setNeedsLayout];
}

- (void)generateValueView {
    [self.valueView removeFromSuperview];
    self.valueView = [[GSPDBalloonView alloc] initWithFrame:CGRectNull];
    //TODO: add value + unit and customize
    [self addSubview:self.valueView];
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    NSUInteger segmentViewsCount = _segmentViews.count;
    CGFloat segmentViewWidth = (self.frame.size.width - (segmentViewsCount - 1) * self.distanceBetweenSegments) / segmentViewsCount;
    NSUInteger index = 0;
    for (GSPDSegmentView *segmentView in _segmentViews) {
        segmentView.frame = (CGRect){{index * (segmentViewWidth + self.distanceBetweenSegments), balloonViewHeight + arrowViewHeight}, {segmentViewWidth, segmentViewHeight}};
        NSLog(@"%lu : %@", index, NSStringFromCGRect(segmentView.frame));
        index++;
    }
    if (self.valueSegmentIndex != NO_VALUE_SEGMENT_INDEX) {
        self.valueView.arrowEnabled = YES;
        self.valueView.frame = (CGRect){{self.valueSegmentIndex * (segmentViewWidth + self.distanceBetweenSegments) + segmentViewWidth / 2 - balloonViewWidth / 2, 0}, {balloonViewWidth, balloonViewHeight + arrowViewHeight}};
    } else {
        NSUInteger segmentIndex = [self segmentIndexForValue:self.value];
        if (segmentIndex == NO_VALUE_SEGMENT_INDEX) {
            self.valueView.arrowEnabled = NO;
            self.valueView.frame = (CGRect){{self.frame.size.width / 2 - balloonViewWidth / 2, 0}, {balloonViewWidth, balloonViewHeight + arrowViewHeight}};
        } else {
            self.valueView.arrowEnabled = YES;
            CGFloat offset;
//            CGFloat offset = [self offsetForValue:self.value insideSegmentWithIndex:segmentIndex withWidth:segmentViewWidth];
            GSPDSegmentView *segmentViewForIndex = self.segmentViews[segmentIndex];
            if (segmentIndex == 0) {
                if (self.segments.count == 1) {
                    offset = segmentViewForIndex.angularPartWidth + [self offsetForValue:self.value insideSegmentWithIndex:segmentIndex withWidth:segmentViewWidth - 2 * (segmentViewForIndex.angularPartWidth)];
                } else {
                    offset = segmentViewForIndex.angularPartWidth + [self offsetForValue:self.value insideSegmentWithIndex:segmentIndex withWidth:segmentViewWidth - segmentViewForIndex.angularPartWidth];
                }
            } else {
                if (segmentIndex < self.segments.count - 1) {
                    offset = [self offsetForValue:self.value insideSegmentWithIndex:segmentIndex withWidth:segmentViewWidth];
                } else {
                    offset = [self offsetForValue:self.value insideSegmentWithIndex:segmentIndex withWidth:segmentViewWidth - segmentViewForIndex.angularPartWidth];
                }
            }
            self.valueView.frame = (CGRect){{segmentIndex * (segmentViewWidth + self.distanceBetweenSegments) + offset - balloonViewWidth / 2, 0}, {balloonViewWidth, balloonViewHeight+ arrowViewHeight}};
        }
    }
    NSLog(@"%@", NSStringFromCGRect(self.valueView.frame));
}

- (void)setDistanceBetweenSegments:(CGFloat)distanceBetweenSegments {
    _distanceBetweenSegments = distanceBetweenSegments;
    [self setNeedsLayout];
}

- (void)setNoSegmentsBackgroundColor:(UIColor *)noSegmentsBackgroundColor {
    _noSegmentsBackgroundColor = noSegmentsBackgroundColor;
    if (!self.segments || self.segments.count == 0) {
        [self setNeedsLayout];
    }
}

- (void)setNoSegmentsText:(NSString *)noSegmentsText {
    _noSegmentsText = noSegmentsText;
    if (!self.segments || self.segments.count == 0) {
        [self setNeedsLayout];
    }
}

- (void)setValuesTextColor:(UIColor *)valuesTextColor {
    _valuesTextColor = valuesTextColor;
    for (GSPDSegmentView *segmentView in _segmentViews) {
        segmentView.valuesTextColor = _valuesTextColor;
    }
}

- (void)setValuesFont:(UIFont *)valuesFont {
    _valuesFont = valuesFont;
    for (GSPDSegmentView *segmentView in _segmentViews) {
        segmentView.valuesFont = _valuesFont;
    }
}

- (void)setDescriptionsTextColor:(UIColor *)descriptionsTextColor {
    _descriptionsTextColor = descriptionsTextColor;
    for (GSPDSegmentView *segmentView in _segmentViews) {
        segmentView.descriptionsTextColor = _descriptionsTextColor;
    }
}

- (void)setDescriptionsFont:(UIFont *)descriptionsFont {
    _descriptionsFont = descriptionsFont;
    for (GSPDSegmentView *segmentView in _segmentViews) {
        segmentView.descriptionsFont = _descriptionsFont;
    }
}

@end
