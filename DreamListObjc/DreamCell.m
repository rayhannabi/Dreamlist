//
//  DreamCell.m
//  DreamListObjc
//
//  Created by Rayhan Janam on 6/19/18.
//  Copyright © 2018 Rayhan Janam. All rights reserved.
//

#import "DreamCell.h"

@interface DreamCell()

@property (weak, nonatomic) IBOutlet UIImageView *thumbImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@end

@implementation DreamCell

- (void)configureCellWithItem:(DreamItem *)dreamItem {
    
    DreamImage *img = (DreamImage *)dreamItem.image;
    NSString *title = dreamItem.title;
    NSNumber *price = dreamItem.price;
    NSString *details = dreamItem.details;
    
    if (img) {
        self.thumbImageView.image = (UIImage *)img.image;
    }
    self.titleLabel.text = title;
    self.priceLabel.text = price.stringValue;
    self.descriptionLabel.text = details;
    
}

@end










