//
//  ViewController.m
//  自定义类似AlertViewController的效果
//
//  Created by 艾葭 on 15/11/12.
//  Copyright © 2015年 艾葭. All rights reserved.
//

#import "ViewController.h"
#import "AJView.h"

@interface ViewController ()<AJViewDelegate>
@property (nonatomic, strong) NSArray *imagesArray;
@property (nonatomic, strong) NSArray *titlesArray;
@property (nonatomic) AJView *ajView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imagesArray = @[@"sns_icon_22",@"sns_icon_23",@"sns_icon_18"];
    self.titlesArray = @[@"微信好友",@"朋友圈",@"短信转发"];
        self.view.backgroundColor = [UIColor greenColor];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)shareAction:(id)sender {
    _ajView = [[AJView alloc]initWithTitles:self.titlesArray andShareImages:self.imagesArray];
    _ajView.delegate = self;
    [_ajView showInView:self.view];
}

-(void)didClickOnView:(UIView *)view withIndex:(NSInteger)index{
     NSLog(@"选择了%@",self.titlesArray[index-1]);
}


@end
