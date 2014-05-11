//
//  CellView.m
//  Thumbnail
//
//  Created by 石井賢二 on 2014/04/29.
//  Copyright (c) 2014年 石井賢二. All rights reserved.
//

#import "CellView.h"

@implementation CellView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame withImage:(UIImage *)image withText:(NSString *)text displayType:(NSInteger)type
{
    self = [super initWithFrame:frame];
    
    if (self) {
        // 枠のボーダーを作成
        [[self layer]setBorderColor:[[UIColor grayColor] CGColor]];
        [[self layer]setBorderWidth:0.5f];
        
        // イメージを追加
        UIImageView *imageView = nil;
        if (image != nil) {
            imageView = [[UIImageView alloc] initWithImage:image];
            imageView.contentMode = UIViewContentModeScaleToFill;//UIViewContentModeScaleAspectFit;
        }

        CGRect ivRect, tvRect;
        if (imageView == nil) {
            tvRect = CGRectMake(0, 0, frame.size.width, frame.size.height);
        } else {
            if(type == 0){
                // イメージが左、文書が右
                // 幅は画像は1/3とする
                ivRect = CGRectMake(0, 0, frame.size.width / 3, frame.size.height);
            
                // テキストを追加
                // x : 画像の幅
                // y : 0px
                // width : 全体の幅 - 画像の幅
                // height : 全体の高さ
                tvRect = CGRectMake(ivRect.size.width, 0, frame.size.width - ivRect.size.width, frame.size.height);

            }else if(type == 1){
                // イメージが下、文書が上
                ivRect = CGRectMake(0, frame.size.height * 1/3, frame.size.width, frame.size.height * 2/3);
                tvRect = CGRectMake(0, 0, frame.size.width, frame.size.height / 3);
            }
        
            imageView.frame = ivRect;
            [self addSubview:imageView];
        }
        
        UITextView *textView = [[UITextView alloc] initWithFrame:tvRect];
        textView.text = text;
        textView.font = [UIFont systemFontOfSize:14];
        textView.editable = NO;
        textView.selectable = YES;
        textView.dataDetectorTypes = UIDataDetectorTypeAll;
        // StoryBoardではDefaultで付与されているもの。が、背景は白のほうがよいか
        // textView.backgroundColor = [UIColor groupTableViewBackgroundColor];

        [self addSubview:textView];
    }
    
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
