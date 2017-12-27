//
//  LoginPopView.h
//  CasualShop
//
//  Created by Liwp on 2017/12/26.
//  Copyright © 2017年 Liwp. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SuccesBlock)(void);
typedef void(^FailBlock)(void);

@interface LoginPopView : UIView
//动画时间默认0.4秒
@property (nonatomic ,assign)float animationDuring;

+ (instancetype)shareView;

- (void)showLoginPopSuccessWith:(SuccesBlock)success fail:(FailBlock)fail;

@end
