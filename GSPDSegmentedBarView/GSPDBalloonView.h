#import <UIKit/UIKit.h>

@interface GSPDBalloonView : UIView

@property (nonatomic, assign) CGFloat arrowHeight;
@property (nonatomic, assign) CGFloat cornerRadius;
@property (nonatomic, strong) NSAttributedString *attributedText;
@property (nonatomic, strong) UIColor *balloonBackgroundColor;

@end
