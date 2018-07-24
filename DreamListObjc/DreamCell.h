//
//  DreamCell.h
//  DreamListObjc
//
//  Created by Rayhan Janam on 6/19/18.
//  Copyright © 2018 Rayhan Janam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DreamItem+CoreDataProperties.h"
#import "DreamImage+CoreDataProperties.h"

@interface DreamCell : UITableViewCell

- (void)configureCellWithItem:(DreamItem *)dreamItem;

@end
