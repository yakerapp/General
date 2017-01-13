//
//  MKAlertView.h
//  General
//
//  Created by yaker on 2017/1/12.
//  Copyright © 2017年 yaker. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^alerViewButtonIndex)(int index);

@interface MKAlertView : UIView

- (void)alertWithTitle:(NSString*)title andImage:(UIImage*)image andButtons:(NSArray*)btnTitles andColor:(UIColor*)color buttonIndex:(alerViewButtonIndex)block;

@property (copy,nonatomic) alerViewButtonIndex block;

@end
