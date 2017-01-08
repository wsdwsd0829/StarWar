//
//  OpenPageAnimator.m
//
//  Created by Sida Wang on 12/31/16.
//  Copyright © 2016 Sida Wang. All rights reserved.
//

#import "OpenPageAnimator.h"
#import "ViewController.h"
@implementation OpenPageAnimator

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 1;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    //common
    UIViewController* toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    ViewController* fromVC = ((ViewController*)[((UINavigationController*)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey]) topViewController]);
    
    UIView* containerView = [transitionContext containerView];
    UIView* toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView* fromView = fromVC.collectionView;
    fromView.alpha = 1;
    CGRect toViewFinalFrame = [transitionContext finalFrameForViewController:toVC];
    
   
    if(self.presenting) {
        CGRect fromFrame = self.delegate.fromFrame;
        fromFrame.origin.x = fromView.frame.origin.x;
        toView.frame = fromFrame;
    }
    [containerView addSubview:toView];

    if(toView.frame.origin.y < 66) {
        //cross disslove;
        toView.frame = toViewFinalFrame;
        toView.alpha = 0;
        [UIView animateWithDuration: [self transitionDuration:transitionContext] animations:^{
            fromView.alpha = 0;
            toView.alpha = 1;
        } completion:^(BOOL finished) {
            fromView.alpha = 1;
            [transitionContext completeTransition:YES];
        }];
    } else {
        CGRect adjustFrame = toView.frame; //???
        adjustFrame.origin.y -= 20;
        toView.frame = adjustFrame;
        [UIView animateKeyframesWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
            [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.5 animations:^{
                fromView.alpha = 0;
            }];
            [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.5 animations:^{

                toView.frame = toViewFinalFrame;
            }];
        } completion:^(BOOL finished) {
            fromView.alpha = 1;
            [transitionContext completeTransition:YES];
        }];
    }

}

@end
