//
//  AppUtility.m
//  TextExtractorWith
//
//  Created by Isao HARA on 2014/05/11.
//  Copyright (c) 2014年 NESW. All rights reserved.
//

// アプリケーションのユーティリティクラス

#import "AppUtility.h"

@implementation AppUtility

#pragma mark - Inner Method


//****************************************************************
// URLからデータを取得し、取得したデータ配列を返却する
// 今回の例では先頭の1つしか画像は利用しないため１つ詰めると終了する。
// 本当は複数個でたり、エラーが発生した場合は次のURL取得をし成功した最初の1つを返す、などの実装が必要
- (NSMutableArray *)loadImageData:(NSString *)input
{
    NSMutableArray *muArray = [NSMutableArray array];
    NSArray *urlArray = [self extractImageURLs:input];
    for (int i=0; i < urlArray.count; i++) {
        NSData *dt = [NSData dataWithContentsOfURL: [NSURL URLWithString:[urlArray objectAtIndex:i]]];
        [muArray addObject:[[UIImage alloc] initWithData:dt]];
        break; // 現状は１つ詰めると抜ける
    }
    return muArray;
}

//****************************************************************
// 投稿内容から画像URLを(文字列の配列として)抽出
- (NSArray *)extractImageURLs:(NSString *)input
{
    NSString *text = input;
    NSArray *urls = [AppUtility extractImageURLsFromText:text];
    return urls;
}


//****************************************************************
// テキスト(文字列)からURLを抽出
+ (NSArray *)extractURLsFromText:(NSString *)text
{
    // URL抽出用の正規表現
    NSString *pattern = @"(https?|ftp)(://[-_.!~*\'()a-zA-Z0-9;¥/?:@&=+¥$,%#]+)";
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:&error];

    // URL部分を抽出
    NSMutableArray *urls = [NSMutableArray array];
    NSArray *results = [regex matchesInString:text options:0 range:NSMakeRange(0, text.length)];
    for (NSTextCheckingResult *result in results) {
        NSString *url = [text substringWithRange:[result rangeAtIndex:0]];
        [urls addObject:url];
    }

    return [NSArray arrayWithArray:urls];
}

//****************************************************************
// テキスト(文字列)から画像URLを抽出
+ (NSArray *)extractImageURLsFromText:(NSString *)text
{
    // 対象とする拡張子
    NSArray *exts = @[@"png", @"jpeg", @"jpg", @"tiff", @"tif", @"pict", @"pic", @"pct", @"gif", @"bmp", @"dib", @"ico", @"wmf"];

    // URL部分を抽出
    NSMutableArray *imageUrls = [NSMutableArray array];
    NSArray *urls = [AppUtility extractURLsFromText:text];
    for (NSString *url in urls) {
        NSString *ext = [[url pathExtension] lowercaseString];
        if ([exts containsObject:ext]) {
            // 画像URLだった場合
            [imageUrls addObject:url];
        }
    }

    return [NSArray arrayWithArray:imageUrls];
}

@end
