//
//  SRFCVCell.m
//  Stuff
//
//  Created by Will Barksdale on 12/31/13.
//  Copyright (c) 2013 CollectionView. All rights reserved.
//

#import "SRFCVCell.h"
@interface SRFCVCell()

@property(nonatomic, strong) UIImageView *avatarImageLeft;
@property(nonatomic, strong) UILabel *textLabelLeft;
@property(nonatomic, strong) UILabel *captionLabelLeft;

@property(nonatomic, strong) UIImageView *avatarImageRight;
@property(nonatomic, strong) UILabel *textLabelRight;
@property(nonatomic, strong) UILabel *captionLabelRight;

@end

@implementation SRFCVCell

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
    
    _textLabelLeft = [[UILabel alloc] init];
    _captionLabelLeft = [[UILabel alloc] init];
    _avatarImageLeft = [[UIImageView alloc] init];
    _textLabelRight = [[UILabel alloc] init];
    _captionLabelRight = [[UILabel alloc] init];
    _avatarImageRight = [[UIImageView alloc] init];
    
    _avatarPosition = ZRAvatarPositionRight;
    
    for(int i = 0; i < 2; i++){
        if(i == 1){
            _avatarPosition = ZRAvatarPositionLeft;
        }
        [[self currentTextLabel] setBackgroundColor:[UIColor redColor]];
        [[self currentTextLabel] setTranslatesAutoresizingMaskIntoConstraints:NO];
        [[self currentTextLabel] setFont:[UIFont fontWithName:@"Futura" size:16.0f]];
        [[self currentTextLabel] setNumberOfLines:0];
        
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
    [self addSubview:_textLabelLeft];
    [self addSubview:_captionLabelLeft];
    [self addSubview:_avatarImageRight];
    [self addSubview:_textLabelRight];
    [self addSubview:_captionLabelRight];
    
    
    
    //////////////////////////////////////////////////////////////////////
    // Add autolayout constraints
    
    [self addConstraints:[self avatarImageLeftConstraints]];
    [self addConstraints:[self textLabelLeftConstraints]];
    [self addConstraints:[self captionLabelLeftConstraints]];
    [self addConstraints:[self avatarImageRightConstraints]];
    [self addConstraints:[self textLabelRightConstraints]];
    [self addConstraints:[self captionLabelRightConstraints]];
    
}

static const CGFloat AvatarTopPadding = 10.f;
static const CGFloat AvatarLeftPadding = 10.f;
static const CGFloat AvatarSize = 50.f;
- (NSArray *) avatarImageLeftConstraints {
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.avatarImageLeft
                                                           attribute:NSLayoutAttributeTop
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:self
                                                           attribute:NSLayoutAttributeTop
                                                          multiplier:1.0f
                                                            constant:AvatarTopPadding];
    
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:self.avatarImageLeft
                                                            attribute:NSLayoutAttributeLeft
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self
                                                            attribute:NSLayoutAttributeLeft
                                                           multiplier:1.0f
                                                             constant:AvatarLeftPadding];
    
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:self.avatarImageLeft
                                                             attribute:NSLayoutAttributeWidth
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:nil
                                                             attribute:NSLayoutAttributeNotAnAttribute
                                                            multiplier:0
                                                              constant:AvatarSize];
    
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:self.avatarImageLeft
                                                              attribute:NSLayoutAttributeHeight
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:nil
                                                              attribute:NSLayoutAttributeNotAnAttribute
                                                             multiplier:0
                                                               constant:AvatarSize];
    
    return @[top, left, width, height];
}

- (NSArray *) avatarImageRightConstraints {
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.avatarImageRight
                                                           attribute:NSLayoutAttributeTop
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:self
                                                           attribute:NSLayoutAttributeTop
                                                          multiplier:1.0f
                                                            constant:AvatarTopPadding];
    
    NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:self.avatarImageRight
                                                            attribute:NSLayoutAttributeRight
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self
                                                            attribute:NSLayoutAttributeRight
                                                           multiplier:1.0f
                                                             constant:-AvatarLeftPadding];
    
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:self.avatarImageRight
                                                             attribute:NSLayoutAttributeWidth
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:nil
                                                             attribute:NSLayoutAttributeNotAnAttribute
                                                            multiplier:0
                                                              constant:AvatarSize];
    
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:self.avatarImageRight
                                                              attribute:NSLayoutAttributeHeight
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:nil
                                                              attribute:NSLayoutAttributeNotAnAttribute
                                                             multiplier:0
                                                               constant:AvatarSize];
    
    return @[top, right, width, height];
}

