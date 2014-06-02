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

#define IMAGE_WIDTH			50
#define IMAGE_HEIGHT		50

@implementation CustomTableViewCell{
    CGRect textOriginalFrame;
    CGRect ivRect, tvRect, svRect;
    UIScrollView *scrollView;
    NSInteger pageNum;
    NSInteger lastIndex;
    NSMutableArray *imageArray;
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
    pageNum = 0;
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
        for (NSInteger i = 0; imgArray.count >i; i++) {
            [self downloadThumbnail:[imgArray objectAtIndex:i] index:i];
        }
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
    scrollView.delegate = self;
    scrollView.showsHorizontalScrollIndicator = YES;
    [self addSubview:scrollView];

}

- (CGRect)getOriginalFrame
{
    return textOriginalFrame;
}

- (void) downloadThumbnail:(NSString *)displayContents index:(NSInteger)index
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
             ivRect = CGRectMake(50*index, 0, 50, 50);
             UIImageView *imageView = [[UIImageView alloc] initWithFrame:ivRect];
             imageView.image = (UIImage *)responseObject;
             imageView.contentMode = UIViewContentModeScaleToFill;
             
             float imgContentsSize = scrollView.contentSize.width;
//             scrollView.contentSize = CGSizeMake(imgContentsSize + 55, 50);
             scrollView.contentSize = CGSizeMake(imgContentsSize + 200, 50); //ここを大きくしないと循環スクロールのときにエラーになる

             [scrollView addSubview:imageView];
             
             // 循環スクロール用に情報を保持
             if(imageArray == nil){
                 imageArray = [NSMutableArray array];
             }
             [imageArray addObject:imageView];
             lastIndex = index > lastIndex ? index : lastIndex;
             
             NSLog(@"setNeedsLayout");
             [self setNeedsLayout];
             
         } failure:^(NSURLSessionDataTask *task, NSError *error) {
             // エラーの場合はエラーの内容をコンソールに出力する
             NSLog(@"Error: %@", error);
         }];
}

# pragma UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView2
{
    // 現在の表示位置（左上）のx座標とUIScrollViewの表示幅(320px)を
    // 用いて現在のページ番号を計算します。
    CGPoint offset = scrollView2.contentOffset;
    int page = (offset.x)/ IMAGE_WIDTH;
    if(pageNum == page){
        return;
    }
    
    if(page > 0){
        NSLog(@"page : %d", page);
        NSLog(@"pageNum : %d", pageNum);
        
        NSInteger num = pageNum % imageArray.count;
        //左にスワイプ（右にスクロールした場合）
        UIImageView *img = [imageArray objectAtIndex:num];
        img.frame = CGRectMake(50*lastIndex+1, 0, 50, 50);
        [scrollView addSubview:img];
        lastIndex++;
        pageNum++;
    }else{
        //右にスワイプ（左にスクロールした場合
    }
    
    
}

@end
