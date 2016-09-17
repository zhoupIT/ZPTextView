//
//  ZPTextView.h
//  ZPTextView
//
//  Created by peng on 16/9/14.
//  Copyright © 2016年 IDevent.inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZPTextView : UITextView
/** 占位字符 */
@property (nonatomic,copy) NSString *placeholder;
/** 内容的最大长度设置 */
@property(assign,nonatomic) NSInteger maxTextLength;
/** 更新textView的高度 */
@property(assign,nonatomic) float textViewHeight;
/** 自适应高度 */
@property (nonatomic,assign) BOOL isAdaptiveHeight;
/**
 *  内容长度限制的回调
 *
 *  @param maxLength
 *  @param limit
 */
-(void)addMaxTextLengthWithMaxLength:(NSInteger)maxLength andEvent:(void(^)(ZPTextView *text))limit;
/**
 *  开始编辑的回调
 *
 *  @param begin
 */
-(void)addTextViewBeginEvent:(void(^)(ZPTextView *text))begin;

/**
 *  结束编辑的回调
 *
 *  @param begin
 */
-(void)addTextViewEndEvent:(void(^)(ZPTextView *text))End;

/**
 *  设置Placeholder颜色
 *
 *  @param color
 */
-(void)setPlaceholderColor:(UIColor *)color;

/**
 *  设置Placeholder字体
 *
 *  @param font
 */
-(void)setPlaceholderFont:(UIFont *)font;

/**
 *  设置透明度
 *
 *  @param opacity
 */
-(void)setPlaceholderOpacity:(float)opacity;


@end
