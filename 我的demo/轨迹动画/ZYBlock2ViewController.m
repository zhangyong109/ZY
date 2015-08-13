//
//  ZYBlock2ViewController.m
//  轨迹动画
//
//  Created by ZY on 15/7/22.
//  Copyright (c) 2015年 ZY. All rights reserved.
//

#import "ZYBlock2ViewController.h"

@interface ZYBlock2ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (nonatomic, copy) void (^testBlock)(NSString *tfText);//copy

@end

typedef long (^BlkSum)(int, int);


/*
 http://blog.csdn.net/fengsh998/article/details/38090205
 
 由于Block是默认建立在栈上, 所以如果离开方法作用域, Block就会被丢弃,
 在非ARC情况下, 我们要返回一个Block ,需要 [Block copy];
 
 在ARC下, 以下几种情况, Block会自动被从栈复制到堆:
 
 1.被执行copy方法
 2.作为方法返回值
 3.将Block赋值给附有__strong修饰符的id类型的类或者Blcok类型成员变量时
 4.在方法名中含有usingBlock的Cocoa框架方法或者GDC的API中传递的时候.
 
 */


/*
 http://blog.163.com/l1_jun/blog/static/143863882013112325622916/
 
 Block的copy、retain、release操作
 不同于NSObjec的copy、retain、release操作：
 
 Block_copy与copy等效，Block_release与release等效；
 对Block不管是retain、copy、release都不会改变引用计数retainCount，retainCount始终是1；
 NSGlobalBlock：retain、copy、release操作都无效；
 NSStackBlock：retain、release操作无效，必须注意的是，NSStackBlock在函数返回后，Block内存将被回收。即使retain也没用。容易犯的错误是[[mutableAarry addObject:stackBlock]，在函数出栈后，从mutableAarry中取到的stackBlock已经被回收，变成了野指针。正确的做法是先将stackBlock copy到堆上，然后加入数组：[mutableAarry addObject:[[stackBlock copy] autorelease]]。支持copy，copy之后生成新的NSMallocBlock类型对象。
 NSMallocBlock支持retain、release，虽然retainCount始终是1，但内存管理器中仍然会增加、减少计数。copy之后不会生成新的对象，只是增加了一次引用，类似retain；
 尽量不要对Block使用retain操作。
 
 
 Block对不同类型的变量的存取
 基本类型
 
 局部自动变量，在Block中只读。Block定义时copy变量的值，在Block中作为常量使用，所以即使变量的值在Block外改变，也不影响他在Block中的值。

 
 int base = 100;
 BlkSum sum = ^ long (int a, int b) {
 // base++; 编译错误，只读
 return base + a + b;
 };
 base = 0;
 printf("%ld\n",sum(1,2)); // 这里输出是103，而不是3
 static变量、全局变量。如果把上个例子的base改成全局的、或static。Block就可以对他进行读写了。因为全局变量或静态变量在 内存中的地址是固定的，Block在读取该变量值的时候是直接从其所在内存读出，获取到的是最新值，而不是在定义时copy的常量。
 
 
 static int base = 100;
 BlkSum sum = ^ long (int a, int b) {
 base++;
 return base + a + b;
 };
 base = 0;
 printf("%d\n", base);
 printf("%ld\n",sum(1,2));
 printf("%d\n", base);
 输出结果是0 4 1，表明Block外部对base的更新会影响Block中的base的取值，同样Block对base的更新也会影响Block外部的base值。
 
 Block变量，被__block修饰的变量称作Block变量。 基本类型的Block变量等效于全局变量、或静态变量。
 Block被另一个Block使用时，另一个Block被copy到堆上时，被使用的Block也会被copy。但作为参数的Block是不会发生copy的。
 
 void foo() {
 int base = 100;
 BlkSum blk = ^ long (int a, int b) {
 return  base + a + b;
 };
 NSLog(@"%@", blk); // <__NSStackBlock__: 0xbfffdb40>
 bar(blk);
 }
 
 void bar(BlkSum sum_blk) {
 NSLog(@"%@",sum_blk); // 与上面一样，说明作为参数传递时，并不会发生copy
 
 void (^blk) (BlkSum) = ^ (BlkSum sum) {
 NSLog(@"%@",sum);     // 无论blk在堆上还是栈上，作为参数的Block不会发生copy。
 NSLog(@"%@",sum_blk); // 当blk copy到堆上时，sum_blk也被copy了一分到堆上上。
 };
 blk(sum_blk); // blk在栈上
 
 blk = [[blk copy] autorelease];
 blk(sum_blk); // blk在堆上
 }
 
 
 ObjC对象，不同于基本类型，Block会引起对象的引用计数变化。
 
 先看下面代码

 
 @interface MyClass : NSObject {
 NSObject* _instanceObj;
 }
 @end
 
 @implementation MyClass
 
 NSObject* __globalObj = nil;
 
 - (id) init {
 if (self = [super init]) {
 _instanceObj = [[NSObject alloc] init];
 }
 return self;
 }
 
 - (void) test {
 static NSObject* __staticObj = nil;
 __globalObj = [[NSObject alloc] init];
 __staticObj = [[NSObject alloc] init];
 
 NSObject* localObj = [[NSObject alloc] init];
 __block NSObject* blockObj = [[NSObject alloc] init];
 
 typedef void (^MyBlock)(void) ;
 MyBlock aBlock = ^{
 NSLog(@"%@", __globalObj);
 NSLog(@"%@", __staticObj);
 NSLog(@"%@", _instanceObj);
 NSLog(@"%@", localObj);
 NSLog(@"%@", blockObj);
 };
 aBlock = [[aBlock copy] autorelease];
 aBlock();
 
 NSLog(@"%d", [__globalObj retainCount]);
 NSLog(@"%d", [__staticObj retainCount]);
 NSLog(@"%d", [_instanceObj retainCount]);
 NSLog(@"%d", [localObj retainCount]);
 NSLog(@"%d", [blockObj retainCount]);
 }
 @end
 
 int main(int argc, char *argv[]) {
 @autoreleasepool {
 MyClass* obj = [[[MyClass alloc] init] autorelease];
 [obj test];
 return 0;
 }
 }
 执行结果为1 1 1 2 1。
 
 __globalObj和__staticObj在内存中的位置是确定的，所以Block copy时不会retain对象。
 
 _instanceObj在Block copy时也没有直接retain _instanceObj对象本身，但会retain self。所以在Block中可以直接读写_instanceObj变量。
 
 localObj在Block copy时，系统自动retain对象，增加其引用计数。
 
 blockObj在Block copy时也不会retain。
 
 非ObjC对象，如GCD队列dispatch_queue_t。Block copy时并不会自动增加他的引用计数，这点要非常小心。
 
 
 
 Block中使用的ObjC对象的行为
 @property (nonatomic, copy) void(^myBlock)(void);
 
 MyClass* obj = [[[MyClass alloc] init] autorelease];
 self.myBlock = ^ {
 [obj doSomething];
 };
 对象obj在Block被copy到堆上的时候自动retain了一次。因为Block不知道obj什么时候被释放，为了不在Block使用obj前被释放，Block retain了obj一次，在Block被释放的时候，obj被release一次。
 
 retain cycle
 retain cycle问题的根源在于Block和obj可能会互相强引用，互相retain对方，这样就导致了retain cycle，最后这个Block和obj就变成了孤岛，谁也释放不了谁。比如：
 
 1
 2
 3
 4
 ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
 [request setCompletionBlock:^{
 NSString* string = [request responseString];
 }];

 
 +-----------+           +-----------+
 | request   |           |   Block   |
 ---> |           | --------> |           |
 | retain 2  | <-------- | retain 1  |
 |           |           |           |
 +-----------+           +-----------+
 解决这个问题的办法是使用弱引用打断retain cycle：

 
 __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
 [request setCompletionBlock:^{
 NSString* string = [request responseString];
 }];

 
 +-----------+           +-----------+
 | request   |           |   Block   |
 ---->|           | --------> |           |
 | retain 1  | < - - - - | retain 1  |
 |           |   weak    |           |
 +-----------+           +-----------+
 request被持有者释放后。request 的retainCount变成0,request被dealloc，request释放持有的Block，导致Block的retainCount变成0，也被销毁。这样这两个对象内存都被回收。

 
 +-----------+           +-----------+
 | request   |           |   Block   |
 --X->|           | ----X---> |           |
 | retain 0  | < - - - - | retain 0  |
 |           |   weak    |           |
 +-----------+           +-----------+
 与上面情况类似的陷阱：
 
 
 */
