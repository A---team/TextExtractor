//
//  TableViewCell.m
//  TextExtractorWith
//
//  Created by 石井賢二 on 2014/05/18.
//  Copyright (c) 2014年 NESW. All rights reserved.
//

#import "TableViewCell.h"
#import <AFNetworking.h>

@implementation TableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    NSLog(@"start customCell initializer");
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        //メインテキスト
        self.titleLabel  = [[UILabel alloc] initWithFrame:CGRectMake(70, 25, 240, 20)];
        self.titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.titleLabel.font = [UIFont systemFontOfSize:10];
        self.titleLabel.numberOfLines = 1;
        self.titleLabel.textAlignment = UIControlContentHorizontalAlignmentRight;
        self.titleLabel.textColor = [UIColor grayColor];
        
        //ドキュメントによると、self.contentViewに追加するのが正しいとコメントいただきました。
        [self.contentView addSubview:self.titleLabel];
        
        //オリジナルのtextLabel
        self.textLabel.font = [UIFont systemFontOfSize:15];
        self.textLabel.numberOfLines = 1;
        
        //オリジナルのImageView
        //self.imageView.contentMode = UIViewContentModeScaleToFill;

    }
    
    //レイアウトをアップデート
    [self layoutSubviews];
    
    return self;
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
             self.imageView.image = (UIImage *)responseObject;
             [self setNeedsLayout];
             
         } failure:^(NSURLSessionDataTask *task, NSError *error) {
             // エラーの場合はエラーの内容をコンソールに出力する
             NSLog(@"Error: %@", error);
         }];
}
- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
