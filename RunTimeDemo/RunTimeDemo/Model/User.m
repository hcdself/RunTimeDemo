//
//  User.m
//  RunTimeDemo
//
//  Created by henry on 2018/6/28.
//  Copyright © 2018年 henry. All rights reserved.
//

#import "User.h"
#import <objc/runtime.h>

@interface Person:NSObject

- (void)canNotFindThiseMethod;

@end

@implementation Person

- (void)canNotFindThiseMethod:(NSString *)str {
    NSLog(@"User找不到方法后，将方法转由Person处理");
}
@end


@implementation User
{
    NSInteger money;
}

- (void)buyCar{
    
    NSLog(@"%@: %s",NSStringFromClass([User class]),__func__);
}

+ (void)work {
    NSLog(@"赶紧去干活儿");
}
- (NSInteger)haveMoney {
    
    return 200;
}

/*
 在本类和父类中找不到后，就会执行该方法
 NO -- 未对该异常进行其他处理
 YES -- 已对该异常进行处理,比如添加该方法的实现后再返回YES。
 
 默认返回NO
 */

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    NSLog(@"%s",__func__);
    return NO;
//    Method method = class_getInstanceMethod([self class], @selector(replaceWithThisMethod));
//    IMP imp = method_getImplementation(method);
//    const char *types = method_getTypeEncoding(method);
//    class_addMethod([self class], sel, imp, types);
    return YES;
}

- (void)replaceWithThisMethod {
    NSLog(@"找不到执行的方法，使用该方法替代:%s",__func__);
}

/*
 resolveInstanceMethod方法返回NO，则执行该方法。如果resolveInstanceMethod返回YES前如果还没有找到实现的方法，也会继续执行该方法
 返回一个有对应方法的类对象 --方法由返回的对象调用。如果对象中也没有该方法(公/私都行)，则崩溃
 返回self或nil -- 继续在本类往下执行,nil和self效果一样
 */

- (id)forwardingTargetForSelector:(SEL)aSelector {
    NSLog(@"%s",__func__);
   // return [Person new];
   // return nil;
    return self;
}
/*
 forwardingTargetForSelector返回self/nil，则执行以下方法
 如果该方法返回nil，则程序崩溃。反之不会。

 */

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSLog(@"%s",__func__);
    NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
    if (signature == nil) {
        signature = [NSMethodSignature signatureWithObjCTypes:"@@:@"];
    }
    return signature;
}

/*
 anInvocation.methodSignature为methodSignatureForSelector返回的方法签名。anInvocation.selector仍为执行的方法
 如果methodSignatureForSelector返回的值不为nil，则执行forwardInvocation就不会报错。反之就会崩溃
 */

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    NSLog(@"%s",__func__);
    Person *per = [[Person alloc] init];
    if ([per respondsToSelector:anInvocation.selector]) {
        [anInvocation invokeWithTarget:per];
    } else {
        NSLog(@"没有找到相关方法");
    }
}


@end
