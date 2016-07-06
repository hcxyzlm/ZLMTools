//
//  UIImage+Expansion.h
//  图片扩展类
//
//  Created by zhuo on 16/7/5.
//  Copyright © 2016年 zhuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Expansion)
/**
 *  返回一个图片水印
 *
 *  @param bg   原始图片名称
 *  @param logo 水印logo
 *
 *  @return 返回一个UIImage
 */
+ (instancetype)waterImageWithBg:(NSString *)bg logo:(NSString *)logo;
/**
 *  图片裁剪边框
 *
 *  @param name        图片的名称
 *  @param borderWidth 边框大小
 *  @param borderColor 边框颜色
 *
 *  @return 返回一个UIImage
 */
+ (instancetype)circleImageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

/**
 *  截屏
 *
 *  @param view 需要截屏的视图
 *
 *  @return 返回一个截屏的UIImage
 */
+ (instancetype)captureWithView:(UIView*)view;
@end
