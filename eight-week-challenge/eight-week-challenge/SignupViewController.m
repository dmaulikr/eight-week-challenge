//
//  SignupViewController.m
//  eight-week-challenge
//
//  Created by Kyle Hillman on 5/16/17.
//  Copyright © 2017 Kyle Hillman. All rights reserved.
//

#import "SignupViewController.h"

@import AFNetworking;

@interface SignupViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *heightField;
@property (weak, nonatomic) IBOutlet UITextField *weightField;
@property (weak, nonatomic) IBOutlet UITextField *dobField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIImageView *profilePic;

@end

@implementation SignupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}

- (IBAction)signupButtonPressed:(id)sender {
    
    NSDictionary *params = @{@"email": self.emailField.text, @"password": self.passwordField.text, @"name": self.nameField.text, @"height": self.heightField.text, @"weight": self.weightField.text, @"dob": self.dobField.text};
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params options:0 error:nil];
    NSString *json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSDictionary *dict = @{@"userProfile":json};
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:@"https://effortmanager-staging.herokuapp.com/api/user/signup" parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"JSON: %@", uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"JSON: %@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSString *myString = [[NSString alloc] initWithData:task encoding:NSUTF8StringEncoding];
        NSLog(@"Error: %@", error);
    }];
}

- (IBAction)viewTapped:(id)sender {
    [[self view] endEditing:YES];
}
- (IBAction)picPressed:(id)sender {
    NSLog(@"pic is tapped");
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePicker animated:YES completion:NULL];
}


- (IBAction)historyButtonPressed:(id)sender {
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *selectedImage = info[UIImagePickerControllerEditedImage];
    self.profilePic.image = selectedImage;
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

@end