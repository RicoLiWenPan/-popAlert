//
//  LoginPopView.m
//  CasualShop
//
//  Created by Liwp on 2017/12/26.
//  Copyright © 2017年 Liwp. All rights reserved.
//

#import "LoginPopView.h"

#define heightLogin 320*kScreen_W_Scale
@interface LoginPopView()

@property (copy, nonatomic) SuccesBlock succesBlock;
@property (copy, nonatomic) FailBlock failBlock;
@property (assign ,nonatomic) CGFloat scale;

@property (nonatomic, strong) UIWindow *loginWindow;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIScrollView *scrollView;
@end;

@implementation LoginPopView

static LoginPopView *loginView;

+ (instancetype)shareView{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        loginView = [[self alloc] init];
        
    });
    return loginView;
}

- (instancetype)init {
    if (self = [super init]) {
        
        self.frame = [[UIScreen mainScreen] bounds];
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        self.animationDuring = 0.4;
    }
    return self;
}

- (void)showLoginPopSuccessWith:(SuccesBlock)success fail:(FailBlock)fail{
    
    _succesBlock = success;
    _failBlock = fail;
    [self creatView];
    [self showPopView];
}

#pragma mark- event
- (void)showPopView{
    
    
    [UIView animateWithDuration:_animationDuring animations:^{
        
       self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.4];

        [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(kScreenHeight - heightLogin);
            make.size.mas_equalTo(CGSizeMake(kScreenWidth, heightLogin));
        }];
        [self layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        
    }];
    
}
- (void)disMissPopView{
    
    [UIView animateWithDuration:_animationDuring animations:^{
        
        self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
        
        [_bgView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(kScreenHeight);
            make.size.mas_equalTo(CGSizeMake(kScreenWidth, heightLogin));
        }];
        [self layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        self.loginWindow.hidden = YES;
        [self.loginWindow resignKeyWindow];
        [self clear];
        
    }];
    
}
- (void)clear{
    _failBlock();
}

#pragma mark- creatView

- (void)creatView{
    
    [self.loginWindow makeKeyAndVisible];
    [self.loginWindow addSubview:self];
    [self addSubview:self.scrollView];
    [self.scrollView addSubview:self.bgView];
    
    UITapGestureRecognizer *tapdis = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(disMissPopView)];
    [self.scrollView addGestureRecognizer:tapdis];
    
    UITapGestureRecognizer *tapvoid = [[UITapGestureRecognizer alloc]init];
    [self.bgView addGestureRecognizer:tapvoid];
    
    [self layoutView];
    
}
- (void)layoutView{
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.window);
    }];
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(kScreenHeight);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, heightLogin));
    }];
    
    [self layoutIfNeeded];
    
}

#pragma mark - getter
- (UIWindow *)loginWindow {
    if (!_loginWindow) {
        _loginWindow = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        _loginWindow.windowLevel = UIWindowLevelStatusBar + 10.0;
        _loginWindow.backgroundColor = [UIColor clearColor];
    }
    return _loginWindow;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.scrollEnabled = NO;
    }
    return _scrollView;
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}

@end
