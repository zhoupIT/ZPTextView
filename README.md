# ZPTextView
自定义textView,可以显示placeholder,可以修改placeholder字体颜色、大小.还可以设置textview的限制字数.

##Adding to your project:##
Drag and drop to your project 拖拽到你的项目.

##Basic usage:##
<pre><code>ZPTextView *textView = [[ZPTextView alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, 80)];
textView.placeholder = @"开始新的一天咯(限制10个字符)";
textView.backgroundColor = [UIColor whiteColor];</code></pre>
  
/** 限制字符的回调 */    
[textView addMaxTextLengthWithMaxLength:10 andEvent:^(ZPTextView *text) {
        NSLog(@"限制了字符个数");
}];
  
/** 开始编辑的回调 */  
[textView addTextViewBeginEvent:^(ZPTextView *text) {
        NSLog(@"开始编辑");
}];

/** 结束编辑的回调 */  
[textView addTextViewEndEvent:^(ZPTextView *text) {
       NSLog(@"结束编辑");
}];
    
[self.view addSubview:textView];


![示例图片](https://github.com/zhoupIT/ZPTextView/blob/master/textViewShow.gif?raw=true) 
