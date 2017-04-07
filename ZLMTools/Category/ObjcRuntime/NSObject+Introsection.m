//
//  NSObject+Introsection.m
//  invokeBlock
//
//  Created by zhuo on 2017/3/16.
//  Copyright © 2017年 zhuo. All rights reserved.
//

#import "NSObject+Introsection.h"
#include <objc/runtime.h>
#include <objc/objc.h>

@implementation NSObject (Introsection)



/**
 struct objc_method {
 SEL method_name                                          OBJC2_UNAVAILABLE;
 char *method_types                                       OBJC2_UNAVAILABLE;
 IMP method_imp                                           OBJC2_UNAVAILABLE;
 }
 
 */
 + (NSArray *)classMethods {
    
     // 获取某个类中所有方法
     // 获取某个类中所有方法
     // Class:获取哪个类的方法
     // outCount:类中方法总数
     // class_copyMethodList:只能获取当前类
     unsigned int count = 0;
     // 获取类对象类名
     NSString *className = NSStringFromClass(self);
     // OC -> C .UTF8String
     // 获取元类
     Class metaClass = objc_getMetaClass(className.UTF8String);
     // 获取Method数组
     Method *methodList = class_copyMethodList(metaClass, &count);
     
     NSMutableArray *methods = [NSMutableArray array];
     
     for (int i = 0; i < count; i++) {
         // 获取方法
         Method method = methodList[i];
         // 获取方法名
         SEL sel = method_getName(method);
         NSMutableString * string = [NSMutableString string];
         [string appendString:[NSString stringWithFormat:@"%@", NSStringFromSelector(sel)]];
         
         // argment
        unsigned int argCount = method_getNumberOfArguments(method);
         if (argCount >= 2) {
             [string appendString:@" Arguments:"];
         }
         for (int j = 0; j < argCount; j++) {
             if (j < 2) continue;
             [string appendString:[NSString stringWithFormat:@"%s ",method_copyArgumentType(method, j)]];
         }
         [methods addObject:string];
     }
     
     return methods;
}

+ (NSArray *)instanceMethods {
    
    
    // 获取某个类中所有方法
    // 获取某个类中所有方法
    // Class:获取哪个类的方法
    // outCount:类中方法总数
    // class_copyMethodList:只能获取当前类
    unsigned int count = 0;
    // 获取类对象类名
    NSString *className = NSStringFromClass(self);
    // OC -> C .UTF8String
    // 获取元类
    Class metaClass = objc_getClass(className.UTF8String);
    // 获取Method数组
    Method *methodList = class_copyMethodList(metaClass, &count);
    
    NSMutableArray *methods = [NSMutableArray array];
    
    for (int i = 0; i < count; i++) {
        // 获取方法
        Method method = methodList[i];
        // 获取方法名
        NSMutableString * string = [NSMutableString string];
        SEL sel = method_getName(method);
        [string appendString:[NSString stringWithFormat:@"%@", NSStringFromSelector(sel)]];
        
        // argment
        unsigned int argCount = method_getNumberOfArguments(method);
        if (argCount >= 2) {
            [string appendString:@" Arguments:"];
        }
        for (int j = 0; j < argCount; j++) {
            if (j < 2) continue;
            [string appendString:[NSString stringWithFormat:@"%s ",method_copyArgumentType(method, j)]];
        }
        
        [methods addObject:string];
    }
    
    return methods;
}

+(NSArray*)properties
{
    NSString *className = NSStringFromClass(self);
    // OC -> C .UTF8String
    // 获取元类
    Class metaClass = objc_getMetaClass(className.UTF8String);
    
    NSMutableArray *boxedProperties = [NSMutableArray array];
    unsigned int propertyCount = 0;
    Ivar *propertyList = class_copyIvarList(metaClass, &propertyCount);
    if (propertyList) {
        for (unsigned int i = 0; i < propertyCount; i++) {
            Ivar ivar = propertyList[i];
            const char * name = ivar_getName(ivar);
            const char * type = ivar_getTypeEncoding(ivar);
            [boxedProperties addObject:[NSString stringWithFormat:@"%s --->  %s", type, name]];
        }
        free(propertyList);
    }
    return boxedProperties;
}

+ (NSString *)parentClassHierarchy {
    
    NSString *className = NSStringFromClass(self);
    // OC -> C .UTF8String
    // 获取元类
    Class metaClass = objc_getMetaClass(className.UTF8String);
    
    NSMutableString *hierarchyString = [NSMutableString string];
    
    [hierarchyString appendString:NSStringFromClass(metaClass)];
    Class superClass = class_getSuperclass(metaClass);
    
    while (class_getSuperclass(superClass)) {
        [hierarchyString appendString:[NSString stringWithFormat:@" --> %@", NSStringFromClass(superClass)]];
        superClass = class_getSuperclass(superClass);
    };
    
    return hierarchyString;
}

+ (NSArray *)protocols {
    
    NSString *className = NSStringFromClass(self);
    // OC -> C .UTF8String
    // 获取元类
    Class metaClass = objc_getMetaClass(className.UTF8String);
    
    NSMutableArray *protocols = [NSMutableArray array];
    unsigned int protocolCount = 0;
    Protocol * __unsafe_unretained *protocolList = class_copyProtocolList(metaClass, &protocolCount);
    if (protocolList) {
        for (unsigned int i = 0; i < protocolCount; i++) {
            Protocol *myProtocol = protocolList[i];
            const char *protocolName = protocol_getName(myProtocol);
            [protocols addObject:[NSString stringWithFormat:@"%s", protocolName]];
        }
        free(protocolList);
    }
    return protocols;
}
@end
