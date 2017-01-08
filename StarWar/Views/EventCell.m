//
//  TestCell.m
//  StarWar
//
//  Created by Sida Wang on 1/7/17.
//  Copyright © 2017 Sida Wang. All rights reserved.
//

#import "EventCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface EventCell()
@end
@implementation EventCell

-(void)updateUI {
    self.timeLabel.text = [self.viewModel timeLabel];
    self.titleLabel.text = [self.viewModel title]; //@"rand coej cokskjc oiecj eoijco oidc japei cajdopcjaopjjeojpoc oejcoaijc  pjqoij cdosj cj";
    self.locationLabel.text = [self.viewModel location];
    self.descLabel.text = [self.viewModel desc];
}

/*
-(UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    UICollectionViewLayoutAttributes* attr = [[super preferredLayoutAttributesFittingAttributes:layoutAttributes] copy];
    [self setNeedsLayout];
    [self layoutIfNeeded];
    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
         self.contentWidth.constant = [UIScreen mainScreen].bounds.size.width;
    } else {
        self.contentWidth.constant = [UIScreen mainScreen].bounds.size.width-10/2;
    }
    //self.contentWidth.constant = 300;
    CGRect oldFrame = attr.frame;
    oldFrame.size.width = self.contentWidth.constant;
    //CGSize sizeFits = [self sizeThatFits:oldFrame.size];
    CGSize size = [self systemLayoutSizeFittingSize:oldFrame.size];
    CGRect newFrame = attr.frame;
    newFrame.size.height = size.height;
    attr.frame = newFrame;
    
    self.imageHeight.constant = size.height;
    self.imageWidth.constant = self.contentWidth.constant;
    return attr;
}
*/

@end
