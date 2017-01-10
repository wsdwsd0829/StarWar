//
//  DetailViewController.m
//  StarWar
//
//  Created by Sida Wang on 1/7/17.
//  Copyright © 2017 Sida Wang. All rights reserved.
//

#import "DetailViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIImage+Helper.h"
#import "OpenPageAnimator.h"
#import "ViewController.h"
@interface DetailViewController () <UIScrollViewDelegate,UIViewControllerTransitioningDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgTop;
@property (nonatomic) CGFloat minHeight;
@property (nonatomic) UIView* dummyTitle;
@property (nonatomic) UIView* dummyNavTitle;


//for  animate
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewToTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHeight;

@property (nonatomic) CGFloat maxProgress;
@property (nonatomic) CGFloat startX;
@property (nonatomic) CGFloat startY;

@property (nonatomic) CGFloat startViewToTop;
@property (nonatomic) CGFloat startImageHeight;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //transparent nav bar
    self.scrollView.delegate = self;
    self.scrollView.alwaysBounceVertical = YES;
    
    self.transitioningDelegate = self;

    [self transparentNavigationBar];
    [self updateUI];
    self.startImageHeight = self.imageHeight.constant;
    self.startViewToTop = self.viewToTop.constant;
    self.navigationBar.topItem.titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    self.dummyNavTitle = self.navigationBar.topItem.titleView;
}

-(void)transparentNavigationBar {
    [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.shadowImage = [UIImage new];
    self.navigationBar.translucent = YES;
}

- (BOOL) prefersStatusBarHidden {
    return YES;
}

-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)share:(id)sender {
   UIActivityViewController* avc = [[UIActivityViewController alloc] initWithActivityItems:@[self.titleLabel.text, self.timeLabel.text, self.imageView.image, self.locationLabel.text] applicationActivities:nil];
    [self presentViewController:avc animated:YES completion:nil];
}

-(IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)updateUI {
    self.timeLabel.text = [self.viewModel timeLabel];
    self.titleLabel.text = [self.viewModel title]; //@"rand coej cokskjc oiecj eoijco oidc japei cajdopcjaopjjeojpoc oejcoaijc  pjqoij cdosj cj";
    self.phoneLabel.text = [self.viewModel phone];
    self.locationLabel.text = [self.viewModel location];
    self.descLabel.text = [self.viewModel desc];
    
    NSString* imageUrl = [self.viewModel imageUrl];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.layer.masksToBounds=YES;
    if(![imageUrl isEqual: [NSNull null]]) {
        [self.imageView sd_setImageWithURL:[NSURL URLWithString: imageUrl] placeholderImage:[UIImage imageNamed:@"placeholder_nomoon"]];
    }
    CAGradientLayer *gradientMask = [CAGradientLayer layer];
    CGRect newFrame = [UIScreen mainScreen].bounds;
    newFrame.size.height = self.imageView.bounds.size.height;
    gradientMask.frame = newFrame;
    gradientMask.colors = @[(id)[UIColor whiteColor].CGColor,
                            (id)[UIColor clearColor].CGColor];
    self.imageView.layer.mask = gradientMask;
    CGFloat width = self.view.bounds.size.width;
    self.minHeight = self.imageView.image.size.height*width/self.imageView.image.size.width;
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CAGradientLayer *gradientMask = [CAGradientLayer layer];
    CGRect newFrame = [UIScreen mainScreen].bounds;
    newFrame.size.height = self.imageView.bounds.size.height;
    gradientMask.frame = newFrame;
    gradientMask.colors = @[(id)[UIColor whiteColor].CGColor,
                            (id)[UIColor clearColor].CGColor];
    self.imageView.layer.mask = gradientMask;

    //NSLog(@"ContentOffset: %f", self.scrollView.contentOffset.y);
    CGFloat insetY = scrollView.contentOffset.y;
    if(scrollView.contentOffset.y < 0) {
        //self.scrollView.contentInset = UIEdgeInsetsMake(insetY, 0, 0, 0);
        CGFloat progress = fabs(insetY) / 200;
        self.imageView.transform = CGAffineTransformConcat(CGAffineTransformMakeTranslation(0, insetY), CGAffineTransformMakeScale(1 + progress, 1 + progress));
    } else {
        CGFloat progress = fabs(insetY) / self.startImageHeight;
        if(insetY < self.minHeight) {
            self.imageHeight.constant = self.startImageHeight*(1-progress);
        } else if(insetY < self.startViewToTop-44) {
            self.imgTop.constant = (self.minHeight-insetY) / 1;
        } else if(self.startViewToTop-insetY <= 44 && self.startViewToTop-insetY > 0){
            self.imageView.alpha = (self.startViewToTop - insetY) / 44;
        }
        CGPoint center = [self.view convertPoint:self.titleLabel.center fromView:self.contentView];
        center.y += insetY;

        if(insetY >= (self.startViewToTop-0.5) && insetY <= (self.startViewToTop+ 0.5)) {
            //titleLabel 's center dertermin max progress
            self.maxProgress = center.y-22; //max y distance to animate
            self.startX = center.x;
            self.startY = center.y;
        }
        if (insetY-self.startViewToTop > 0 && (insetY-self.startViewToTop) < self.maxProgress ) {
            if(!self.dummyTitle) {
                UIView* label = [self.titleLabel snapshotViewAfterScreenUpdates:NO];
                
                label.center = center;
                self.titleLabel.hidden = YES;
                self.dummyTitle = label;
                [self.view addSubview:label];
                NSLog(@"%f %f", self.dummyTitle.center.x, self.dummyTitle.center.y);

            }
            CGFloat maxX = self.scrollView.bounds.size.width/2 - self.startX;
            CGFloat maxY = self.startY - 22;
            CGFloat progress = (insetY-self.startViewToTop)/self.maxProgress;
            CGPoint newCenter = self.dummyTitle.center;
            newCenter.y = self.dummyTitle.center.y - (insetY-self.startViewToTop);
            newCenter.x = self.dummyTitle.center.x + (insetY-self.startViewToTop);
            CGAffineTransform translate = CGAffineTransformTranslate(CGAffineTransformIdentity, maxX*progress, -maxY*progress);
            
            CGAffineTransform scale = CGAffineTransformMakeScale(1 - progress*0.5, 1);
            self.dummyTitle.transform = CGAffineTransformConcat(translate, scale);
            
            CGFloat navColorAlpha = progress;
            UIColor* col = [UIColor colorWithWhite:1 alpha:navColorAlpha];
            UIImage* image = [UIImage imageWithColor:col];
            [self.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
            NSLog(@"progress: %f", progress);
        } else if ((insetY-self.startViewToTop) <= 0) {
            [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        } else if ((insetY-self.startViewToTop) > self.maxProgress) {
            UIColor* col = [UIColor colorWithWhite:1 alpha:1];
            UIImage* image = [UIImage imageWithColor:col];
            [self.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
        }
        if(insetY < self.startViewToTop) {
            self.titleLabel.hidden = NO;
            if(self.dummyTitle) {
                [self.dummyTitle removeFromSuperview];
                self.dummyTitle = nil;
            }
        }
    }
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    if([presented isKindOfClass:[DetailViewController class]]) {
        OpenPageAnimator* opa = [[OpenPageAnimator alloc] init];
        opa.presenting = YES;
        opa.delegate = (id<OpenSourceProtocol>)[(UINavigationController*)presenting topViewController];
        return opa;
    }else {
        return nil;
    }
}


@end
