//
//  User.m
//  RuntimeDemo2
//
//  Created by henry on 2018/7/2.
//  Copyright © 2018年 henry. All rights reserved.
//

#import "User.h"

#import <objc/message.h>
#import <objc/objc.h>
#import <objc/runtime.h>

@implementation User

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeInteger:self.age forKey:@"age"];
    [aCoder encodeFloat:self.height forKey:@"height"];
    
    
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.age = [aDecoder decodeIntegerForKey:@"age"];
        self.height = [aDecoder decodeFloatForKey:@"height"];
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        [self appendStrNum1:12 withNum2:12.2];
        [User sumNum1:124 withNum2:124.2];
        [self getSpellType];
        
    }
    return self;
}

- (void)logName {
    NSLog(@"打印名字");
}

- (NSString *)appendStrNum1:(NSInteger)num1 withNum2:(CGFloat)num2 {
    return [NSString stringWithFormat:@"%ld--%.2f",num1,num2];
}

- (NSArray *)sumNum1:(NSInteger)num1 withNum2:(CGFloat)num2 {
    return @[@(num1),@(num2)];
}

+ (NSArray *)sumNum1:(NSInteger)num1 withNum2:(CGFloat)num2 {
    return @[@(num1),@(num2)];
}

- (SpellType)getSpellType {
    return A;
}

@end