@implementation ZYBlock2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    __weak ZYBlock2ViewController * weakSelf = self;
    self.testBlock = ^(NSString * str){
        //...complete actions
        NSLog(@"weakSelf.textField.text:%@",weakSelf.textField.text);
        NSLog(@"weakSelf/str:%@",str);


    };
    self.testBlock(@"123");
    
    
//    在MRC中__block variable在block中使用是不会retain的
//    但是ARC中__block則是会Retain的。
//    取而代之的是用__weak或是__unsafe_unretained來更精确的描述weak reference的目的
//    其中前者只能在iOS5之后可以使用，但是比较好 (该物件release之后，此pointer会自动设成nil)
//    而后者是ARC的环境下为了相容4.x的解決方案。
//    所以上面的范例中
//    
//    __block MyClass* temp = …;    // MRC环境下使用
//    __weak MyClass* temp = …;    // ARC但只支援iOS5.0以上的版本
//    __unsafe_retained MyClass* temp = …;  //ARC且可以相容4.x以后的版本
    
    
//    继续看下面的code
    
//    SettingsViewController* settingsViewController =
//    [[[SettingsViewController alloc] init] autorelease];
//    settingsViewController.onUpdate = ^{
//        [self doUpdate];
//    }
//    self.settingsViewController = settingsViewController;
    
