//
//  CustomTableViewCell.m
//  customcell
//
//  Created by necst on 2014/05/17.
//  Copyright (c) 2014年 necst. All rights reserved.
//

#import "CustomTableViewCell.h"
#import "AppUtility.h"
#import <AFNetworking.h>

@implementation CustomTableViewCell{
    CGRect textOriginalFrame;
    CGRect ivRect, tvRect, svRect;
    UIScrollView *scrollView;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    
    return self;
    
}

- (void)awakeFromNib
{
    // Initialization code
    textOriginalFrame = self.frame;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];;
    // Configure the view for the selected state
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    textOriginalFrame = self.celltextview.frame;
    return self;
}

- (void)drawRect:(CGRect)rect
{
    NSLog(@"drawRect");
    [super drawRect:rect];
    
    CGRect frame = _celltextview.frame;
    frame.size.height = rect.size.height;

    // 表示するサムネイルがあるか
    BOOL isExistImage = false;
    
    // 表示するサムネイルがあれば取得に行く
    NSArray *imgArray = [AppUtility extractImageURLsFromText:_celltextview.text];
    if (imgArray.count > 0) {
        [self downloadThumbnail:[imgArray objectAtIndex:0]];
        isExistImage = true;
    }

    // サムネイルがある場合は画像領域を確保しておく。
    if (!isExistImage) {
        tvRect = CGRectMake(50, 2, frame.size.width, frame.size.height);
    } else {
        tvRect = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height -50);
        svRect = CGRectMake(frame.origin.x, frame.origin.y + frame.size.height - 50, frame.size.width, 50);
    }

    UITextView *textView = [[UITextView alloc] initWithFrame:tvRect];
    textView.text = _celltextview.text;
    textView.font = [UIFont systemFontOfSize:14];
    textView.editable = NO;
    textView.selectable = YES;
    textView.dataDetectorTypes = UIDataDetectorTypeAll;
    textView.scrollEnabled = NO;
    [self addSubview:textView];
    
    scrollView = [[UIScrollView alloc] initWithFrame:svRect];
    [self addSubview:scrollView];

}

- (CGRect)getOriginalFrame
{
    return textOriginalFrame;
}

- (void) downloadThumbnail:(NSString *)displayContents
{
    NSLog(@"start AFNetworking");
    // AFHTTPSessionManagerを利用して、http://localhost/test.jsonからJSONデータを取得する
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager setResponseSerializer:[AFImageResponseSerializer serializer]];
    
    [manager GET:displayContents
      parameters:nil
         success:^(NSURLSessionDataTask *task, id responseObject) {
             // 通信に成功した場合の処理
             NSLog(@"responseObject: %@", responseObject);
             ivRect = CGRectMake(0, 0, 50, 50);
             UIImageView *imageView = [[UIImageView alloc] initWithFrame:ivRect];
             imageView.image = (UIImage *)responseObject;
             imageView.contentMode = UIViewContentModeScaleToFill;
             [scrollView addSubview:imageView];

             NSLog(@"setNeedsLayout");
             [self setNeedsLayout];
             
         } failure:^(NSURLSessionDataTask *task, NSError *error) {
             // エラーの場合はエラーの内容をコンソールに出力する
             NSLog(@"Error: %@", error);
         }];
}

@end
