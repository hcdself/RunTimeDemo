//
//  Student.m
//  RuntimeDemo2
//
//  Created by henry on 2018/7/2.
//  Copyright © 2018年 henry. All rights reserved.
//

#import "Student.h"
#import <objc/runtime.h>

@implementation Student


- (void)encodeWithCoder:(NSCoder *)aCoder {
    /**
     普通写法
     [aCoder encodeObject:self.name forKey:@"name"];
     [aCoder encodeInteger:self.age forKey:@"age"];
     [aCoder encodeFloat:self.height forKey:@"height"];
     */
    
    //runtime方式进行归档
    unsigned int outCount;
    objc_property_t *propertyList = class_copyPropertyList([self class], &outCount);
    for (int i = 0;i < outCount; i++) {
        objc_property_t property = propertyList[i];
        const char *propertyName = property_getName(property);
        NSString *propertyNameStr = [NSString stringWithUTF8String:propertyName];
        id value = [self valueForKey:propertyNameStr];
        [aCoder encodeObject:value forKey:propertyNameStr];
    }
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        
        /**
         普通做法
         self.name = [aDecoder decodeObjectForKey:@"name"];
         self.age = [aDecoder decodeIntegerForKey:@"age"];
         self.height = [aDecoder decodeFloatForKey:@"height"];
         */
        
        //runtime方式进行解档
        unsigned int outCount;
        objc_property_t *propertyList = class_copyPropertyList([self class], &outCount);
        for (int i = 0; i<outCount; i++) {
            objc_property_t property = propertyList[i];
            
            unsigned int outCount2;
            objc_property_attribute_t *attributeList = property_copyAttributeList(property, &outCount2);
            for (int j = 0; j<outCount2; j++) {
                objc_property_attribute_t attribute = attributeList[i];
                const char *attributeName = attribute.name;
                const char *attributeValue = attribute.value;
                NSLog(@"attributeName:%s, attributeValue:%s",attributeName,attributeValue);
            }
            
            const char *propertyName = property_getName(property);
            NSString *propertyNameStr = [NSString stringWithUTF8String:propertyName];
            id value = [aDecoder decodeObjectForKey:propertyNameStr];
            [self setValue:value forKey:propertyNameStr];
        }
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        
        //runtime方式进行解档
        unsigned int outCount;
        objc_property_t *propertyList = class_copyPropertyList([self class], &outCount);
        for (int i = 0; i<outCount; i++) {
            objc_property_t property = propertyList[i];
 
            const char *propertyName = property_getName(property);
            NSString *propertyNameStr = [NSString stringWithUTF8String:propertyName];
            unsigned int outCount2;
            objc_property_attribute_t *attributeList = property_copyAttributeList(property, &outCount2);
            for (int j = 0; j<outCount2; j++) {
                objc_property_attribute_t attribute = attributeList[i];
                const char *attributeName = attribute.name;
                const char *attributeValue = attribute.value;
                NSLog(@"propertyName:%@, attributeName:%s, attributeValue:%s",propertyNameStr,attributeName,attributeValue);
            }
            
            //id value = [aDecoder decodeObjectForKey:propertyNameStr];
            //[self setValue:value forKey:propertyNameStr];
        }
    }
    return self;
}

@end
