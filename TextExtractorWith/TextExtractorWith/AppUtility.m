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
