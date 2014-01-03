//
//  SRFBubbleView.m
//  Stuff
//
//  Created by Will Barksdale on 1/2/14.
//  Copyright (c) 2014 CollectionView. All rights reserved.
//

#import "SRFBubbleView.h"
#import "WFBAutoLayout.h"

@interface SRFBubbleView()

@property(nonatomic, strong) UILabel *textLabel;
@property(nonatomic, strong) UILabel *sizingLabel;
@property(nonatomic, strong) NSLayoutConstraint *maxWidthConstraint;

@end

@implementation SRFBubbleView

static const CGFloat DefaultMaxWidth = 120.0f;
static const CGFloat TriangleWidth = 8.0f;
static const CGFloat TriangleHeight = 5.0f;
static const CGFloat BubbleTextPadding = 10.0f;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    _sizingLabel = [[UILabel alloc] init];
    [_sizingLabel setFont:[UIFont fontWithName:@"Futura" size:16.0f]];
    [_sizingLabel setNumberOfLines:0];
    
    _textLabel = [[UILabel alloc] init];
    [_textLabel setBackgroundColor:[UIColor redColor]];
    [_textLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_textLabel setFont:[UIFont fontWithName:@"Futura" size:16.0f]];
    [_textLabel setNumberOfLines:0];
    
    [self addSubview:_textLabel];
    
    [self addConstraints:[self textLabelConstraints]];
    
}

- (NSArray *)textLabelConstraints {
    NSLayoutConstraint *top = [WFBAutoLayout matchTopEdge:self.textLabel to:self plusOffset:BubbleTextPadding];
    NSLayoutConstraint *bottom = [WFBAutoLayout matchBotttomEdge:self.textLabel to:self plusOffset:-BubbleTextPadding];
    NSLayoutConstraint *left = [WFBAutoLayout matchLeftEdge:self.textLabel to:self plusOffset:BubbleTextPadding + TriangleWidth];
    NSLayoutConstraint *right = [WFBAutoLayout matchRightEdge:self.textLabel to:self plusOffset:-BubbleTextPadding];
    return @[top, left, right, bottom];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    UIBezierPath *bubblePath = [[self class] bubblePathForImageSize:self.bounds.size];
    CAShapeLayer *bubbleShape = [CAShapeLayer layer];
    bubbleShape.path = bubblePath.CGPath;
    self.layer.mask = bubbleShape;
}

- (void)setBubbleText:(NSString *)text {
    self.textLabel.text = text;
    
    [self invalidateIntrinsicContentSize];
    [self setNeedsLayout];
    [self setNeedsDisplay];
}

- (CGSize)intrinsicContentSize {
    CGSize labelSize = [self.sizingLabel intrinsicContentSize];
    labelSize.height += BubbleTextPadding * 2;
    labelSize.width += BubbleTextPadding * 2 + TriangleWidth;
    return labelSize;
}

+ (UIBezierPath *)bubblePathForImageSize:(CGSize)imageSize {
    
    CGFloat cornerRadius = 5.71;
    CGFloat edgePadding = 2 * cornerRadius;
    CGFloat triangleWidth = TriangleWidth;
    CGFloat triangleHeight = TriangleHeight;
    
    CGFloat bottomEdge = imageSize.height;
    CGFloat rightEdge = imageSize.width;
    CGFloat leftEdge = triangleWidth;
    CGFloat topEdge = 0;
    
    //// chatBubble Drawing
    UIBezierPath* chatBubblePath = [UIBezierPath bezierPath];
    [chatBubblePath moveToPoint: CGPointMake(rightEdge, edgePadding)];
    [chatBubblePath addLineToPoint: CGPointMake(rightEdge, bottomEdge - edgePadding)];
    
    // bottom right corner
    [chatBubblePath addCurveToPoint: CGPointMake(rightEdge - edgePadding, bottomEdge)
                      controlPoint1: CGPointMake(rightEdge, bottomEdge - cornerRadius)
                      controlPoint2: CGPointMake(rightEdge - cornerRadius, bottomEdge)];
    
    
    [chatBubblePath addLineToPoint: CGPointMake(leftEdge + edgePadding, bottomEdge)];
    
    // bottom left corner
    [chatBubblePath addCurveToPoint: CGPointMake(leftEdge, bottomEdge - edgePadding)
                      controlPoint1: CGPointMake(leftEdge + cornerRadius, bottomEdge)
                      controlPoint2: CGPointMake(leftEdge, bottomEdge - cornerRadius)];
    
    // triangle
    [chatBubblePath addLineToPoint: CGPointMake(leftEdge, topEdge + edgePadding + triangleHeight)];
    [chatBubblePath addLineToPoint: CGPointMake(0, topEdge + edgePadding)];
    [chatBubblePath addLineToPoint: CGPointMake(leftEdge, topEdge + edgePadding)];
    
    //top left corner
    [chatBubblePath addCurveToPoint: CGPointMake(leftEdge + edgePadding, topEdge)
                      controlPoint1: CGPointMake(leftEdge, topEdge + cornerRadius)
                      controlPoint2: CGPointMake(leftEdge + cornerRadius, topEdge)];
    
    [chatBubblePath addLineToPoint: CGPointMake(rightEdge - edgePadding, topEdge)];
    
    // top right corner
    [chatBubblePath addCurveToPoint: CGPointMake(rightEdge, topEdge + edgePadding)
                      controlPoint1: CGPointMake(rightEdge - cornerRadius, topEdge)
                      controlPoint2: CGPointMake(rightEdge, topEdge + cornerRadius)];
    
    [chatBubblePath closePath];
    
    return chatBubblePath;
}

@end
