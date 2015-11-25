//
//  GSPDBalloonView.m
//  GSPDSegmentedBarViewDemo
//
//  Created by Alexander Kiyaykin on 25.11.15.
//  Copyright © 2015 GSPD. All rights reserved.
//

#import "GSPDBalloonView.h"

@interface GSPDBalloonView ()

@property (nonatomic, strong) UITextField *textField;

@end

@implementation GSPDBalloonView {
    CGFloat margin;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        margin = 4.0f;
        self.arrowHeight = 10.0f;
        self.cornerRadius = 5.0f;
        self.balloonBackroundColor = [UIColor greenColor];
        [super setBackgroundColor:[UIColor clearColor]];
        
        self.textField = [[UITextField alloc] initWithFrame:CGRectNull];
        self.textField.text = @"Test text";
        self.textField.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.textField];
        
    }
    return self;
}

- (void)layoutSubviews {
    self.textField.frame = (CGRect){{0, 0}, {self.frame.size.width, self.frame.size.height - _arrowHeight - margin}};
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    CGContextAddPath(context, [self arrowPathForRect:rect]);
    CGContextAddPath(context, [self roundedRectPathForRect:rect]);
    CGContextSetFillColorWithColor(context, self.balloonBackroundColor.CGColor);
    CGContextFillPath(context);
}

- (CGMutablePathRef)arrowPathForRect:(CGRect)rect {
    CGPoint bottomArrowPoint = CGPointMake(CGRectGetMidX(rect), rect.size.height);
    CGPoint leftArrowPoint = CGPointMake(bottomArrowPoint.x - _arrowHeight / 2, bottomArrowPoint.y - _arrowHeight);
    CGPoint rightArrowPoint = CGPointMake(leftArrowPoint.x + _arrowHeight, leftArrowPoint.y);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, leftArrowPoint.x, leftArrowPoint.y);
    CGPathAddLineToPoint(path, NULL, bottomArrowPoint.x, bottomArrowPoint.y);
    CGPathAddLineToPoint(path, NULL, rightArrowPoint.x, rightArrowPoint.y);
    
    return path;
}

- (CGMutablePathRef)roundedRectPathForRect:(CGRect)rect {
    CGRect balloonFrame = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height - _arrowHeight);
    CGFloat maxCornerRadius = (2 * _cornerRadius >= CGRectGetHeight(balloonFrame) || 2 * _cornerRadius >= CGRectGetWidth(balloonFrame)) ? (CGRectGetWidth(balloonFrame) >= CGRectGetHeight(balloonFrame) ? CGRectGetHeight(balloonFrame) / 2 : CGRectGetWidth(balloonFrame) / 2) : _cornerRadius;
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRoundedRect(path, NULL, balloonFrame, maxCornerRadius, maxCornerRadius);
    return path;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    self.balloonBackroundColor = backgroundColor;
}

- (void)setBalloonBackroundColor:(UIColor *)balloonBackroundColor {
    _balloonBackroundColor = balloonBackroundColor;
    [self setNeedsDisplay];
}

- (void)setArrowHeight:(CGFloat)arrowHeight {
    _arrowHeight = arrowHeight;
    [self setNeedsDisplay];
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
    [self setNeedsDisplay];
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    _attributedText = attributedText;
    self.textField.attributedText = _attributedText;
}

@end
