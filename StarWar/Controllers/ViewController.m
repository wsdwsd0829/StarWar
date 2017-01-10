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
#import "OpenPageAnimator.h"

NSString* const EventCellIdentifier = @"EventCell";
NSString* const DetailViewControllerIdentifier = @"DetailViewController";

@interface ViewController () <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource,  UINavigationControllerDelegate, OpenSourceProtocol>

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
    self.navigationController.delegate = self;
    self.view.backgroundColor = [UIColor whiteColor];
    //self.layout.estimatedItemSize = CGSizeMake(10, 10);
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
        eventCell.imageView.contentMode = UIViewContentModeScaleAspectFill;
        eventCell.imageView.layer.masksToBounds=YES;
        eventCell.clipsToBounds = YES;
        eventCell.viewModel = self.viewModel.items[indexPath.row];
        if(![eventCell.viewModel.imageUrl isEqual: [NSNull null]]) {
            [eventCell.imageView sd_setImageWithURL:[NSURL URLWithString: eventCell.viewModel.imageUrl] placeholderImage:[UIImage imageNamed:@"placeholder_nomoon"]];
        } else {
            eventCell.imageView.image = [UIImage imageNamed:@"placeholder_nomoon"];
        }
        [eventCell updateUI];
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell* cell = [collectionView cellForItemAtIndexPath:indexPath];
    self.fromFrame = [self.view convertRect:cell.frame fromView:self.collectionView];
    DetailViewController* dvc = [Utils viewControllerWithIdentifier:DetailViewControllerIdentifier fromStoryBoardNamed:@"Main"];
    dvc.viewModel = self.viewModel.items[indexPath.row];
    //dvc.edgesForExtendedLayout = UIRectEdgeTop;
    [self presentViewController:dvc animated:YES completion:^{
    }];
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        return CGSizeMake(self.collectionView.bounds.size.width, 250);
    } else {
        return CGSizeMake(self.collectionView.bounds.size.width/2, 250);
    }
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [self.collectionView.collectionViewLayout invalidateLayout];
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
    } completion:nil];
}

-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if([toVC isKindOfClass: [DetailViewController class]]) {
        OpenPageAnimator* opa = [[OpenPageAnimator alloc] init];
        opa.delegate = (id<OpenSourceProtocol>)(UINavigationController*)fromVC;//
        opa.presenting = YES;
        return opa;
    }
    return nil;
}



@end
