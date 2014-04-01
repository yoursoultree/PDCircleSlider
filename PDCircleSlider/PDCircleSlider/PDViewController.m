//
//  PDViewController.m
//  PDCircleSlider
//
//  Created by ChenGe on 14-3-30.
//  Copyright (c) 2014年 Panda. All rights reserved.
//

#import "PDViewController.h"
#import "PDCircleSlider/PDCircleSlider.h"

@interface PDViewController ()

@end

@implementation PDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    PDCircleSlider * circleSlider = [[PDCircleSlider alloc] initWithFrame:CGRectMake(0, 0, 200, 200)
                                                   progressDidChangeBlock:^(CGFloat progress) {
                                                       NSLog(@"%f", progress);
                                                   }
                                                                    start:0.2
                                                                clockwise:YES];
    circleSlider.center = CGPointMake(160, 220);
//    circleSlider.buttonColor = [UIColor redColor];
    [self.view addSubview:circleSlider];
    
}


@end
