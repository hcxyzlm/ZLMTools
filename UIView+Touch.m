//
//  UIView+Touch.m
//  ZLMTools
//
//  Created by limin.zhuo on 16/5/26.
//  Copyright © 2016年 limin.zhuo. All rights reserved.
//

#import "UIView+Touch.h"
#import <objc/runtime.h>
static NSString *enableNextResponderKey = @"enableNextResponderKey";

@implementation UIView (Touch)
-(void)setEnableNextResponder:(BOOL)enableNextResponder {
    objc_setAssociatedObject(self, &enableNextResponderKey, enableNextResponderKey, OBJC_ASSOCIATION_ASSIGN);
}
-(BOOL)enableNextResponder {
    return objc_getAssociatedObject(self, &enableNextResponderKey);
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if (self.enableNextResponder) {
        [[self nextResponder] touchesBegan:touches withEvent:event];
        [super touchesBegan:touches withEvent:event];
    }
    
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    if (self.enableNextResponder) {
        [[self nextResponder] touchesEnded:touches withEvent:event];
        [super touchesEnded:touches withEvent:event];
    }
    
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
   
    if (self.enableNextResponder) {
        
        [[self nextResponder] touchesMoved:touches withEvent:event];
        [super touchesMoved:touches withEvent:event];
    }
    
    
}
-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  
    if (self.enableNextResponder) {
        [[self nextResponder] touchesCancelled:touches withEvent:event];
        [super touchesCancelled:touches withEvent:event];
    }

}
@end
