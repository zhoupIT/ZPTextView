# ZPTextView
自定义textView,可以显示placeholder,可以修改placeholder字体颜色、大小.还可以设置textview的限制字数.
###更新:###
添加isAdaptiveHeight属性,可以自适应高度.

##Adding to your project:##
Drag and drop to your project 拖拽到你的项目.

##Basic usage:##
<pre><code>ZPTextView *textView = [[ZPTextView alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, 80)];
textView.placeholder = @"开始新的一天咯(限制10个字符)";
textView.backgroundColor = [UIColor whiteColor];</code></pre>

<pre><code>/** 可以设置是否是自适应 */
textView.isAdaptiveHeight = Yes;</code></pre>
  
<pre><code>/** 限制字符的回调 */    
[textView addMaxTextLengthWithMaxLength:10 andEvent:^(ZPTextView *text) {
        NSLog(@"限制了字符个数");
}];</code></pre>
  
<pre><code>/** 开始编辑的回调 */  
[textView addTextViewBeginEvent:^(ZPTextView *text) {
        NSLog(@"开始编辑");
}];</code></pre>

<pre><code>/** 结束编辑的回调 */  
[textView addTextViewEndEvent:^(ZPTextView *text) {
       NSLog(@"结束编辑");
}];</code></pre>
    
<pre><code>[self.view addSubview:textView];</code></pre>


![示例图片](https://github.com/zhoupIT/ZPTextView/blob/master/textViewShow.gif?raw=true) 
