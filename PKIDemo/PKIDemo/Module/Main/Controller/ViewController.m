//
//  ViewController.m
//  PKIDemo
//
//  Created by ezfen on 16/4/7.
//  Copyright © 2016年 ezfen. All rights reserved.
//

#import "ViewController.h"
#import "MainEffectView.h"
#import "KeyPairDispatchController.h"
#import "KeyPairGenerator.h"

#import "HMacActor.h"

@interface ViewController () <MainEffectViewDelegate>
@property (nonatomic) NSInteger buttonTag;
@end

@implementation ViewController

# pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    MainEffectView *mainEffectView = [[MainEffectView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    mainEffectView.delegate = self;
    [self.view addSubview:mainEffectView];
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clickButtonTag:(NSInteger)tag inView:(MainEffectView *)view {
    self.buttonTag = tag;
    switch (tag) {
        case 0:{
            [self performSegueWithIdentifier:@"SymCipher" sender:nil];
        }
        break;
        case 1:
        case 4:
        case 5:
        {
            [self performSegueWithIdentifier:@"Dispatch" sender:nil];
        }
        break;
        case 2:{
            [self performSegueWithIdentifier:@"HMac" sender:nil];
        }
        break;
        case 3:{
            [self performSegueWithIdentifier:@"PwdCipher" sender:nil];
        }
        break;
        default:
            break;
    }
}

- (void)prepareForSegue:(nonnull UIStoryboardSegue *)segue sender:(nullable id)sender {
    self.navigationController.navigationBarHidden = NO;
    if ([segue.identifier isEqualToString:@"Dispatch"]) {
        NSString *identifier = nil;
        switch (self.buttonTag) {
            case 1:
                identifier = @"AsymCipher";
                break;
            case 4:
                identifier = @"Digest";
                break;
            case 5:
                identifier = @"Signature";
                break;
            default:
                break;
        }
        ((KeyPairDispatchController *)segue.destinationViewController).segueIdentifier = identifier;
    }
}



@end
