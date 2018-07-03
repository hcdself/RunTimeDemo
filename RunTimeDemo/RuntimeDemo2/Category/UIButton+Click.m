//
//  UIButton+Click.m
//  RuntimeDemo2
//
//  Created by henry on 2018/7/3.
//  Copyright © 2018年 henry. All rights reserved.
//

#import "UIButton+Click.h"
#import <objc/runtime.h>

@implementation UIButton (Click)

- (void)setClick:(ButtonClick)click {

    objc_setAssociatedObject(self, "click", click, OBJC_ASSOCIATION_RETAIN);
    if (click) {
        [self removeTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)buttonClick {
    
    if (self.click) {
        self.click();
    }
}

- (ButtonClick)click {
    return objc_getAssociatedObject(self, "click");
}

@end
