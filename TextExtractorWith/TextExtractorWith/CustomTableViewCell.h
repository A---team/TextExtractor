//
//  CustomTableViewCell.h
//  customcell
//
//  Created by necst on 2014/05/18.
//  Copyright (c) 2014年 necst. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *cellImage;
@property (weak, nonatomic) IBOutlet UITextView *celltextview;
- (CGRect)getOriginalFrame;

@end
