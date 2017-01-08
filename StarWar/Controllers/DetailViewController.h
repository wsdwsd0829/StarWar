//
//  DetailViewController.h
//  StarWar
//
//  Created by Sida Wang on 1/7/17.
//  Copyright © 2017 Sida Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventCell.h"
#import "EventsViewModel.h"
#import <SDWebImage/UIImageView+WebCache.h>


@interface DetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel* timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (nonatomic) EventViewModel* viewModel;

-(void)updateUI;
@end
