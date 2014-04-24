//
//  ViewController.m
//  TextExtractorWith
//
//  Created by Isao HARA on 2014/04/24.
//  Copyright (c) 2014年 NESW. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *source;
@property (weak, nonatomic) IBOutlet UITextView *expression;
- (IBAction)submit:(UIButton *)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submit:(UIButton *)sender
{
}
@end
