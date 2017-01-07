//
//  ViewController.m
//  TemplateProject
//
//  Created by Sida Wang on 12/31/16.
//  Copyright © 2016 Sida Wang. All rights reserved.
//

#import "ViewController.h"
#import "NetworkService.h"
#import "EventCell.h"
#import "EventsViewModel.h"
#import <SDWebImage/UIImageView+WebCache.h>


NSString* const EventCellIdentifier = @"EventCell";

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic) UICollectionViewFlowLayout* layout;
@property (nonatomic) EventsViewModel* viewModel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel = [EventsViewModel new];

   //[self.collectionView registerClass: [EventCell class] forCellWithReuseIdentifier:EventCellIdentifier];
    [self.collectionView registerNib: [UINib nibWithNibName:@"EventCell" bundle:nil] forCellWithReuseIdentifier:EventCellIdentifier];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.layout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView.collectionViewLayout = self.layout;
    
    [self.viewModel loadDataWithHandler:^(NSArray *items, NSError *err) {
        [self.collectionView reloadData];
    }];
    self.layout.estimatedItemSize = CGSizeMake(10, 10);
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.viewModel.items.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
   EventCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:EventCellIdentifier forIndexPath:indexPath];
    cell.timeLabel.text = [self.viewModel timeLabelForIndex:indexPath.row];
    cell.titleLabel.text = [self.viewModel titleForIndex:indexPath.row];
    cell.locationLabel.text = [self.viewModel locationForIndex:indexPath.row];
    cell.descLabel.text = [self.viewModel descForIndex:indexPath.row];
    NSString* imageUrl = [self.viewModel imageUrlForIndex:indexPath.row];
    NSLog(@"%f", cell.imageView.frame.size.height);
    cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
    cell.imageView.layer.masksToBounds=YES;
    
    if(![imageUrl isEqual: [NSNull null]]) {
//         [self.viewModel loadImageForIndexPath:indexPath withHandler:^(UIImage *image) {
//             cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
//             cell.imageView.layer.masksToBounds=YES;
//            cell.imageView.image = image;
//        }];
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString: imageUrl] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    }
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
