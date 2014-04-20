//
//  ThumbnailImageData.m
//  TextExtractorPlease
//
//  Created by 石井賢二 on 2014/04/20.
//  Copyright (c) 2014年 NESW. All rights reserved.
//

#import "ThumbnailImageData.h"

@implementation ThumbnailImageData


/*
 URLの配列。実際は任意のサイトからイメージURLを抽出したりする。
 */
- (NSArray *)getImageArray
{
    NSArray *imageArray = @[
                            @"http://free.foto.ne.jp/free/resize.php?image=images/images_big/umi0179-022.jpg",
                            @"http://free.foto.ne.jp/free/resize.php?image=images/images_big/umi0178-022.jpg",
                            @"http://free.foto.ne.jp/free/resize.php?image=images/images_big/umi0176-022.jpg",
                            @"http://free.foto.ne.jp/free/resize.php?image=images/images_big/yuu0100-073.jpg",
                            @"http://free.foto.ne.jp/free/resize.php?image=images/images_big/sor0087-024.jpg",
                            @"http://free.foto.ne.jp/free/resize.php?image=images/images_big/umi0181-073.jpg",
                            @"http://free.foto.ne.jp/free/resize.php?image=images/images_big/umi0163-054.jpg",
                            @"http://free.foto.ne.jp/free/resize.php?image=images/images_big/yuu0054-009.jpg",
                            @"http://free.foto.ne.jp/free/resize.php?image=images/images_big/umi0191-009.jpg",
                            @"http://free.foto.ne.jp/free/resize.php?image=images/images_big/umi0097-024.jpg",
                            @"http://free.foto.ne.jp/free/resize.php?image=images/images_big/odr0004-009.jpg",
                            @"http://free.foto.ne.jp/free/resize.php?image=images/images_big/yuu0059-022.jpg",
                            @"http://free.foto.ne.jp/free/resize.php?image=images/images_big/snw0025-033.jpg",
                            @"http://free.foto.ne.jp/free/resize.php?image=images/images_big/umi0001-001.jpg",
                            @"http://free.foto.ne.jp/free/resize.php?image=images/images_big/umi0057-009.jpg",
                            @"http://free.foto.ne.jp/free/resize.php?image=images/images_big/umi0180-022.jpg",
                            @"http://free.foto.ne.jp/free/resize.php?image=images/images_big/sor0088-024.jpg",
                            @"http://free.foto.ne.jp/free/resize.php?image=images/images_big/yuu0061-002.jpg",
                            @"http://free.foto.ne.jp/free/resize.php?image=images/images_big/umi0135-022.jpg",
                            @"http://free.foto.ne.jp/free/resize.php?image=images/images_big/sor0081-024.jpg"
                            ];
    return imageArray;
}
@end
