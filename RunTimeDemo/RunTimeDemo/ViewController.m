//
//  ViewController.m
//  RunTimeDemo
//
//  Created by henry on 2018/6/28.
//  Copyright © 2018年 henry. All rights reserved.
//

#import "ViewController.h"
#import "User.h"
#import <objc/runtime.h>
#import "User+AddProperty.h"
#import "HCDRunTime.h"

@interface ViewController ()

@property (nonatomic, strong) User *user;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.user = [[User alloc] init];
    self.user.name = @"张三";
    self.user.age = 24;
    self.user.sex = @"man";
    NSLog(@"---%@",self.user.sex);
 
}

- (IBAction)getinformation:(UIButton *)sender {
    //获取变量列表,包含了类的私有变量，以及property属性默认生成的变量(_name,_age)
    unsigned int count;
    Ivar *ivarList = class_copyIvarList([self.user class], &count);
    for (int i = 0; i<count; i++) {
        Ivar ivar = ivarList[i];
        const char * varName =  ivar_getName(ivar);
        const char * varType = ivar_getTypeEncoding(ivar);
        NSString *varNameStr = [NSString stringWithUTF8String:varName];
        NSString *varTypeStr = [NSString stringWithUTF8String:varType];
        NSLog(@"变量名--:%@ -- 变量类型符号:%@",varNameStr,varTypeStr);
    }
    free(ivarList);
    
    //获取属性列表
    unsigned int count2;
    objc_property_t *propertyList = class_copyPropertyList([self.user class], &count2);
    
    for (int i = 0; i<count2; i++) {
        objc_property_t property = propertyList[i];
        const char *propertyName = property_getName(property);
        const char *attributes = property_getAttributes(property);
        NSString *propertyNameStr = [NSString stringWithUTF8String:propertyName];
        NSString *attributesStr = [NSString stringWithUTF8String:attributes];
        NSLog(@"属性名--:%@ -- 属性:%@",propertyNameStr,attributesStr);
    }
    free(propertyList);
    
    //方法列表,包含公/私有方法，property默认生成的set/get方法,但不包含类方法
    unsigned int count3;
    Method *methodList = class_copyMethodList([self.user class], &count3);
    for (int i = 0; i<count3; i++) {
        Method method = methodList[i];
        SEL methodName = method_getName(method);
        NSString *methodNameStr = NSStringFromSelector(methodName);
        NSLog(@"方法名--:%@",methodNameStr);
    }

    //获取遵守的协议
    unsigned int count4;
    __unsafe_unretained Protocol **protocalList = class_copyProtocolList([self.user class], &count4);
    for (int i = 0; i< count4; i++) {
        Protocol *protocol = protocalList[i];
        const char*protocolName = protocol_getName(protocol);
        NSString *protocolNameStr = [NSString stringWithUTF8String:protocolName];
        NSLog(@"遵守的协议--:%@",protocolNameStr);
    }
    
}

- (IBAction)dynamicChangeIvar:(UIButton *)sender {
    //动态修改变量
    NSLog(@"未修改前的名字:%@",self.user.name);
    unsigned int outCount;
    Ivar *ivarList = class_copyIvarList([self.user class], &outCount);
    for (int i = 0; i<outCount; i++) {
        
        Ivar ivar = ivarList[i];
        const char *ivarName = ivar_getName(ivar);
        NSString *ivarNameStr = [NSString stringWithUTF8String:ivarName];
        if ([ivarNameStr isEqualToString:@"_name"]) {
            object_setIvar(self.user, ivar, @"李四");
        }
    }
    NSLog(@"修改后的名字:%@",self.user.name);
}
/**<MARK:hello*/
- (IBAction)addIvar:(UIButton *)sender {


}
// Comments containing: hello world

/*!
 ???:ss chuangqianmign野怪dsf \e sfsdfsdfsdf
 
 */
- (IBAction)getIvarValue:(UIButton *)sender {
    // MARK:ss

}

#warning 床前明月光

- (IBAction)addProperty:(UIButton *)sender {
    
    const char* height;
    unsigned int attributeCount = 1;
    objc_property_attribute_t attribute = {"height",NULL};
    objc_property_attribute_t attributes[1];
    attributes[0] = attribute;
    class_addProperty([self.user class], height, attributes, attributeCount);
    
}

- (IBAction)getPropertyValue:(UIButton *)sender {
    
}

- (IBAction)addMethod:(UIButton *)sender {


    //添加新方法
    
    //方式1：该方法中imp中必须带参数self和_cmd
    //class_addMethod([self.user class], @selector(haveMoreMoney:), (IMP)haveMoreMoneySelf, "c@:@");
    
    //方式2
    SEL method1 = @selector(haveMoreMoneySelf:);
    Method method = class_getInstanceMethod([self class], method1);
    IMP method1IMP = class_getMethodImplementation([self class], method1);
    const char *types = method_getTypeEncoding(method);
    SEL method2 = @selector(haveMoreMoney:);
    class_addMethod([self.user class], method2, method1IMP, types);
    
}

bool haveMoreMoneySelf(id self,SEL _cmd, id money) {
    NSLog(@"调用新方法:%s money:%@",__func__,money);
    return [money integerValue] > 200?YES:NO;
}

- (BOOL)haveMoreMoneySelf:(id)money {
    NSLog(@"调用新方法:%s money:%@",__func__,money);
    return [money integerValue] > 200?YES:NO;
}

- (IBAction)useMethod:(UIButton *)sender {
    //调用新添加的方法
    int money = 20;
    BOOL bo =  [self.user performSelector:@selector(haveMoreMoney:) withObject:@(money)];
    
}

- (IBAction)exchangeMethod:(UIButton *)sender {
    
    //动态交换方法实现,交换以后将会保持交换的状态
    Method method1 = class_getInstanceMethod([self.user class], @selector(buyCar));
    Method method2 = class_getInstanceMethod([self class], @selector(buyHouse));
    method_exchangeImplementations(method1, method2);

}

- (void)buyHouse{
    NSLog(@"%@: %s",NSStringFromClass([User class]),__func__);
}

- (IBAction)useExchangeMethod:(UIButton *)sender {
    [self.user buyCar];//因为方法已经交换，会调用ViewController的buyHouse方法
}

- (IBAction)addPropertyForCategory:(UIButton *)sender {
    
    //获取扩展添加的属性
    self.user.sex = @"man";
    NSLog(@"扩展添加的属性值:%@",self.user.sex);
    
}

- (IBAction)sendMessage:(UIButton *)sender {
    
    //[self.user performSelector:@selector(canNotFindThiseMethod:) withObject:@"hello world"];
    
    NSLog(@"%@",[HCDRunTime getClassName:self.user]);
    
}


@end
