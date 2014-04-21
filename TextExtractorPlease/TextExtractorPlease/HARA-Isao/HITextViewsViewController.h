//
//  HITextViewsViewController.h
//  TextExtractorPlease
//
//  Created by Isao HARA on 2014/04/21.
//  Copyright (c) 2014年 NESW. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HITextViewsViewController;

@protocol HITextViewsViewControllerDelegate
- (void)hiTextViewsViewControllerDidFinish:(HITextViewsViewController *)controller;
@end

@interface HITextViewsViewController : UIViewController
@property (weak, nonatomic) id<HITextViewsViewControllerDelegate> delegate;
- (IBAction)done:(UIButton *)sender;
@end
