//
//  DreamViewController.h
//  DreamListObjc
//
//  Created by Rayhan Janam on 6/19/18.
//  Copyright © 2018 Rayhan Janam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DreamDataViewController.h"
#import "DreamItem+CoreDataProperties.h"
#import "DreamImage+CoreDataProperties.h"

@interface DreamViewController : UIViewController <UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (assign, nonatomic) DreamDataViewController *dreamDataVC;
@property (assign, nonatomic) DreamItem *dreamItem;
@property (assign, nonatomic) BOOL isEditing;

@end
