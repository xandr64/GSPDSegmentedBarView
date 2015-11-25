#import "GSPDSegmentedBarView.h"
#import "GSPDSegmentView.h"
#import "GSPDSegmentedBarSegment.h"

static NSInteger const NO_VALUE_SEGMENT_INDEX = -1;

@interface GSPDSegmentedBarView ()

@property (nonatomic, strong) NSArray *segmentViews;

@end

@implementation GSPDSegmentedBarView

- (instancetype)initWithValue:(NSNumber *)value unit:(NSAttributedString *)unit segments:(NSArray *)segments {
    return [self initWithValue:value unit:unit segments:segments valueSegmentIndex:NO_VALUE_SEGMENT_INDEX];
}

- (instancetype)initWithValue:(NSNumber *)value unit:(NSAttributedString *)unit segments:(NSArray *)segments valueSegmentIndex:(NSUInteger)index {
    self = [super init];
    if (self) {
        self.value = value;
        self.unit = unit;
        self.segments = segments;
        self.valueSegmentIndex = index;
        self.distanceBetweenSegments = 3.0f;
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
}

- (void)generateSegmentViewsForSegments {
    if (_segmentViews.count > 0) {
        for (GSPDSegmentView *segmentView in _segmentViews) {
            [segmentView removeFromSuperview];
        }
    }
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
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    NSUInteger segmentViewsCount = _segmentViews.count;
    CGFloat segmentViewWidth = (self.frame.size.width - (segmentViewsCount - 1) * self.distanceBetweenSegments) / segmentViewsCount;
    NSUInteger index = 0;
    for (GSPDSegmentView *segmentView in _segmentViews) {
        segmentView.frame = (CGRect){{index * (segmentViewWidth + self.distanceBetweenSegments), 0}, {segmentViewWidth, self.frame.size.height}};
        index++;
    }
}

- (void)setDistanceBetweenSegments:(CGFloat)distanceBetweenSegments {
    _distanceBetweenSegments = distanceBetweenSegments;
    [self setNeedsLayout];
}

@end
