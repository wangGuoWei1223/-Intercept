//
//  ViewController.m
//  图片截取
//
//  Created by niuwan on 16/7/24.
//  Copyright © 2016年 niuwan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@property (nonatomic, assign) CGPoint startP;

@property (nonatomic, weak) UIView *clipView;

@end

@implementation ViewController

- (UIView *)clipView {
    
    if (!_clipView) {
        UIView *view = [UIView new];
        
        _clipView = view;
        
        view.backgroundColor = [UIColor blackColor];
        view.alpha = 0.5;
        
        [self.view addSubview:view];
    }
    return _clipView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    
    
    [self.view addGestureRecognizer:pan];
    
}

- (void)pan:(UIPanGestureRecognizer *)pan {
    
    CGPoint endP = CGPointZero;
    if (pan.state == UIGestureRecognizerStateBegan) {
        
        _startP = [pan locationInView:self.view];
        
    }else if (pan.state == UIGestureRecognizerStateChanged) {
    
        endP = [pan locationInView:self.view];
        
        CGFloat w = endP.x - _startP.x;
        CGFloat h = endP.y - _startP.y;
        
        CGRect frame = CGRectMake(_startP.x, _startP.y, w, h);
        
        self.clipView.frame = frame;
        
    }else if (pan.state == UIGestureRecognizerStateEnded) {
    
        UIGraphicsBeginImageContextWithOptions(self.imageV.bounds.size, NO, 0);
        
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.clipView.frame];
        
        [path addClip];
        
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        
        [self.imageV.layer renderInContext:ctx];
        
        self.imageV.image = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        [self.clipView removeFromSuperview];
        
        self.clipView = nil;
        
    
    }


}



@end
