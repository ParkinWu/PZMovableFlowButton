//
//  ViewController.m
//  PZMovableFlowButton
//
//  Created by pzwu on 16/3/10.
//  Copyright © 2016年 pzwu. All rights reserved.
//

#import "ViewController.h"
#import "PZMoveableFlowButton.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    PZMoveableFlowButton * btn = [[PZMoveableFlowButton alloc] initWithFrame:CGRectMake(0, 64, 62, 62) AndBoundary:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)) onView:self.view contentImage:[UIImage imageNamed:@"123.JPG"] clickedHandler:^(PZMoveableFlowButton *btn) {
        NSLog(@"clicked");
    }];
    btn.layer.cornerRadius = 4;
    btn.layer.masksToBounds = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
