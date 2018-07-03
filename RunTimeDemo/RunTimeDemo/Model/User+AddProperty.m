//
//  User+AddProperty.m
//  RunTimeDemo
//
//  Created by henry on 2018/6/28.
//  Copyright © 2018年 henry. All rights reserved.
//

#import "User+AddProperty.h"
#import <objc/runtime.h>

@interface User()

@end

@implementation User (AddProperty)

- (void)setSex:(NSString *)sex {
    /**
     为某一个对象添加属性
      参数1 要添加的对象
      参数2 属性key,取值时用到，为指针类型，可以是字符串，也可以是其他指针类型，如Sel
      参数3 属性策略，如copy,retain等
     */
    //objc_setAssociatedObject(sex, "sex", sex, OBJC_ASSOCIATION_COPY);
    objc_setAssociatedObject(self, @selector(sex), sex, OBJC_ASSOCIATION_COPY);
    
}

- (NSString *)sex {
 // return   objc_getAssociatedObject(self, "sex");
    return objc_getAssociatedObject(self, _cmd);
}


@end
