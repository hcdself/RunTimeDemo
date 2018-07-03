//
//  ViewController.m
//  RuntimeDemo2
//
//  Created by henry on 2018/7/2.
//  Copyright © 2018年 henry. All rights reserved.
//

#import "ViewController.h"
#import "User.h"
#import "Student.h"
#import <objc/message.h>
#import "UIButton+Click.h"
#import "NSObject+KeyValues.h"

@interface ViewController ()

@end

@implementation ViewController
{
    UIButton *btn;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    /**
     通过blcok属性建提供点击事件
     btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
     btn.click = ^{
     NSLog(@"执行block");
     };
     [self.view addSubview:btn];
     btn.center = self.view.center;
     */

    /**
     //对象归档
     
     Student *stu = [[Student alloc] init];
     stu.name = @"张三";
     stu.age = 13;
     stu.height = 154;
     
     NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
     path = [path stringByAppendingPathComponent:@"2"];
     BOOL isArchived =  [NSKeyedArchiver archiveRootObject:stu toFile:path];
     NSLog(@"isArchived: %d",isArchived);
     */

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    

    /**
     //objc_msgSend的使用
     
     User *user = [[User alloc] init];
     //设置名字,相当于self.name = @"张三";
     ((void(*)(id,SEL,NSString*))objc_msgSend)(user,sel_registerName("setName:"),@"张三");
     //获取名字,相当于NSString *nameStr = self.name
     NSString *nameStr = ((NSString*(*)(id,SEL))objc_msgSend)(user,sel_registerName("name"));
     NSLog(@"用户名:%@",nameStr);
     
     ((void(*)(id,SEL,float))objc_msgSend)(user,sel_registerName("setHeight:"),165.5);
     float height = ((float(*)(id,SEL))objc_msgSend)(user,sel_registerName("height"));
     NSLog(@"用户身高：%.2f",height);
     
     ((void(*)(id,SEL,NSInteger))objc_msgSend)(user,sel_registerName("setAge:"),24);
     NSInteger age = ((NSInteger(*)(id,SEL))objc_msgSend)(user,sel_registerName("age"));
     NSLog(@"用户身高：%ld",age);
     
     //调用方法,私有方法也可这样调用
     //- (NSString *)appendStrNum1:(NSInteger)num1 withNum2:(CGFloat)num2
     NSString *appendStr = ((NSString*(*)(id,SEL,NSInteger,CGFloat))objc_msgSend)(user,sel_registerName("appendStrNum1:withNum2:"),24,34.5);
     
     
     //NSLog(@"拼接字符串:%@",appendStr);
     //- (CGFloat)sumNum1:(NSInteger)num1 withNum2:(CGFloat)num2
     CGFloat sum = ((CGFloat (*)(id,SEL,NSInteger,CGFloat))objc_msgSend)(user,sel_registerName("sumNum1:withNum2:"),24,34.5);
     NSLog(@"两数之和:%.2f",sum);
     
     */
    
    
    
    /**
     通过blcok属性建提供点击事件
     
     btn.selected = !btn.selected;
     if (btn.selected) {
     btn.click = ^{
     NSLog(@"第一次打印block");
     };
     } else {
     btn.click = ^{
     NSLog(@"第二次打印block");
     };
     }
     
     */

    /**
     //对象解档
     NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
     path = [path stringByAppendingPathComponent:@"2"];
     Student *stu = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
     NSLog(@"name:%@,age:%ld,height:%.2f",stu.name,stu.age,stu.height);
     */
    
//    Student *stu = [[Student alloc] initWithDictionary:@{@"name":@"张三",@"age":@(13),@"height":@(145)}];
//    NSLog(@"name:%@,age:%ld,height:%.2f",stu.name,stu.age,stu.height);
//
//    NSDictionary *dict = [stu dictionaryWithValuesForKeys:@[@"name",@"age",@"height"]];
//    NSLog(@"dict: %@",dict);

    Student *stu = [Student  initWithDictionary:@{@"name":@"张三",@"age":@(13),@"height":@(145)}];
    NSLog(@"name:%@,age:%ld,height:%.2f",stu.name,stu.age,stu.height);
    NSDictionary *dict = [stu dictionaryFromObject];
    NSLog(@"dict: %@",dict);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
