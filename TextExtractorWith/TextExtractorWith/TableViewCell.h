//
//  TableViewCell.h
//  TextExtractorWith
//
//  Created by 石井賢二 on 2014/05/18.
//  Copyright (c) 2014年 NESW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell
@property   UILabel *titleLabel;

- (void) downloadThumbnail:(NSString *)displayContents;
@end
