//
//  SymCipherController.m
//  PKIDemo
//
//  Created by ezfen on 16/4/18.
//  Copyright © 2016年 ezfen. All rights reserved.
//

#import "SymCipherController.h"
#import "SymCipherDetailController.h"

@interface SymCipherController() <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *cipherFuncTableView;
@property (strong, nonatomic) NSArray *funcArray;
@property (nonatomic) NSInteger selectedIndex;
@end

@implementation SymCipherController

- (NSArray *)funcArray {
    if (!_funcArray) {
        _funcArray = @[@"DES",@"AES",@"RC4"];
    }
    return _funcArray;
}

- (void)viewDidLoad {
    self.cipherFuncTableView.dataSource = self;
    self.cipherFuncTableView.delegate = self;
}

- (void)prepareForSegue:(nonnull UIStoryboardSegue *)segue sender:(nullable id)sender {
    ((SymCipherDetailController *)segue.destinationViewController).funClass = self.selectedIndex;
    ((SymCipherDetailController *)segue.destinationViewController).title = self.funcArray[self.selectedIndex];
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
    [self performSegueWithIdentifier:@"SymCipher" sender:nil];
}
@end
