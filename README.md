# ZY
1、cd到项目总目录
2、vim Podfile 键盘输入 i，进入编辑模式，输入
3、pod 'MBProgressHUD', '~> 0.8’，然后按Esc，并且输入“ ：”号进入vim命令模式，然后在冒号后边输入wq
4、 pod install


参考：
http://blog.csdn.net/showhilllee/article/details/38398119

pod search UI



原文链接：http://www.jianshu.com/p/df61ea673838


淘宝停止基于 HTTP 协议的镜像服务 需要改用https的协议
fix步骤：

gem sources --remove http://ruby.taobao.org/

gem sources -a https://ruby.taobao.org/

gem sources -l

sudo gem install cocoapods
