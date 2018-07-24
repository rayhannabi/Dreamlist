//
//  DreamDataViewController.m
//  DreamListObjc
//
//  Created by Rayhan Janam on 6/19/18.
//  Copyright © 2018 Rayhan Janam. All rights reserved.
//

#import "DreamDataViewController.h"

@interface DreamDataViewController ()

@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UITextField *priceField;
@property (weak, nonatomic) IBOutlet UITextView *detailsTextView;

@property (assign, nonatomic) CGFloat dynamicHeight;

@end

@implementation DreamDataViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.detailsTextView.text = @"Give an illusive detail";
    self.detailsTextView.textColor = UIColor.lightGrayColor;
    self.detailsTextView.delegate = self;
}

#pragma mark - getters

- (NSString *)dreamTitle {
    return self.titleField.text;
}

- (void)setDreamTitle:(NSString *)dreamTitle {
    self.titleField.text = dreamTitle;
}

- (NSString *)dreamPrice {
    return self.priceField.text;
}

- (void)setDreamPrice:(NSString *)dreamPrice {
    self.priceField.text = dreamPrice;
}

- (NSString *)dreamDetails {
    return self.detailsTextView.text;
}

- (void)setDreamDetails:(NSString *)dreamDetails {
    self.detailsTextView.text = dreamDetails;
    [self updateTextView:self.detailsTextView];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 2 && self.dynamicHeight > 45) {
        return self.dynamicHeight;
    }
    
    return 45;
    
}

#pragma mark - TextViewDelegate methods

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    
    if (textView.textColor == UIColor.lightGrayColor) {
        textView.text = @"";
        textView.textColor = UIColor.blackColor;
    }
    
    return YES;
    
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    
    if (textView.text.length == 0) {
        textView.text = @"Give an illusive detail";
        textView.textColor = UIColor.lightGrayColor;
    }
}

- (void)updateTextView:(UITextView * _Nonnull)textView {
    CGSize fitSize = [textView sizeThatFits:CGSizeMake(textView.frame.size.width, CGFLOAT_MAX)];
    self.dynamicHeight = fitSize.height;
    
    if (self.dynamicHeight > 45) {
        
        [UIView setAnimationsEnabled:NO];
        [self.tableView beginUpdates];
        [self.tableView endUpdates];
        [UIView setAnimationsEnabled:YES];
        
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:FALSE];
    }
}

- (void)textViewDidChange:(UITextView *)textView {
    
    self.dreamDetails = textView.text;
    
    [self updateTextView:textView];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {

    if ([text isEqual: @"\n"]) {
        [textView resignFirstResponder];
        [textView scrollRangeToVisible:NSMakeRange(0, 0)];
        return false;
    }
    
    return true;
    
}

@end