static const CGFloat TextPaddingBetweenAvatar = 10.0f;
static const CGFloat TextMaxWidth = 150.0f;
- (NSArray *) textLabelLeftConstraints {
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.textLabelLeft
                                                           attribute:NSLayoutAttributeTop
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:self.avatarImageLeft
                                                           attribute:NSLayoutAttributeTop
                                                          multiplier:1.0f
                                                            constant:0];
    
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:self.textLabelLeft
                                                            attribute:NSLayoutAttributeLeft
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self.avatarImageLeft
                                                            attribute:NSLayoutAttributeRight
                                                           multiplier:1.0f
                                                             constant:TextPaddingBetweenAvatar];
    
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:self.textLabelLeft
                                                             attribute:NSLayoutAttributeWidth
                                                             relatedBy:NSLayoutRelationLessThanOrEqual
                                                                toItem:Nil
                                                             attribute:NSLayoutAttributeNotAnAttribute
                                                            multiplier:0
                                                              constant:TextMaxWidth];
    return @[top, left, width];
}
- (NSArray *) textLabelRightConstraints {
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.textLabelRight
                                                           attribute:NSLayoutAttributeTop
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:self.avatarImageRight
                                                           attribute:NSLayoutAttributeTop
                                                          multiplier:1.0f
                                                            constant:0];
    
    NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:self.textLabelRight
                                                            attribute:NSLayoutAttributeRight
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self.avatarImageRight
                                                            attribute:NSLayoutAttributeLeft
                                                           multiplier:1.0f
                                                             constant:-TextPaddingBetweenAvatar];
    
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:self.textLabelRight
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
                                                              toItem:self.textLabelLeft
                                                           attribute:NSLayoutAttributeBottom
                                                          multiplier:1.0f
                                                            constant:0];
    
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:self.captionLabelLeft
                                                            attribute:NSLayoutAttributeLeft
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self.textLabelLeft
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
    return @[top, left, width];
}

- (NSArray *) captionLabelRightConstraints {
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.captionLabelRight
                                                           attribute:NSLayoutAttributeTop
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:self.textLabelRight
                                                           attribute:NSLayoutAttributeBottom
                                                          multiplier:1.0f
                                                            constant:0];
    
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:self.captionLabelRight
                                                            attribute:NSLayoutAttributeRight
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self.textLabelRight
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
    CGSize avatarSize = [self.avatarImageLeft frame].size;
    avatarSize.height += AvatarTopPadding * 2;
    
    CGSize textSize = [self.textLabelLeft intrinsicContentSize];
    CGSize captionSize = [self.captionLabelLeft intrinsicContentSize];
    CGFloat width = 320.f;
    CGFloat height = MAX(textSize.height + captionSize.height, avatarSize.height);
    return CGSizeMake(width, height);
}

- (void)layoutSubviews {
    BOOL hideRightViews = self.avatarPosition == ZRAvatarPositionLeft;
    
    self.avatarImageRight.hidden = hideRightViews;
    self.textLabelRight.hidden = hideRightViews;
    self.captionLabelRight.hidden = hideRightViews;
    
    self.avatarImageLeft.hidden = !hideRightViews;
    self.textLabelLeft.hidden = !hideRightViews;
    self.captionLabelLeft.hidden = !hideRightViews;
    [super layoutSubviews];
}



/********************************************************************************
 * External Configuration
 */

- (void)setTheText:(NSString *)string {
    [self currentTextLabel].text = string;
}

- (void)setTheCaption:(NSString *)caption{
    [self currentCaptionLabel].text = caption;
}

- (void)setAvatarImage:(UIImage *)avatar {
    [self currentAvatarImage].image = avatar;
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

- (UILabel *)currentTextLabel {
    if(self.avatarPosition == ZRAvatarPositionLeft){
        return self.textLabelLeft;
    }
    else {
        return self.textLabelRight;
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
