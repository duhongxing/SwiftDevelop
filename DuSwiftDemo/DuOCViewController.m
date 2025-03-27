//
//  DuOCViewController.m
//  DuSwiftDemo
//
//  Created by duhongxing on 2025/3/13.
//

#import "DuOCViewController.h"
#import "DuSwiftDemo-Swift.h"
#import <objc/runtime.h>
#import <Metal/Metal.h>

/*
 Runtime常用示例
 动态获取类名、
 动态获取类的成员变量、
 动态获取类的属性列表、
 动态获取类的方法列表、
 动态获取类所遵循的协议列表、
 动态添加新的方法、
 类的实例方法实现的交换、
 动态属性关联、
 消息发送与消息转发机制
 */

@interface DuOCViewController ()

@end

@implementation DuOCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];

    NSOperation *op = [[NSOperation alloc]init];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(repeatPrintLog) userInfo:nil repeats:YES];

}

- (void)repeatPrintLog {
    NSLog(@"%s", _cmd);
}


/// 获取类名
/// - Parameter class: 类
+ (NSString *)getClassName:(Class)class {
    const char *className = class_getName(class);
    return [NSString stringWithUTF8String:className];
}


/// 获取成员变量
/// - Parameter class: 类
+ (NSArray *)getIvarList:(Class)class {
    unsigned int count = 0;
    Ivar *ivarList = class_copyIvarList(class, &count);
    
    NSMutableArray *mutableList = [NSMutableArray arrayWithCapacity:count];
    for (unsigned int i = 0; i < count; i++) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:2];
        const char *ivarName = ivar_getName(ivarList[i]);
        const char *ivarType = ivar_getTypeEncoding(ivarList[i]);
        dic[@"type"] = [NSString stringWithUTF8String:ivarType];
        dic[@"name"] = [NSString stringWithUTF8String:ivarName];
        [mutableList addObject:dic];
    }
    free(ivarList);
    return [NSArray arrayWithArray:mutableList];
}

/// 获取属性列表
/// - Parameter class: 类
+ (NSArray *)getPropertyList:(Class)class {
    unsigned int count = 0;
    objc_property_t *propertyList = class_copyPropertyList(class, &count);
    
    NSMutableArray *mutableList = [NSMutableArray arrayWithCapacity:count];
    for (unsigned int i = 0; i < count; i++) {
        const char *prpertyName = property_getName(propertyList[i]);
        [mutableList addObject: [NSString stringWithUTF8String:prpertyName]];
    }
    free(propertyList);
    return [NSArray arrayWithArray:mutableList];
}

/// 获取类的实例方法列表：getter setter 对象方法。不能获取类方法
/// - Parameter class: 类
+ (NSArray *)getMethodList:(Class)class {
    unsigned int count = 0;
    Method *methodList = class_copyMethodList(class, &count);
    
    NSMutableArray *mutableList = [NSMutableArray arrayWithCapacity:count];
    for (unsigned int i = 0; i < count; i++) {
        Method methodName = methodList[i];
        SEL methodSelector = method_getName(methodName);
        [mutableList addObject: NSStringFromSelector(methodSelector)];
    }
    free(methodList);
    return [NSArray arrayWithArray:mutableList];
}

/// 获取类的协议列表
/// - Parameter class: 类
+ (NSArray *)getProtocolList:(Class)class {
    unsigned int count = 0;
    __unsafe_unretained Protocol **protocolList = class_copyProtocolList(class, &count);
    
    NSMutableArray *mutableList = [NSMutableArray arrayWithCapacity:count];
    for (unsigned int i = 0; i < count; i++) {
        Protocol *protocol = protocolList[i];
        const char *protocolName = protocol_getName(protocol);
        [mutableList addObject: [NSString stringWithUTF8String:protocolName]];
    }
    free(protocolList);
    return [NSArray arrayWithArray:mutableList];
}

/// 类添加方法
/// - Parameters:
///   - class: 类
///   - methodSel: 方法
+ (void)addMethod:(Class)class methodSel:(SEL)methodSel {
    Method method = class_getInstanceMethod(class, methodSel);
    IMP methodIMP = method_getImplementation(method);
    const char *types = method_getTypeEncoding(method);
    class_addMethod(class, methodSel, methodIMP, types);
}


/// 方法交换
/// - Parameters:
///   - class: 类
///   - originalMethodSel: 原方法
///   - swizzledMethodSel: 交换的方法
+ (void)methodSwap:(Class)class originalMethod:(SEL)originalMethodSel swizzledMethod:(SEL)swizzledMethodSel {
    Method originalMethod = class_getInstanceMethod(class, originalMethodSel);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledMethodSel);
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

// 类方法 消息处理
+ (BOOL)resolveClassMethod:(SEL)sel {
    return [super resolveClassMethod:sel];
}

// 实例方法 消息处理
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    return [super resolveInstanceMethod: sel];
}

// 消息快速转发 将当前对象不存在的SEL传给其他存在SEL的对象
- (id)forwardingTargetForSelector:(SEL)aSelector {
    return [super forwardingTargetForSelector: aSelector];
}

// 消息常规转发
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    return [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    SEL sel = anInvocation.selector;
    //[self doesNotRecognizeSelector:sel];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end


@implementation DuInterViewObjc


@end
