//
//  NSObject+KeyValues.h
//  RuntimeDemo2
//
//  Created by henry on 2018/7/3.
//  Copyright © 2018年 henry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (KeyValues)
///字典转模型
+ (instancetype)initWithDictionary:(NSDictionary *)dict;
///模型转字典
-(NSDictionary *)dictionaryFromObject;

@end
