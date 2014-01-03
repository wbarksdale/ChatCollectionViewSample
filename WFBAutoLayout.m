//
//  WFBAutoLayout.m
//  Stuff
//
//  Created by Will Barksdale on 1/3/14.
//  Copyright (c) 2014 CollectionView. All rights reserved.
//

#import "WFBAutoLayout.h"

@implementation WFBAutoLayout

+ (NSLayoutConstraint *)matchLeftEdge:(UIView *)view1 to:(UIView *)view2 plusOffset:(CGFloat)offset{
    return [self matchAttribute:NSLayoutAttributeLeft withView:view1 andView:view2 plusOffset:offset];
}
+ (NSLayoutConstraint *)matchRightEdge:(UIView *)view1 to:(UIView *)view2 plusOffset:(CGFloat)offset{
    return [self matchAttribute:NSLayoutAttributeRight withView:view1 andView:view2 plusOffset:offset];
}
+ (NSLayoutConstraint *)matchTopEdge:(UIView *)view1 to:(UIView *)view2 plusOffset:(CGFloat)offset{
    return [self matchAttribute:NSLayoutAttributeTop withView:view1 andView:view2 plusOffset:offset];
}
+ (NSLayoutConstraint *)matchBotttomEdge:(UIView *)view1 to:(UIView *)view2 plusOffset:(CGFloat)offset{
    return [self matchAttribute:NSLayoutAttributeBottom withView:view1 andView:view2 plusOffset:offset];
}
+ (NSLayoutConstraint *)matchAttribute:(NSLayoutAttribute)attribute withView:(UIView *)view1 andView:(UIView *)view2 plusOffset:(CGFloat)offset{
    return [NSLayoutConstraint constraintWithItem:view1
                                        attribute:attribute
                                        relatedBy:NSLayoutRelationEqual
                                           toItem:view2
                                        attribute:attribute
                                       multiplier:1.0f
                                         constant:offset];
}


+ (NSLayoutConstraint *)setWidth:(UIView *)view1 toValue:(CGFloat)width{
    return [NSLayoutConstraint constraintWithItem:view1
                                        attribute:NSLayoutAttributeWidth
                                        relatedBy:NSLayoutRelationEqual
                                           toItem:nil
                                        attribute:NSLayoutAttributeNotAnAttribute
                                       multiplier:0
                                         constant:width];
}

+ (NSLayoutConstraint *)setHeight:(UIView *)view1 toValue:(CGFloat)height{
    return [NSLayoutConstraint constraintWithItem:view1
                                        attribute:NSLayoutAttributeHeight
                                        relatedBy:NSLayoutRelationEqual
                                           toItem:nil
                                        attribute:NSLayoutAttributeNotAnAttribute
                                       multiplier:0
                                         constant:height];
}

@end
