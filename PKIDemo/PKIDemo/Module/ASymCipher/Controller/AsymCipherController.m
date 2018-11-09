//
//  AsymCipherController.m
//  PKIDemo
//
//  Created by ezfen on 16/4/19.
//  Copyright © 2016年 ezfen. All rights reserved.
//

#import "AsymCipherController.h"
#import "AsymCipherDetailController.h"

@interface AsymCipherController() <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *asymCipherFunTableView;
@property (strong, nonatomic) NSArray *funcArray;
@property (nonatomic) NSInteger selectedIndex;
@end

@implementation AsymCipherController

- (NSArray *)funcArray {
    if (!_funcArray) {
        _funcArray = @[@"RSA"];
    }
    return _funcArray;
}

- (void)viewDidLoad {
    self.asymCipherFunTableView.dataSource = self;
    self.asymCipherFunTableView.delegate = self;
}


- (void)prepareForSegue:(nonnull UIStoryboardSegue *)segue sender:(nullable id)sender {
    ((AsymCipherDetailController *)segue.destinationViewController).funClass = self.selectedIndex;
    ((AsymCipherDetailController *)segue.destinationViewController).title = self.funcArray[self.selectedIndex];
}

# pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(nonnull UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.funcArray.count;
}

- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Func"];
    NSString *funcName = self.funcArray[indexPath.row];
    cell.textLabel.text = funcName;
    return cell;
}

# pragma mark - UITableViewDelegate
- (void)tableView:(nonnull UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    self.selectedIndex = indexPath.row;
    [self performSegueWithIdentifier:@"AsymCipherDetail" sender:nil];
}

@end
