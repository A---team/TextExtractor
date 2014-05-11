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

// テキスト(文字列)からURLを抽出
+ (NSArray *)extractURLFromText:(NSString *)text;

@end


