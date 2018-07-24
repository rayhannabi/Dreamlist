//
//  DreamDataViewController.h
//  DreamListObjc
//
//  Created by Rayhan Janam on 6/19/18.
//  Copyright © 2018 Rayhan Janam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DreamDataViewController : UITableViewController <UITextViewDelegate>

@property (assign, nonatomic) NSString *dreamTitle;
@property (assign, nonatomic) NSString *dreamPrice;
@property (assign, nonatomic) NSString *dreamDetails;

@end
