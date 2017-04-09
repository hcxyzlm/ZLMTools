//
//  NSObject+Introsection.h
//  invokeBlock
//
//  Created by zhuo on 2017/3/16.
//  Copyright © 2017年 zhuo. All rights reserved.
//

// 运行时的方法

#import <Foundation/Foundation.h>

@interface NSObject (Introsection)

// 所有类方法
+ (NSArray *)classMethods;

+ (NSArray *)instanceMethods;

// 所有成员属性，共有私有属性，以及扩展属性

+(NSArray*)properties;

// 查看继承关系
+ (NSString *)parentClassHierarchy;

+ (NSArray *)protocols;

- (NSArray *)IvarList;

@end
