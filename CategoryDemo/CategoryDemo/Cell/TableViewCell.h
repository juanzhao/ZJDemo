//
//  TableViewCell.h
//  CategoryDemo
//
//  Created by ZJ  on 2018/1/29.
//  Copyright © 2018年 XXX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *defaultImage;
@property (weak, nonatomic) IBOutlet UIView *lineView;

@end