//    虽然這个Block中沒有直接使用到settingsViewController，感觉应该不会有retain cycle
//    但是因为self -> settingsViewController
//    而setttingsViewController -> block
//    再來block -> self
//    这就刚好绕了一圈，同样会有retain cycle。
//    所以呢，还是要想一样用anti pattern 2的解法去解決
    
//    SettingsViewController* settingsViewController =
//    [[[SettingsViewController alloc] init] autorelease];
//    __block RootViewController* tempSelf = self;
//    settingsViewController.onUpdate = ^{
//        [tempSelf doUpdate];
//    }
    
    
//    Block变量，被__block修饰的变量称作Block变量。 基本类型的Block变量等效于全局变量、或静态变量。
//    Block被另一个Block使用时，另一个Block被copy到堆上时，被使用的Block也会被copy。但作为参数的Block是不会发生copy的。
    foo();
    
}

//下面验证与网页上有出入
void foo() {
    int base = 100;
    BlkSum blk = ^ long (int a, int b) {
        return  base + a + b;
    };
    NSLog(@"1:%@", blk); // <__NSStackBlock__: 0xbfffdb40>
    bar(blk);
}

void bar(BlkSum sum_blk) {
    NSLog(@"2:%@",sum_blk); // 与上面一样，说明作为参数传递时，并不会发生copy
    
    void (^blk) (BlkSum) = ^ (BlkSum sum) {
        NSLog(@"3:%@",sum);     // 无论blk在堆上还是栈上，作为参数的Block不会发生copy。
        NSLog(@"4:%@",sum_blk); // 当blk copy到堆上时，sum_blk也被copy了一分到堆上上。
    };
    blk(sum_blk); // blk在栈上
    
    blk = [blk copy];
    blk(sum_blk); // blk在堆上
}

#pragma mark - tapView
- (IBAction)tapView:(UITapGestureRecognizer *)sender {
    
    [self.textField resignFirstResponder];
}

#pragma mark - blockButton
- (IBAction)blockButton:(id)sender {
    [self foo];
    [self fooBar];
}

-(void )foo{
    __block int i = 1024;
    int j = 1;
    void (^blk)(void);
    void (^blkInHeap)(void);
    blk = ^{
        printf("%d, %d\n", i, j);
    };//blk在栈里
    blkInHeap = [blk copy];//blkInHeap在堆里
    
    blkInHeap();
    i++;
    j++;//j 仍然在栈中 下面输出 j 值仍然为1;i 值则被复制到堆中，值为1025；如果使用到变量i的所有block都没有被复制至heap，那么这个变量i也不会被复制至heap
    blkInHeap();

    //1.复制的行为
    //    对block调用复制，有以下几种情况：
    //
    //    1.对全局区的block调用copy，会返回原指针，并且这期间不处理任何东西（至少目前的内部实现是这样）；
    //
    //    2.对栈上的block调用copy，每次会返回新复制到堆上的block的指针，同时，所有__block变量都会被复制至堆一份(多次拷贝，只会生成一份)。
    //    
    //    3.对已经位于heap上的block，再次调用copy，只会增加block的引用计数。
    
    
    //2.objc类中的block复制
    //
    //    objc类实例方法中的block如果被复制至heap，那么当前实例会被增加引用计数，当这个block被释放时，此实例会被减少引用计数。
    //    但如果这个block没有使用当前实例的任何成员，那么当前实例不会被增加引用计数。这也是很自然的道理，我既然没有用到这个instance的任何东西，那么
    //    我干嘛要retian它？
    //
    //    我们要注意的一点是，有很多人说block引起了实例与block之间的循环引用（retain-cycle），并且给出解决方案：不直接使用self而先将
    //    self赋值给一个临时变量，然后再使用这个临时变量。但是，注意，我们一定要为这个临时变量增加__block标记。
    //
    
}

- (void)fooBar
{
//    ZYBlock2ViewController* oj = self;
    void (^oblk)(void) = ^{
        NSLog(@"oj.textField.text:%@",self.textField.text);
    };
    void (^oblkInHeap)(void) = [oblk copy];//oblkInHeap在堆中
    oblkInHeap();
}

#pragma mark - backButton
- (IBAction)backButton:(UIButton *)sender {
    
    if (self.NextViewControllerBlock) {
        self.NextViewControllerBlock(self.textField.text);
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(passTextValue:)]) {
        [self.delegate passTextValue:self.textField.text];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
