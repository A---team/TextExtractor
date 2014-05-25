//
//  CustomTableViewCell.m
//  customcell
//
//  Created by necst on 2014/05/17.
//  Copyright (c) 2014年 necst. All rights reserved.
//

#import "CustomTableViewCell.h"
#import "AppUtility.h"

@implementation CustomTableViewCell{
    CGRect textOriginalFrame;
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
    textOriginalFrame = self.frame;
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
    textOriginalFrame = self.celltextview.frame;
    return self;
}

//- (void)drawRect:(CGRect)rect
//{
//    [super drawRect:rect];
//    
//    CGRect frame = _celltextview.frame;
//    frame.size.height = rect.size.height;
//    
//    _celltextview.frame = frame;
//    _celltextview.scrollEnabled = NO;
//    
//}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGRect frame = _celltextview.frame;
    frame.size.height = rect.size.height;

    
    // イメージを追加
    NSArray *imageArray = [[AppUtility alloc] loadImageData:_celltextview.text];
    UIImage *image = ((imageArray.count > 0) ? [imageArray objectAtIndex:0] : nil);
    
        UIImageView *imageView = nil;
        if (image != nil) {
            imageView = [[UIImageView alloc] initWithImage:image];
            imageView.contentMode = UIViewContentModeScaleToFill;//UIViewContentModeScaleAspectFit;
        }
    
        CGRect ivRect, tvRect;
        if (imageView == nil) {
            tvRect = CGRectMake(50, 2, frame.size.width, frame.size.height);
        } else {
            // イメージが下、文書が上
            tvRect = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height -50);
            ivRect = CGRectMake(frame.origin.x, frame.origin.y + frame.size.height - 50, frame.size.width, 50);
        
            imageView.frame = ivRect;
            [self addSubview:imageView];
        }
    
        UITextView *textView = [[UITextView alloc] initWithFrame:tvRect];
        textView.text = _celltextview.text;
        textView.font = [UIFont systemFontOfSize:14];
        textView.editable = NO;
        textView.selectable = YES;
        textView.dataDetectorTypes = UIDataDetectorTypeAll;
        // StoryBoardではDefaultで付与されているもの。が、背景は白のほうがよいか
        // textView.backgroundColor = [UIColor groupTableViewBackgroundColor];

        //textView.frame = frame;
        textView.scrollEnabled = NO;
    
        [self addSubview:textView];

}

- (CGRect)getOriginalFrame
{
    return textOriginalFrame;
}


@end
