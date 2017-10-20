# ClassBlockDemo

文章[类方法的Block不会内存泄漏....吗？！](https://objchris.github.io/2016/07/17/类方法Block内存泄漏/)的Demo。

里面有两个`ViewController`：`AnimationViewController`和`StrongSelfAnimationViewController`。

它们分别表示在类的`block`中存在递归函数调用自己的情况下使用`__weak self`和`self`的情况。使用此demo要配合Instruments的Allocations，来查看`AnimationViewController`和`StrongSelfAnimationViewController`各自的`#Persistent`、`#Transient`和`#Total`的关系，就能看出是否被释放。

