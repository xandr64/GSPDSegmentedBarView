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
        _segment = segment;
        _angleStyle = style;
        _valuesTextColor = [UIColor whiteColor];
        _valuesFont = [UIFont systemFontOfSize:11];
        _descriptionsTextColor = [UIColor grayColor];
        _descriptionsFont = [UIFont systemFontOfSize:11];
        _angularPartWidth = 15.0f;
        [self generateLayout];
    }
    return self;
}

- (void)layoutSubviews {
    self.angularView.frame = (CGRect){{0, 0}, {self.frame.size.width, self.frame.size.height / 2}};
    self.valueTextField.frame = (CGRect){{self.angularView.anglularPartWidth, 0}, {self.angularView.frame.size.width - 2 * self.angularView.anglularPartWidth, self.angularView.frame.size.height}};
    if (!_segment.segmentDescription || [_segment.description isEqualToString:@""]) {
        _bottomPadding = self.frame.size.height / 2;
    } else {
        _bottomPadding = 0;
    }
    self.descriptionTextField.frame = (CGRect){{self.angularView.anglularPartWidth, self.frame.size.height / 2}, {self.angularView.frame.size.width - 2 * self.angularView.anglularPartWidth, self.frame.size.height / 2}};
}

- (void)generateLayout {
    self.angularView = [[GSPDAngularView alloc] initWithAngularPartWidth:_angularPartWidth style:(GSPDAngularViewStyle)_angleStyle backgroundColor:_segment.color];
    [self addSubview:self.angularView];
    self.valueTextField = [[UITextField alloc] initWithFrame:CGRectNull];
    self.valueTextField.textAlignment = NSTextAlignmentCenter;
    NSString *valueText;
    if (_segment.text && ![_segment.text isEqualToString:@""]) {
        valueText = _segment.text;
    } else {
        switch (_segment.sideTextStyle) {
            case GSPDSegmentedBarSegmentSideTextStyleOneSided: {
                if (_angleStyle == GSPDSegmentViewAngleStyleLeftSided) {
                    valueText = [NSString stringWithFormat:@"< %@", _segment.maxValue];
                } else if (_angleStyle == GSPDSegmentViewAngleStyleRightSided) {
                    valueText = [NSString stringWithFormat:@"> %@", _segment.minValue];
                } else {
                    valueText = [NSString stringWithFormat:@"%@ - %@", _segment.minValue, _segment.maxValue];
                }
            }
                break;
            case GSPDSegmentedBarSegmentSideTextStyleTwoSided:{
                valueText = [NSString stringWithFormat:@"%@ - %@", _segment.minValue, _segment.maxValue];
            }
                break;
            default:
                break;
        }
    }
    self.valueTextField.text = valueText;
    self.valueTextField.textColor = _valuesTextColor;
    self.valueTextField.font = _valuesFont;
    [self addSubview:self.valueTextField];
    
    self.descriptionTextField = [[UITextField alloc] initWithFrame:CGRectNull];
    self.descriptionTextField.textAlignment = NSTextAlignmentCenter;
    self.descriptionTextField.text = _segment.segmentDescription;
    self.descriptionTextField.textColor = _descriptionsTextColor;
    self.descriptionTextField.font = _descriptionsFont;
    [self addSubview:self.descriptionTextField];
}

- (void)setValuesTextColor:(UIColor *)valuesTextColor {
    _valuesTextColor = valuesTextColor;
    self.valueTextField.textColor = _valuesTextColor;
}

- (void)setValuesFont:(UIFont *)valuesFont {
    _valuesFont = valuesFont;
    self.valueTextField.font = _valuesFont;
}

- (void)setDescriptionsTextColor:(UIColor *)descriptionsTextColor {
    _descriptionsTextColor = descriptionsTextColor;
    self.descriptionTextField.textColor = _descriptionsTextColor;
}

- (void)setDescriptionsFont:(UIFont *)descriptionsFont {
    _descriptionsFont = descriptionsFont;
    self.descriptionTextField.font = _descriptionsFont;
}

- (void)setAngularPartWidth:(CGFloat)angularPartWidth {
    _angularPartWidth = angularPartWidth;
    self.angularView.anglularPartWidth = _angularPartWidth;
}

@end
