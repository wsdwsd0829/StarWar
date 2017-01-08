//
//  TestCell.h
//  StarWar
//
//  Created by Sida Wang on 1/7/17.
//  Copyright © 2017 Sida Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventViewModel.h"

@interface EventCell : UICollectionViewCell


@property (weak, nonatomic) IBOutlet UILabel* timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;


@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHeight;

@property (nonatomic) EventViewModel* viewModel;
-(void)updateUI;
@end
