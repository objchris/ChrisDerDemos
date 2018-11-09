//
//  ViewController.m
//  EZHeartForLike
//
//  Created by 阿澤🍀 on 16/5/4.
//  Copyright © 2016年 阿澤. All rights reserved.
//

#import "ViewController.h"
#import "TweetTableViewCell.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tweetTableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tweetTableView.delegate = self;
    self.tweetTableView.dataSource = self;
}

# pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TweetTableViewCell *twTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    if (!twTableViewCell) {
        twTableViewCell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([TweetTableViewCell class]) owner:nil options:nil] lastObject];
    } 
    twTableViewCell.tweetImageName = [NSString stringWithFormat:@"%ld", indexPath.row + 1];
    return twTableViewCell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 285;
}


@end
