//
//  DreamViewController.m
//  DreamListObjc
//
//  Created by Rayhan Janam on 6/19/18.
//  Copyright © 2018 Rayhan Janam. All rights reserved.
//

#import "DreamViewController.h"
#import "AppDelegate.h"

@interface DreamViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIView *dataView;

- (IBAction)saveTapped:(id)sender;
- (IBAction)cameraTapped:(id)sender;

@end

@implementation DreamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.isEditing && self.dreamItem) {
        DreamImage *img = self.dreamItem.image;
        self.imageView.image = (UIImage *)img.image;
        self.dreamDataVC.dreamTitle = self.dreamItem.title;
        self.dreamDataVC.dreamPrice = self.dreamItem.price.stringValue;
        self.dreamDataVC.dreamDetails = self.dreamItem.details;
        
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.navigationItem.title = @"edit dream";
    }
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:@"SegueDreamDataViewController"]) {

        DreamDataViewController *dataVC = (DreamDataViewController *)segue.destinationViewController;

        if (dataVC) {
            self.dreamDataVC = dataVC;
        }
    }

}

#pragma mark - IBActions

- (IBAction)saveTapped:(id)sender {
    
    NSString *dreamTitle = self.dreamDataVC.dreamTitle;
    NSString *dreamDetails = self.dreamDataVC.dreamDetails;
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    
    NSNumber *dreamPrice = [formatter numberFromString:self.dreamDataVC.dreamPrice];
    
    if (dreamTitle && dreamPrice && dreamDetails) {
        
        if (self.isEditing) {
            if (self.dreamItem) {
                self.dreamItem.title = dreamTitle;
                self.dreamItem.price = (NSDecimalNumber *)dreamPrice;
                self.dreamItem.details = dreamDetails;
                self.dreamItem.image.image = (UIImage *)self.imageView.image;
                
                [AppDelegate.sharedDelegate saveContext];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
        else {
            [self saveToCoreDataWithImage:self.imageView.image title:dreamTitle price:dreamPrice details:dreamDetails];
        }
    }
    else {
        UIAlertController *errorAlertController = [UIAlertController alertControllerWithTitle:@"Error" message:@"Please fill up all the data correctly" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
        
        [errorAlertController addAction:okAction];
        [self presentViewController:errorAlertController animated:YES completion:nil];
    }
}

- (IBAction)cameraTapped:(id)sender {
    
    UIAlertController *imageSourceModeController = [UIAlertController alertControllerWithTitle:nil message:@"Choose a picture from your library or take new" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *albumAction = [UIAlertAction actionWithTitle:@"From Photo Album" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self presentImagePickerControllerWithType:(UIImagePickerControllerSourceTypePhotoLibrary)];
        
    }];
    
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"From Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self presentImagePickerControllerWithType:(UIImagePickerControllerSourceTypeCamera)];
        
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    [imageSourceModeController addAction:albumAction];
    [imageSourceModeController addAction:cameraAction];
    [imageSourceModeController addAction:cancelAction];
    
    [self presentViewController:imageSourceModeController animated:YES completion:nil];
}

#pragma mark - private methods

- (void) presentImagePickerControllerWithType:(UIImagePickerControllerSourceType)sourceType {
    
    if ([UIImagePickerController isSourceTypeAvailable:sourceType]) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        
        imagePicker.delegate = self;
        imagePicker.allowsEditing = NO;
        imagePicker.sourceType = sourceType;
        
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
    
}

- (void)saveToCoreDataWithImage:(UIImage *)image title:(NSString *)title price:(NSNumber *)price details:(NSString *)details {
    
    DreamItem *item = [[DreamItem alloc] initWithContext:AppDelegate.managedContext];
    DreamImage *img = [[DreamImage alloc] initWithContext:AppDelegate.managedContext];
    
    img.image = image;
    
    item.title = title;
    item.price = (NSDecimalNumber *)price;
    item.details = details;
    item.image = img;
    
    [AppDelegate.sharedDelegate saveContext];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UIImagePickerViewDelegate Methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    UIImage *selectedImage = (UIImage *)info[UIImagePickerControllerOriginalImage];
    
    self.imageView.image = selectedImage;
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.clipsToBounds = YES;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end





















