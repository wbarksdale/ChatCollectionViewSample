//
//  SRFCVCell.m
//  Stuff
//
//  Created by Will Barksdale on 12/31/13.
//  Copyright (c) 2013 CollectionView. All rights reserved.
//

#import "SRFCVCell.h"
#import "SRFBubbleView.h"
#import "WFBAutoLayout.h"

@interface SRFCVCell()

@property(nonatomic, strong) UIImageView *avatarImageLeft;
@property(nonatomic, strong) SRFBubbleView *textBubbleLeft;
@property(nonatomic, strong) UILabel *captionLabelLeft;

@property(nonatomic, strong) UIImageView *avatarImageRight;
@property(nonatomic, strong) SRFBubbleView *textBubbleRight;
@property(nonatomic, strong) UILabel *captionLabelRight;

@end

@implementation SRFCVCell



/********************************************************************************
 * Static Constant Declarations
 */

static const CGFloat AvatarTopPadding = 10.f;
static const CGFloat CellBottomPadding = 10.0f;
static const CGFloat AvatarLeftPadding = 10.f;
static const CGFloat AvatarSize = 50.f;
static const CGFloat TextPaddingBetweenAvatar = 10.0f;
static const CGFloat TextPaddingToScreenEdge = 20.0f;
static const CGFloat TextMaxWidth = 150.0f;




/********************************************************************************
 * Initialization
 */

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.backgroundColor = [UIColor yellowColor];
    
    
    //////////////////////////////////////////////////////////////////////
    // Allocate and layout the subviews for avatar position left
    
    _textBubbleLeft = [[SRFBubbleView alloc] init];
    _captionLabelLeft = [[UILabel alloc] init];
    _avatarImageLeft = [[UIImageView alloc] init];
    _textBubbleRight = [[SRFBubbleView alloc] init];
    _captionLabelRight = [[UILabel alloc] init];
    _avatarImageRight = [[UIImageView alloc] init];
    
    _avatarPosition = ZRAvatarPositionRight;
    
    for(int i = 0; i < 2; i++){
        if(i == 1){
            _avatarPosition = ZRAvatarPositionLeft;
        }
        [[self currentTextBubble] setTranslatesAutoresizingMaskIntoConstraints:NO];
        [[self currentTextBubble] setMaxWidth:TextMaxWidth];
        
        [[self currentCaptionLabel] setBackgroundColor:[UIColor blueColor]];
        [[self currentCaptionLabel] setTranslatesAutoresizingMaskIntoConstraints:NO];
        [[self currentCaptionLabel] setTextColor:[UIColor whiteColor]];
        [[self currentCaptionLabel] setFont:[UIFont fontWithName:@"Futura" size:11.0f]];
        [[self currentCaptionLabel] setNumberOfLines:0];
        
        [[self currentAvatarImage] setTranslatesAutoresizingMaskIntoConstraints:NO];
    }
    
    
    //////////////////////////////////////////////////////////////////////
    // Setup the view heirarchy
    
    [self addSubview:_avatarImageLeft];
    [self addSubview:_textBubbleLeft];
    [self addSubview:_captionLabelLeft];
    [self addSubview:_avatarImageRight];
    [self addSubview:_textBubbleRight];
    [self addSubview:_captionLabelRight];
    
    
    
    //////////////////////////////////////////////////////////////////////
    // Add autolayout constraints
    [self addConstraints:[self cellConstraints]];
    [self addConstraints:[self avatarImageLeftConstraints]];
    [self addConstraints:[self textLabelLeftConstraints]];
    [self addConstraints:[self captionLabelLeftConstraints]];
    [self addConstraints:[self avatarImageRightConstraints]];
    [self addConstraints:[self textLabelRightConstraints]];
    [self addConstraints:[self captionLabelRightConstraints]];
    
}

- (NSArray *) cellConstraints {
    NSLayoutConstraint *width = [WFBAutoLayout setWidth:self toValue:320.f];
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:self
                                                              attribute:NSLayoutAttributeHeight
                                                              relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                                 toItem:Nil
                                                              attribute:NSLayoutAttributeNotAnAttribute
                                                             multiplier:0
                                                               constant:AvatarSize + AvatarTopPadding + AvatarTopPadding];
    return @[width, height];
}

- (NSArray *) avatarImageLeftConstraints {
    NSLayoutConstraint *top = [WFBAutoLayout matchTopEdge:self.avatarImageLeft to:self plusOffset:AvatarTopPadding];
    NSLayoutConstraint *left = [WFBAutoLayout matchLeftEdge:self.avatarImageLeft to:self plusOffset:AvatarLeftPadding];
    NSLayoutConstraint *width = [WFBAutoLayout setWidth:self.avatarImageLeft toValue:AvatarSize];
    NSLayoutConstraint *height = [WFBAutoLayout setHeight:self.avatarImageLeft toValue:AvatarSize];
    return @[top, left, width, height];
}

- (NSArray *) avatarImageRightConstraints {
    NSLayoutConstraint *top = [WFBAutoLayout matchTopEdge:self.avatarImageRight to:self plusOffset:AvatarTopPadding];
    NSLayoutConstraint *right = [WFBAutoLayout matchRightEdge:self.avatarImageRight to:self plusOffset:-AvatarLeftPadding];
    NSLayoutConstraint *width = [WFBAutoLayout setWidth:self.avatarImageRight toValue:AvatarSize];
    NSLayoutConstraint *height = [WFBAutoLayout setHeight:self.avatarImageLeft toValue:AvatarSize];
    return @[top, right, width, height];
}

