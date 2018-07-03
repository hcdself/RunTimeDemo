//
//  User+AddProperty.h
//  RunTimeDemo
//
//  Created by henry on 2018/6/28.
//  Copyright © 2018年 henry. All rights reserved.
//

#import "User.h"

@interface User (AddProperty)

//通过runtime为扩展添加属性，runtime获取的变量列表中没有_set，但属性列表中有sex属性
@property (nonatomic,strong)NSString *sex;

@end
