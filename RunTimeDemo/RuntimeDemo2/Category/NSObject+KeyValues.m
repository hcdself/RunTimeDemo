//
//  NSObject+KeyValues.m
//  RuntimeDemo2
//
//  Created by henry on 2018/7/3.
//  Copyright © 2018年 henry. All rights reserved.
//

#import "NSObject+KeyValues.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation NSObject (KeyValues)

//字典转模型
+ (instancetype)initWithDictionary:(NSDictionary *)dict{
    id objc = [[self alloc] init];
    [objc setValuesForKeysWithDictionary:dict];
    return objc;
}

//模型转字典
-(NSDictionary *)dictionaryFromObject {
    unsigned int outCount = 0;
    objc_property_t *propertyList = class_copyPropertyList([self class], &outCount);
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSMutableArray *keyArr = [NSMutableArray array];//储存所有属性名
    
    for (int i = 0; i < outCount; i ++) {
        objc_property_t property = propertyList[i];
        const char *propertyName = property_getName(property);
        NSString *propertyNameStr = [NSString stringWithUTF8String:propertyName];
        [keyArr addObject:propertyNameStr];
        id value = [self valueForKey:propertyNameStr];
        if (value) {
            NSString *key = [NSString stringWithUTF8String:propertyName];
            [dict setObject:value forKey:key];
        }
    }
    free(propertyList);
    // return dict;
    //通过属性名生成字典
    return [self dictionaryWithValuesForKeys:keyArr];
}

@end
