//
//  AJView.h
//  自定义类似AlertViewController的效果
//
//  Created by 艾葭 on 15/11/12.
//  Copyright © 2015年 艾葭. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AJView;

@protocol AJViewDelegate <NSObject>

-(void)didClickOnView:(UIView *)view withIndex:(NSInteger)index;
@end

@interface AJView : UIView
@property (nonatomic, assign) id<AJViewDelegate> delegate;
-(id)initWithTitles:(NSArray *)shareTitlesArray andShareImages:(NSArray *)shareImagesArray;
-(void)showInView:(UIView *)view;

@end
