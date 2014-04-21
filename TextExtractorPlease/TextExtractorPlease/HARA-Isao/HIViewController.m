//
//  HIViewController.m
//  TextExtractorPlease
//
//  Created by Isao HARA on 2014/04/13.
//  Copyright (c) 2014年 NESW. All rights reserved.
//

#import "HIViewController.h"

@interface HIViewController ()

@property (weak, nonatomic) IBOutlet UITextField *anyText;
@property (weak, nonatomic) IBOutlet UITextView *copiedText;
- (IBAction)copying:(UIButton *)sender;
- (IBAction)tapped:(UITapGestureRecognizer *)sender;

@end

@implementation HIViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)copying:(UIButton *)sender
{
    _copiedText.text = _anyText.text;
}

- (IBAction)tapped:(UITapGestureRecognizer *)sender
{
    [self.view endEditing:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"toTextViews"]) {
        [[segue destinationViewController] setDelegate:self];
    }
}

- (void)hiTextViewsViewControllerDidFinish:(HITextViewsViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
