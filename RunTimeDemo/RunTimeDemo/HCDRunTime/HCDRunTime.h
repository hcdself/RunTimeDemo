//
//  HCDRunTime.h
//  RunTimeDemo
//
//  Created by henry on 2018/6/28.
//  Copyright © 2018年 henry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface HCDRunTime : NSObject

+ (NSString *)getClassName:(id)obj;
+ (NSArray *)getIvarList:(id)obj;
+ (NSArray *)getPropertyList:(id)obj;
+ (NSArray *)getMethodList:(id)obj;
+ (NSArray *)getCategoryList:(id)obj;


+ (void)exchangeFirstMethod:(SEL)firstSel itsClass:(Class)firstClass
           WithSecondMethod:(SEL)secondSel isClass:(Class)secondClass;
+ (void)addMethod:(SEL)addSel forClass:(Class)addSelClass
       WithImpSel:(SEL)impSel itsClass:(Class)impClass;

@end
