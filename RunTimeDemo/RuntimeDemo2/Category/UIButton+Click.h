//
//  UIButton+Click.h
//  RuntimeDemo2
//
//  Created by henry on 2018/7/3.
//  Copyright © 2018年 henry. All rights reserved.
//

#import <UIKit/UIKit.h>
/*
 为button添加click属性，通过click属性监听点击事件
 */

typedef void(^ButtonClick)(void);

@interface UIButton (Click)

@property (nonatomic, strong) ButtonClick click;

@end
