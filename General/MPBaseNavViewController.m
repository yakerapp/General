//
//  MPBaseNavViewController.m
//  General
//
//  Created by yaker on 2017/1/5.
//  Copyright © 2017年 yaker. All rights reserved.
//

#import "MPBaseNavViewController.h"

@interface MPBaseNavViewController ()
@end


@implementation MPBaseNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.interactivePopGestureRecognizer.delegate = (id)self;
}

@end
