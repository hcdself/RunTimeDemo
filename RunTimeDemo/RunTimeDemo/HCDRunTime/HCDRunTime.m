//
//  HCDRunTime.m
//  RunTimeDemo
//
//  Created by henry on 2018/6/28.
//  Copyright © 2018年 henry. All rights reserved.
//

#import "HCDRunTime.h"

@implementation HCDRunTime

+ (NSString *)getClassName:(id)obj {
    return [NSString stringWithUTF8String:object_getClassName(obj)];
}

+ (NSArray *)getIvarList:(id)obj {

    unsigned int outCount;
    NSMutableArray *lists = [NSMutableArray array];
    Ivar *ivarList = class_copyIvarList([obj class], &outCount);
    for (int i = 0; i< outCount; i++) {
        Ivar ivar = ivarList[i];
        const char *ivarName = ivar_getName(ivar);
        NSString *ivarNameStr = [NSString stringWithUTF8String:ivarName];
        [lists addObject:ivarNameStr];
    }
    free(ivarList);
    return lists;
}

+ (NSArray *)getPropertyList:(id)obj {
    unsigned int outCount;
    NSMutableArray *lists = [NSMutableArray array];
    objc_property_t *propertyList = class_copyPropertyList([obj class], &outCount);
    for (int i = 0; i< outCount; i++) {
        objc_property_t property = propertyList[i];
        const char *propertyName = property_getName(property);
        NSString *propertyNameStr = [NSString stringWithUTF8String:propertyName];
        [lists addObject:propertyNameStr];
    }
    free(propertyList);
    return lists;
}

+ (NSArray *)getMethodList:(id)obj {
    unsigned int outCount;
    NSMutableArray *lists = [NSMutableArray array];
    Method *methodList = class_copyMethodList([obj class], &outCount);
    for (int i = 0; i< outCount; i++) {
        Method method = methodList[i];
        SEL methodSel = method_getName(method);
        NSString *methodNameStr = NSStringFromSelector(methodSel);
        [lists addObject:methodNameStr];
    }
    free(methodList);
    return lists;
}

+ (NSArray *)getCategoryList:(id)obj {
    unsigned int outCount;
    NSMutableArray *lists = [NSMutableArray array];
    __unsafe_unretained Protocol **protocolList = class_copyProtocolList([obj class], &outCount);
    for (int i = 0; i< outCount; i++) {
        Protocol *protocol = protocolList[i];
        const char *protocolName = protocol_getName(protocol);
        NSString *protocolNameStr = [NSString stringWithUTF8String:protocolName];
        [lists addObject:protocolNameStr];
    }
    free(protocolList);
    return lists;
}

+ (void)exchangeFirstMethod:(SEL)firstSel itsClass:(Class)firstClass WithSecondMethod:(SEL)secondSel isClass:(Class)secondClass {
    Method firstMethod = class_getInstanceMethod(firstClass, firstSel);
    Method secondMethod = class_getInstanceMethod(secondClass, secondSel);
    method_exchangeImplementations(firstMethod, secondMethod);
}

+ (void)addMethod:(SEL)addSel forClass:(Class)addSelClass
       WithImpSel:(SEL)impSel itsClass:(Class)impClass {
    IMP imp = class_getMethodImplementation(impClass, impSel);
    Method method = class_getInstanceMethod(impClass, impSel);
    const char *types = method_getTypeEncoding(method);
    class_addMethod(addSelClass, addSel, imp, types);
}


@end
