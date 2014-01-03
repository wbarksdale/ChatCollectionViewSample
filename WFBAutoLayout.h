//
//  WFBAutoLayout.h
//  Stuff
//
//  Created by Will Barksdale on 1/3/14.
//  Copyright (c) 2014 CollectionView. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WFBAutoLayout : NSObject

+ (NSLayoutConstraint *)matchLeftEdge:(UIView *)view1 to:(UIView *)view2 plusOffset:(CGFloat)offset;
+ (NSLayoutConstraint *)matchRightEdge:(UIView *)view1 to:(UIView *)view2 plusOffset:(CGFloat)offset;
+ (NSLayoutConstraint *)matchTopEdge:(UIView *)view1 to:(UIView *)view2 plusOffset:(CGFloat)offset;
+ (NSLayoutConstraint *)matchBotttomEdge:(UIView *)view1 to:(UIView *)view2 plusOffset:(CGFloat)offset;

+ (NSLayoutConstraint *)setWidth:(UIView *)view1 toValue:(CGFloat)width;
+ (NSLayoutConstraint *)setHeight:(UIView *)view1 toValue:(CGFloat)height;

@end
