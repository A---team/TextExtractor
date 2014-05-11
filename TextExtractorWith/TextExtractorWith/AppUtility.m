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

// テキスト(文字列)からURLを抽出
+ (NSArray *)extractURLFromText:(NSString *)text
{
    NSArray *urls;

    // テスト用データ
    urls = @[@"https://www.apple.com/jp/iphone-5s/home/images/routing_hero.png", @"https://www.apple.com/jp/iphone-5s/home/images/ilife_hero.jpg", @"https://www.apple.com/jp/iphone-5s/home/images/hero_hero_mba_11.png"];

    return urls;
}

@end
