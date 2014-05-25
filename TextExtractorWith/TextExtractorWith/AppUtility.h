//
//  AppUtility.h
//  TextExtractorWith
//
//  Created by Isao HARA on 2014/05/11.
//  Copyright (c) 2014年 NESW. All rights reserved.
//

// アプリケーションのユーティリティクラス

#import <Foundation/Foundation.h>

@interface AppUtility : NSObject

// URLからデータを取得し、取得したデータ配列を返却する
- (NSMutableArray *)loadImageData:(NSString *)input;

// テキスト(文字列)からURLを抽出
+ (NSArray *)extractURLsFromText:(NSString *)text;

// テキスト(文字列)から画像URLを抽出
+ (NSArray *)extractImageURLsFromText:(NSString *)text;

@end


