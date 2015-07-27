//
//  MyNavigationBar.m
//  NavigationBarDesign
//
//  Created by Visitor on 15/6/2.
//  Copyright (c) 2015年 Visitor. All rights reserved.
//

#import "MyNavigationBar.h"

@implementation MyNavigationBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


- (void)createMyNavigationBarWithBgImageName:(NSString *)bgImageName andTitle:(NSString *)title andLeftItemArray:(NSArray *)leftItemArray andRightItemArray:(NSArray *)rightItemArray andClass:(id)classObject andSEL:(SEL)sel;
{
    // 1.创建背景图
    [self createBgImageViewWithImageName:bgImageName];
    // 2.创建标题
    [self createTitleLabelWithTitle:title];
    // 3.创建按钮(调用多次)
    // 需要分别判断左右和右侧是否有按钮
    if(leftItemArray.count>0)
    {
        CGFloat x = 10;
        for(int i=0;i<leftItemArray.count;i++)
        {
            NSDictionary *dict = [leftItemArray objectAtIndex:i];
            x = [self createItemWithItemTitle:[dict objectForKey:@"itemtitle"] andItemBgImageName:[dict objectForKey:@"itembgimagename"] andX:x andIndex:i andIsLeft:YES andClass:classObject andSEL:sel];
        }
    }
    if(rightItemArray.count>0)
    {
        CGFloat x = 320-10;
        for(int i=0;i<rightItemArray.count;i++)
        {
            NSDictionary *dict = [rightItemArray objectAtIndex:i];
            x = [self createItemWithItemTitle:[dict objectForKey:@"itemtitle"] andItemBgImageName:[dict objectForKey:@"itembgimagename"] andX:x andIndex:i andIsLeft:NO andClass:classObject andSEL:sel];
        }

    }
    
    
}

- (void)createBgImageViewWithImageName:(NSString *)bgImageName
{
    UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:bgImageName]];
    iv.frame = self.bounds;
    [self addSubview:iv];
}

- (void)createTitleLabelWithTitle:(NSString *)title
{
    UILabel *label = [[UILabel alloc] init];
    label.frame = self.bounds;
    label.textAlignment = NSTextAlignmentCenter;
    label.text = title;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:18];
    [self addSubview:label];
}

- (CGFloat)createItemWithItemTitle:(NSString *)itemTitle andItemBgImageName:(NSString *)itemBgImageName andX:(CGFloat)xFloat andIndex:(int)index andIsLeft:(BOOL)isLeft andClass:(id)classObject andSEL:(SEL)sel
{
    // xFloat为计算好的起始点坐标
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat x1 = 40.f;
    UIImage *image;
    if(itemBgImageName.length>0)
    {
        image = [UIImage imageNamed:itemBgImageName];
        x1 = image.size.width;
    }
    CGFloat x = isLeft?xFloat:xFloat - x1;
    CGFloat y = itemBgImageName.length>0? (self.frame.size.height-image.size.height)/2:(self.frame.size.height-30)/2;
    CGFloat w = itemBgImageName.length>0?image.size.width:40;
    CGFloat h = itemBgImageName.length>0?image.size.height:30;

    btn.frame = CGRectMake(x, y, w, h);
    [btn setTitle:itemTitle forState:UIControlStateNormal];
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    btn.tag = isLeft?index:1000+index;
    [btn addTarget:classObject action:sel forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:btn];
    
    
    return isLeft?x+btn.frame.size.width+10:x-10;
}
















@end
