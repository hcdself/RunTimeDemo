//
//  Student.h
//  RuntimeDemo2
//
//  Created by henry on 2018/7/2.
//  Copyright © 2018年 henry. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Student : NSObject<NSCoding>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSInteger age;
@property (nonatomic, assign) float height;

//- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end
