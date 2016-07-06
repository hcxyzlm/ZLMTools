//
//  UIImage+Expansion.m
//  图片扩展类
//
//  Created by zhuo on 16/7/5.
//  Copyright © 2016年 zhuo. All rights reserved.
//

#import "UIImage+Expansion.h"

@implementation UIImage (Expansion)

#pragma -mark 图片水印
+ (instancetype)waterImageWithBg:(NSString *)bg logo:(NSString *)logo {
    
    UIImage *bgImage = [UIImage imageNamed:bg];
    // 上下文 : 基于位图(bitmap) ,  所有的东西需要绘制到一张新的图片上去
    // 1.创建一个基于位图的上下文(开启一个基于位图的上下文)
    // size : 新图片的尺寸
    // opaque : YES : 不透明,  NO : 透明
    // 这行代码过后.就相当于创建一张新的bitmap,也就是新的UIImage对象
    UIGraphicsBeginImageContextWithOptions(bgImage.size, NO, 0.0);
    
    // 画背景
    [bgImage drawInRect:CGRectMake(0, 0, bgImage.size.width, bgImage.size.height)];
    
    // 画右下角的水印
    UIImage *logoImage = [UIImage imageNamed:logo];
    CGFloat scale = 0.2;
    CGFloat logoW = logoImage.size.width * scale;
    CGFloat logoH = logoImage.size.height * scale;
    CGFloat margin = 5;
    CGFloat logoX = bgImage.size.width - logoW - margin;
    CGFloat logoY = bgImage.size.height - logoH - margin;
    CGRect rect = CGRectMake(logoX, logoY, logoW, logoH);
    [logoImage drawInRect:rect];
    
    // 从上下文中取得制作完毕的UIImage对象
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}

#pragma -mark 图片裁剪
+ (instancetype)circleImageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor {
    UIImage* image = [UIImage imageNamed:name];
    CGSize size = CGSizeMake(image.size.width + 2 *borderWidth, image.size.height + 2 * borderWidth);
    
    // 开启位图模式
    UIGraphicsBeginImageContextWithOptions(size, NO, 1);
    
    // 绘制一个大图，填充
    UIBezierPath *bigPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, size.width, size.height)];
    [borderColor set];
    [bigPath fill];
    
    // 画一个裁剪区域
    UIBezierPath *catPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(borderWidth, borderWidth, image.size.width, image.size.height)];
    [[UIColor redColor] set];
    [catPath addClip];
    
    // 把图片绘制到裁剪区域中
    [image drawAtPoint:CGPointMake(borderWidth, borderWidth)];
    
    // 生成新的图片
    UIImage *clipImage = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    
    return clipImage;
}

#pragma -mark 截屏
+ (instancetype)captureWithView:(UIView *)view {
    // 1.开启位图模式
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 1);
    // 2.将控制器view的layer渲染到上下文
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    // 得到图片
    UIImage *shotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return shotImage;
}
@end