- (NSArray *) textLabelLeftConstraints {
    NSLayoutConstraint *top = [WFBAutoLayout matchTopEdge:self.textBubbleLeft to:self.avatarImageLeft plusOffset:0];
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:self.textBubbleLeft
                                                            attribute:NSLayoutAttributeLeft
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self.avatarImageLeft
                                                             attribute:NSLayoutAttributeRight
                                                           multiplier:1.0f
                                                             constant:TextPaddingBetweenAvatar];
    NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:self.textBubbleLeft
                                                             attribute:NSLayoutAttributeRight
                                                             relatedBy:NSLayoutRelationLessThanOrEqual
                                                                toItem:self
                                                             attribute:NSLayoutAttributeRight
                                                            multiplier:1.0f
                                                              constant:-TextPaddingToScreenEdge];
    return @[top, left, right];
}

- (NSArray *) textLabelRightConstraints {
    NSLayoutConstraint *top = [WFBAutoLayout matchTopEdge:self.textBubbleRight to:self.avatarImageRight plusOffset:0];
    
    NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:self.textBubbleRight
                                                            attribute:NSLayoutAttributeRight
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self.avatarImageRight
                                                            attribute:NSLayoutAttributeLeft
                                                           multiplier:1.0f
                                                             constant:-TextPaddingBetweenAvatar];
    
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:self.textBubbleRight
                                                             attribute:NSLayoutAttributeWidth
                                                             relatedBy:NSLayoutRelationLessThanOrEqual
                                                                toItem:Nil
                                                             attribute:NSLayoutAttributeNotAnAttribute
                                                            multiplier:0
                                                              constant:TextMaxWidth];
    return @[top, right, width];
}

- (NSArray *) captionLabelLeftConstraints {
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.captionLabelLeft
                                                           attribute:NSLayoutAttributeTop
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:self.textBubbleLeft
                                                           attribute:NSLayoutAttributeBottom
                                                          multiplier:1.0f
                                                            constant:0];
    
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:self.captionLabelLeft
                                                            attribute:NSLayoutAttributeLeft
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self.textBubbleLeft
                                                            attribute:NSLayoutAttributeLeft
                                                           multiplier:1.0f
                                                             constant:0];
    
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:self.captionLabelLeft
                                                             attribute:NSLayoutAttributeWidth
                                                             relatedBy:NSLayoutRelationLessThanOrEqual
                                                                toItem:nil
                                                             attribute:NSLayoutAttributeNotAnAttribute
                                                            multiplier:0
                                                              constant:TextMaxWidth];
    NSLayoutConstraint *bottom = [WFBAutoLayout matchBotttomEdge:self.captionLabelLeft to:self plusOffset:-CellBottomPadding];
    return @[top, left, width, bottom];
}

- (NSArray *) captionLabelRightConstraints {
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.captionLabelRight
                                                           attribute:NSLayoutAttributeTop
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:self.textBubbleRight
                                                           attribute:NSLayoutAttributeBottom
                                                          multiplier:1.0f
                                                            constant:0];
    
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:self.captionLabelRight
                                                            attribute:NSLayoutAttributeRight
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self.textBubbleRight
                                                            attribute:NSLayoutAttributeRight
                                                           multiplier:1.0f
                                                             constant:0];
    
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:self.captionLabelRight
                                                             attribute:NSLayoutAttributeWidth
                                                             relatedBy:NSLayoutRelationLessThanOrEqual
                                                                toItem:nil
                                                             attribute:NSLayoutAttributeNotAnAttribute
                                                            multiplier:0
                                                              constant:TextMaxWidth];
    return @[top, left, width];
}


/********************************************************************************
 * Override System Methods
 */

- (CGSize) intrinsicContentSize {
    CGSize textSize = [[self currentTextBubble] intrinsicContentSize];
    CGSize captionSize = [[self currentCaptionLabel] intrinsicContentSize];
    CGFloat width = 320.f;
    CGFloat minHeight = AvatarSize + AvatarTopPadding + CellBottomPadding;
    CGFloat currentHeight = AvatarTopPadding + textSize.height + captionSize.height + CellBottomPadding;
    CGFloat height = MAX(minHeight, currentHeight);
    height += 1;
    return CGSizeMake(width, height);
}

- (void)layoutSubviews {
    BOOL hideRightViews = self.avatarPosition == ZRAvatarPositionLeft;
    
    self.avatarImageRight.hidden = hideRightViews;
    self.textBubbleRight.hidden = hideRightViews;
    self.captionLabelRight.hidden = hideRightViews;
    
    self.avatarImageLeft.hidden = !hideRightViews;
    self.textBubbleLeft.hidden = !hideRightViews;
    self.captionLabelLeft.hidden = !hideRightViews;
    
    [super layoutSubviews];
}



/********************************************************************************
 * External Configuration
 */

- (void)setTheText:(NSString *)string {
    [[self currentTextBubble] setBubbleText:string];
    [self invalidateIntrinsicContentSize];
}

- (void)setTheCaption:(NSString *)caption{
    [self currentCaptionLabel].text = caption;
    [self invalidateIntrinsicContentSize];
}

- (void)setAvatarImage:(UIImage *)avatar {
    [self currentAvatarImage].image = avatar;
    [self invalidateIntrinsicContentSize];
}



/********************************************************************************
 * Override accessors
 */

- (UIImageView *)currentAvatarImage {
    if(self.avatarPosition == ZRAvatarPositionLeft){
        return self.avatarImageLeft;
    }
    else {
        return self.avatarImageRight;
    }
}

- (SRFBubbleView *)currentTextBubble {
    if(self.avatarPosition == ZRAvatarPositionLeft){
        return self.textBubbleLeft;
    }
    else {
        return self.textBubbleRight;
    }
}

- (UILabel *)currentCaptionLabel {
    if(self.avatarPosition == ZRAvatarPositionLeft){
        return self.captionLabelLeft;
    }
    else {
        return self.captionLabelRight;
    }
}

@end
