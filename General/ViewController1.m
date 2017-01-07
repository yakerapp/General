//
//  ViewController1.m
//  General
//
//  Created by yaker on 2017/1/5.
//  Copyright © 2017年 yaker. All rights reserved.
//

#import "ViewController1.h"

@interface ViewController1 ()

@end

@implementation ViewController1

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 44, 44);
    [backButton setTitle:@"首页" forState:0];
    [backButton setTitleColor:[UIColor redColor] forState:0];
    [backButton addTarget:self action:@selector(backBtn) forControlEvents:UIControlEventTouchUpInside];
    //对按钮的个性化设定
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    UIBarButtonItem * spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    //将宽度设为负值
    spaceItem.width = -10;
    self.navigationItem.leftBarButtonItems = @[spaceItem,barItem];
//    self.navigationItem.backBarButtonItem = barItem; //不影响侧滑手势
    // Do any additional setup after loading the view.
    
    UILabel *laebl = [[UILabel alloc]init];
    laebl.text = @"godosjdkfkdjfkjdjfidjfidj difjdifjdkjf kdfjkdfjdifdkfjk dfjdkijfkkd lsdkfj sldkfjdk lsdkfhu dfjdk jdfkjs jsdkjfhhhh ksidujfhdj ";
}

- (void)backBtn{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
