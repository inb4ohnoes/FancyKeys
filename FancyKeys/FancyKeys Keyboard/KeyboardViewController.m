//
//  KeyboardViewController.m
//  FancyKeys Keyboard
//
//  Created by Brian Tung on 6/28/14.
//  Copyright (c) 2014 Flame Co. All rights reserved.
//

#import "KeyboardViewController.h"

@interface KeyboardViewController ()
@property (nonatomic, strong) UIButton *nextKeyboardButton, *lennyFaceButton;
@end

@implementation KeyboardViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Perform custom initialization work here
    }
    return self;
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    
    // Add custom view sizing constraints here
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Perform custom UI setup here
    //mandatory next keyboard button
    self.nextKeyboardButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.nextKeyboardButton.backgroundColor = [UIColor whiteColor];
    self.nextKeyboardButton.layer.cornerRadius = 5.f;
    self.nextKeyboardButton.clipsToBounds = YES;
    
    [self.nextKeyboardButton setTitle:NSLocalizedString(@"Next Keyboard", @"Title for 'Next Keyboard' button") forState:UIControlStateNormal];
    [self.nextKeyboardButton sizeToFit];
    self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.nextKeyboardButton addTarget:self action:@selector(advanceToNextInputMode) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.nextKeyboardButton];
    
    NSLayoutConstraint *nextKeyboardButtonLeftSideConstraint = [NSLayoutConstraint constraintWithItem:self.nextKeyboardButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0];
    NSLayoutConstraint *nextKeyboardButtonBottomConstraint = [NSLayoutConstraint constraintWithItem:self.nextKeyboardButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
    [self.view addConstraints:@[nextKeyboardButtonLeftSideConstraint, nextKeyboardButtonBottomConstraint]];
    
    //the only button we will ever need
    self.lennyFaceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.lennyFaceButton.backgroundColor = [UIColor whiteColor];
    self.lennyFaceButton.layer.cornerRadius = 5.f;
    self.lennyFaceButton.clipsToBounds = YES;
    
    [self.lennyFaceButton setTitle:@"( ͡° ͜ʖ ͡°)" forState:UIControlStateNormal];
    [self.lennyFaceButton sizeToFit];
    self.lennyFaceButton.translatesAutoresizingMaskIntoConstraints = YES;
    
    [self.lennyFaceButton addTarget:self action:@selector(pressedLennyFace) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.lennyFaceButton];
    
    //Have I ever told you the story of how much i fucking have autolayout?
    self.lennyFaceButton.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin);
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated
}

- (void)pressedLennyFace
{
    [self.textDocumentProxy insertText:@"( ͡° ͜ʖ ͡°)"];
}

- (void)textWillChange:(id<UITextInput>)textInput {
    // The app is about to change the document's contents. Perform any preparation here.
}

- (void)textDidChange:(id<UITextInput>)textInput {
    // The app has just changed the document's contents, the document context has been updated.
    
    UIColor *textColor = nil;
    if (self.textDocumentProxy.keyboardAppearance == UIKeyboardAppearanceDark) {
        textColor = [UIColor whiteColor];
    } else {
        textColor = [UIColor blackColor];
    }
    [self.nextKeyboardButton setTitleColor:textColor forState:UIControlStateNormal];
    [self.lennyFaceButton setTitleColor:textColor forState:UIControlStateNormal];
}

@end
