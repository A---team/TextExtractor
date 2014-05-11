//
//  CellView.h
//  Thumbnail
//
//  Created by 石井賢二 on 2014/04/29.
//  Copyright (c) 2014年 石井賢二. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellView : UIView

/**
 * CellViewの初期化メソッド
 * frame : Cell の frame
 * image : 表示するイメージ
 * text  : 表示するテキスト
 * type  : 表示するタイプ（0: イメージが左でテキストが右, 1: テキストが上でイメージが下）
 */
- (id)initWithFrame:(CGRect)frame withImage:(UIImage *)image withText:(NSString *)text displayType:(NSInteger)type;
@end
