//
//  User.h
//  RunTimeDemo
//
//  Created by henry on 2018/6/28.
//  Copyright © 2018年 henry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject<NSCopying,NSCoding>

@property (nonatomic, strong)NSString *name;
@property (nonatomic, assign)NSInteger age;
@property (nonatomic, assign)NSInteger age12;
@property (nonatomic, assign) float height;
- (void)buyCar;
+ (void)work;




- (NSInteger)sumNumber:(NSInteger)firstNumber withNumber:(NSInteger)secondNumber;


#pragma 什么都不显示
- (void)test1;

#pragma mark 显示文字，无分割线
- (void)test2;

#pragma mark - 显示分割线和文字
- (void)test3;

@end
