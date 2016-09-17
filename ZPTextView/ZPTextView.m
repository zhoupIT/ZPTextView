//
//  ZPTextView.m
//  ZPTextView
//
//  Created by peng on 16/9/14.
//  Copyright © 2016年 IDevent.inc. All rights reserved.
//

#import "ZPTextView.h"
#define kMargin 5.0
@interface ZPTextView ()<UITextViewDelegate>
/** placeholder_label */
@property (strong,nonatomic)  UILabel *placeholder_Label;
@property (assign,nonatomic) float placeholdeWidth;
@property (strong,nonatomic) UIColor *placeholder_color;
@property (strong,nonatomic) UIFont *placeholder_font;

@property (nonatomic,copy) void (^beginEventBlock)(ZPTextView *textView);
@property (nonatomic,copy) void (^endEventBlock)(ZPTextView *textView);
@property (nonatomic,copy) void (^Block)(ZPTextView *textView);
@end
@implementation ZPTextView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    float left=kMargin,top=kMargin+2,hegiht=30;
    self.placeholdeWidth = CGRectGetWidth(self.frame) -2*left;
    self.placeholder_Label = [[UILabel alloc] initWithFrame:CGRectMake(left, top, self.placeholdeWidth, hegiht)];
    self.placeholder_Label.numberOfLines = 0;
    self.placeholder_Label.lineBreakMode = NSLineBreakByCharWrapping|NSLineBreakByWordWrapping;
    [self addSubview:self.placeholder_Label];
    
    self.placeholder_color = [UIColor lightGrayColor];
    self.placeholder_font = [UIFont systemFontOfSize:15];
    self.maxTextLength = 1000;
    self.layoutManager.allowsNonContiguousLayout = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidChange:) name:UITextViewTextDidChangeNotification object:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewBeginNotification:) name:UITextViewTextDidBeginEditingNotification object:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewEndNotification:) name:UITextViewTextDidEndEditingNotification object:self];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    float left=kMargin,top=kMargin+2,hegiht=self.bounds.size.height;
    self.placeholdeWidth = CGRectGetWidth(self.frame)-2*left;
    CGRect frame = self.placeholder_Label.frame;
    frame.origin.x = left;
    frame.origin.y = top;
    frame.size.height = hegiht;
    frame.size.width = self.placeholdeWidth;
    self.placeholder_Label.frame = frame;
    [self.placeholder_Label sizeToFit];
}

-(void)addMaxTextLengthWithMaxLength:(NSInteger)maxLength andEvent:(void (^)(ZPTextView *text))limit
{
    if (maxLength>0) {
        _maxTextLength = maxLength;
    }
    if (limit) {
        self.Block = limit;
    }
}

-(void)addTextViewBeginEvent:(void (^)(ZPTextView *))begin{
    _beginEventBlock = begin;
}

-(void)addTextViewEndEvent:(void (^)(ZPTextView *))End{
    _endEventBlock = End;
}

- (void)setTextViewHeight:(float)textViewHeight {
    CGRect frame = self.frame;
    frame.size.height = textViewHeight;
    self.frame = frame;
    _textViewHeight = textViewHeight;
}

#pragma mark - public
-(void)setPlaceholderFont:(UIFont *)font {
    self.placeholder_font=font;
}

-(void)setPlaceholderColor:(UIColor *)color {
    self.placeholder_color=color;
    
}

-(void)setPlaceholderOpacity:(float)opacity {
    if (opacity<0) {
        opacity=1;
    }
    self.placeholder_Label.layer.opacity=opacity;
}

#pragma mark - Notification Event
-(void)textViewBeginNotification:(NSNotification *)noti {
    if (self.beginEventBlock) {
        self.beginEventBlock(self);
    }
}

-(void)textViewEndNotification:(NSNotification *)noti {
    if (self.endEventBlock) {
        self.endEventBlock(self);
    }
}

-(void)textViewDidChange:(NSNotification *)noti {
    
    if (self.placeholder.length == 0 || [self.placeholder isEqualToString:@""]) {
        _placeholder_Label.hidden=YES;
    }
    
    if (self.text.length > 0) {
        _placeholder_Label.hidden=YES;
    }
    else{
        _placeholder_Label.hidden=NO;
    }
    if (self.isAdaptiveHeight) {
        CGRect frame = self.frame;
        CGSize constraintSize = CGSizeMake(frame.size.width, MAXFLOAT);
        CGSize size = [self sizeThatFits:constraintSize];
        if (size.height<=frame.size.height) {
            size.height=frame.size.height;
        }else{
            if (size.height >= MAXFLOAT)
            {
                size.height = MAXFLOAT;
                self.scrollEnabled = YES;   // 允许滚动
            }
            else
            {
                self.scrollEnabled = NO;    // 不允许滚动
            }
        }
        self.textViewHeight = size.height;
    }
    
    
    NSString *lang = [[self.nextResponder textInputMode] primaryLanguage]; // 键盘输入模式
    
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [self markedTextRange];
        //获取高亮部分
        UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (self.text.length > self.maxTextLength) {
                self.text = [self.text substringToIndex:self.maxTextLength];
            }
        }
        // 有高亮选择的字符串，则不对文字进行统计和限制,否则高亮下他输不了字
        else{
            
        }
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else{
        if (self.text.length > self.maxTextLength) {
            self.text = [ self.text substringToIndex:self.maxTextLength];
        }
    }

    
    if (self.Block && self.text.length > self.maxTextLength) {
        self.Block(self);
    }
    
}

-(void)setText:(NSString *)text {
    if (text.length>0) {
        _placeholder_Label.hidden=YES;
    }
    [super setText:text];
}

-(void)setPlaceholder:(NSString *)placeholder {
    if (placeholder.length == 0 || [placeholder isEqualToString:@""]) {
        _placeholder_Label.hidden=YES;
    }
    else {
        _placeholder_Label.text=placeholder;
        _placeholder = placeholder;
    }
}

-(void)setPlaceholder_font:(UIFont *)placeholder_font {
    _placeholder_font=placeholder_font;
    _placeholder_Label.font=placeholder_font;
}

-(void)setPlaceholder_color:(UIColor *)placeholder_color {
    _placeholder_color=placeholder_color;
    _placeholder_Label.textColor=placeholder_color;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
