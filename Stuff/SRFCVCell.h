//
//  SRFCVCell.h
//  Stuff
//
//  Created by Will Barksdale on 12/31/13.
//  Copyright (c) 2013 CollectionView. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ZRAvatarPosition) {
    ZRAvatarPositionLeft,
    ZRAvatarPositionRight
};

@interface SRFCVCell : UICollectionViewCell

@property(nonatomic) ZRAvatarPosition avatarPosition;

- (void)setAvatarImage:(UIImage *)avatar;
- (void)setTheText:(NSString *)text;
- (void)setTheCaption:(NSString *)caption;

@end
