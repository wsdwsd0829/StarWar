//
//  DetailViewController.m
//  StarWar
//
//  Created by Sida Wang on 1/7/17.
//  Copyright © 2017 Sida Wang. All rights reserved.
//

#import "DetailViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    
    [self updateUI];
}

-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)updateUI {
    self.timeLabel.text = [self.viewModel timeLabel];
    self.titleLabel.text = [self.viewModel title]; //@"rand coej cokskjc oiecj eoijco oidc japei cajdopcjaopjjeojpoc oejcoaijc  pjqoij cdosj cj";
    self.locationLabel.text = [self.viewModel location];
    self.descLabel.text = [self.viewModel desc];
    
    NSString* imageUrl = [self.viewModel imageUrl];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.layer.masksToBounds=YES;
    if(![imageUrl isEqual: [NSNull null]]) {
        [self.imageView sd_setImageWithURL:[NSURL URLWithString: imageUrl] placeholderImage:[UIImage imageNamed:@"placeholder_nomoon"]];
        
        CAGradientLayer *gradientMask = [CAGradientLayer layer];
        CGRect newFrame = [UIScreen mainScreen].bounds;
        newFrame.size.height = self.imageView.bounds.size.height;
        gradientMask.frame = newFrame;
        gradientMask.colors = @[(id)[UIColor whiteColor].CGColor,
                                (id)[UIColor clearColor].CGColor];
        self.imageView.layer.mask = gradientMask;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
