//
//  SRFViewController.m
//  Stuff
//
//  Created by Will Barksdale on 12/31/13.
//  Copyright (c) 2013 CollectionView. All rights reserved.
//

#import "SRFViewController.h"
#import "SRFCVCell.h"

@interface SRFViewController ()

@property(nonatomic, strong) NSArray *data;
@property(nonatomic, strong) NSArray *captions;

@property(nonatomic, strong) SRFCVCell *sizingCell;

@end

@implementation SRFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.data = @[@"This text.",
                  @"Is very important text.",
                  @"Please observe this important text.",
                  @"Text.",
                  @"Texty Text."];
    
    self.captions = @[@"This is a small caption",
                      @"captions can be fun",
                      @"if they are used correctly",
                      @"Lol catz"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (SRFCVCell *)sizingCell {
    if(!_sizingCell){
        _sizingCell = [[SRFCVCell alloc] init];
    }
    return _sizingCell;
}

- (void)configureCell:(SRFCVCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    NSString *text = self.data[indexPath.row % self.data.count];
    NSString *caption = self.captions[indexPath.row % self.captions.count];
    
    if(indexPath.row % 2) {
        cell.avatarPosition = ZRAvatarPositionLeft;
        [cell setAvatarImage:[UIImage imageNamed:@"avatar.jpg"]];
    }
    else {
        cell.avatarPosition = ZRAvatarPositionRight;
        [cell setAvatarImage:[UIImage imageNamed:@"avatar2.jpg"]];
    }
    
    [cell setTheText:text];
    [cell setTheCaption:caption];
    
    [cell layoutIfNeeded];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SRFCVCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [self configureCell:cell forIndexPath:indexPath];
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 200;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    [self configureCell:self.sizingCell forIndexPath:indexPath];
    return [self.sizingCell systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
}

@end
