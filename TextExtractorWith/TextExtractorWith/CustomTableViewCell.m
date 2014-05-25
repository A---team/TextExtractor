//
//  CustomTableViewCell.m
//  customcell
//
//  Created by necst on 2014/05/17.
//  Copyright (c) 2014年 necst. All rights reserved.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell{
    CGRect originalFrame;
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
    originalFrame = self.frame;
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
    originalFrame = self.frame;
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGRect frame = _celltextview.frame;
    frame.size.height = rect.size.height;
    
    _celltextview.frame = frame;
    _celltextview.scrollEnabled = NO;
    
}

- (CGRect)getOriginalFrame
{
    return originalFrame;
}


@end
