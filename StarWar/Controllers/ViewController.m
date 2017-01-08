//
//  ViewController.m
//  TemplateProject
//
//  Created by Sida Wang on 12/31/16.
//  Copyright © 2016 Sida Wang. All rights reserved.
//

#import "ViewController.h"
#import "EventCell.h"
#import "EventsViewModel.h"
#import "DetailViewController.h"
#import "Utils+DDHUI.h"
#import <SDWebImage/UIImageView+WebCache.h>

NSString* const EventCellIdentifier = @"EventCell";
NSString* const NavigationDetailViewControllerIdentifier = @"NavigationDetailViewController";

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic) UICollectionViewFlowLayout* layout;
@property (nonatomic) EventsViewModel* viewModel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel = [EventsViewModel new];
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
    UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:EventCellIdentifier forIndexPath:indexPath];
    [self configCell:cell forIndexPath:indexPath];
        return cell;
}
-(void)configCell:(UICollectionViewCell*) cell forIndexPath: (NSIndexPath*) indexPath {
    if([cell isKindOfClass:[EventCell class]]) {
        EventCell* eventCell = (EventCell*) cell;
        eventCell.viewModel = self.viewModel.items[indexPath.row];
        [eventCell updateUI];
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UINavigationController* nvc = [Utils viewControllerWithIdentifier:NavigationDetailViewControllerIdentifier fromStoryBoardNamed:@"Main"];
    DetailViewController* dvc = ((DetailViewController*)(nvc.topViewController));
    dvc.viewModel = self.viewModel.items[indexPath.row];
    //dvc.edgesForExtendedLayout = UIRectEdgeNone;
    [self presentViewController:nvc animated:YES completion:^{
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
