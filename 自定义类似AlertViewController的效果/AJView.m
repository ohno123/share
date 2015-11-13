//
//  AJView.m
//  自定义类似AlertViewController的效果
//
//  Created by 艾葭 on 15/11/12.
//  Copyright © 2015年 艾葭. All rights reserved.
//

#import "AJView.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
@interface AJView()
@property (nonatomic)UIView *bgView ;
@property (nonatomic, strong)UIView *mainView;
@end
@implementation AJView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

#pragma mark - public method
-(id)initWithTitles:(NSArray *)shareTitlesArray andShareImages:(NSArray *)shareImagesArray{
    self = [super init];
    if (self) {
        //设置view大小
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        self.bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _mainView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT/1.4, SCREEN_WIDTH, SCREEN_HEIGHT-SCREEN_HEIGHT/1.4)];
        _mainView.backgroundColor = [UIColor redColor];
        //设置分享信息
        [self createShareButtonTitles:shareTitlesArray andShareButtonImages:shareImagesArray];
    }
    return self;
}
-(void)showInView:(UIView *)view{
    _bgView.backgroundColor = [UIColor grayColor];
    _bgView.alpha = 0.5;
    // 添加手势
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedCancel)];
    [_bgView addGestureRecognizer:tapGesture];
    
    [view addSubview:self.mainView];
    [view insertSubview:_bgView atIndex:2];
}

-(void)createShareButtonTitles:(NSArray *)shareTitlesArray andShareButtonImages:(NSArray *)shareImagesArray{
    // 创建3个button
    CGFloat width  = _mainView.frame.size.width/6;
    CGFloat height = _mainView.frame.size.height;
    CGRect frame1 = CGRectMake(width/2, height/7.6, width, height/2.3);
    CGRect frame2 = CGRectMake(width*2.5, height/7.6, width, height/2.3);
    CGRect frame3 = CGRectMake(width*4.5, height/7.6, width, height/2.3);
    UIButton *btn1 = [self createShareButtonWithFrame:frame1 withImageName:shareImagesArray[0]  withName:shareTitlesArray[0]];
    UIButton *btn2 = [self createShareButtonWithFrame:frame2 withImageName:shareImagesArray[1]  withName:shareTitlesArray[1]];
    UIButton *btn3 = [self createShareButtonWithFrame:frame3 withImageName:shareImagesArray[2]  withName:shareTitlesArray[2]];
    [_mainView addSubview:btn1];
    [_mainView addSubview:btn2];
    [_mainView addSubview:btn3];
    
    UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-SCREEN_WIDTH/1.4)/2, _mainView.frame.size.height/1.5, SCREEN_WIDTH/1.4, 30)];
    cancelButton.layer.masksToBounds = YES;
    cancelButton.layer.cornerRadius = 5;
    [cancelButton setBackgroundImage:[UIImage imageNamed:@"分享"] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [_mainView addSubview:cancelButton];
    
    btn1.tag = 1;
    btn2.tag = 2;
    btn3.tag = 3;
    cancelButton.tag = 0;

}

-(UIButton *)createShareButtonWithFrame:(CGRect)frame withImageName:(NSString *)btnImageName withName:(NSString *)btnName{
    UIButton *btn = [[UIButton alloc]initWithFrame:frame];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, btn.frame.size.width, btn.frame.size.width)];
    imageView.image = [UIImage imageNamed:btnImageName];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, btn.frame.size.width+10, btn.frame.size.width, 15)];
    label.text = btnName;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:12];
    [btn addSubview:imageView];
    [btn addSubview:label];
    [btn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}


-(void)tappedCancel{
    [UIView animateWithDuration:0.5 animations:^{
        [self.bgView removeFromSuperview];
        self.mainView.alpha = 0;
        [self.mainView removeFromSuperview];
    } completion:^(BOOL finished) {
        if (finished) {
            
        }
    }];
}

-(void)cancelAction:(id)sender{
    UIButton *btn = (UIButton *)sender;
    NSInteger index = btn.tag;
    if (index != 0) {
        if (self.delegate == nil) {
            NSLog(@"error : no delegate..\n");
        }else{
            if ([self.delegate respondsToSelector:@selector(didClickOnView:withIndex:)] == true) {
                [self.delegate didClickOnView:self withIndex:btn.tag];
            }else{
                NSLog(@"error: no function found..\n");
            }
        }
    }
    [self tappedCancel];
}
@end
