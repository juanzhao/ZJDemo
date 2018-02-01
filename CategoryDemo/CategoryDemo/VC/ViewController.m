//
//  ViewController.m
//  CategoryDemo
//
//  Created by ZJ on 2018/1/29.
//  Copyright © 2018年 XXX. All rights reserved.
//

#import "ViewController.h"
#import "TableViewCell.h"
#import "UIColor+HexColor.h"
#import "CollectionViewCell.h"

#define Start_X  0
#define Center_Value  100
#define NavHeight 66
#define ViewHeight Screen_Height-NavHeight-49
#define Screen_Width [UIScreen mainScreen].bounds.size.width
#define Screen_Height [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NSInteger firstParamer;
    NSInteger secondParamer;
    CGRect firstArrowRect;
    CGRect secondArrowRect;
}
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *firstArray;
@property (nonatomic, strong) NSMutableArray *secondArray;
@property (nonatomic, strong) NSMutableArray *thirdArray;
@property (nonatomic, strong) UITableView *tableView1;
@property (nonatomic, strong) UITableView *tableView2;
@property (nonatomic, strong) UIImageView *arrowImage1;
@property (nonatomic, strong) UIImageView *arrowImage2;
@property (nonatomic, strong) UIView *firstCategoryView;
@property (nonatomic, strong) UIView *secondCategoryView;
@property (nonatomic, assign) BOOL isClickColOnce;
@property (nonatomic, assign) BOOL isClickTabOnce;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self initData];
    
    
}

#pragma mark -- 初始化
- (void)initData
{
    self.firstArray = [[NSMutableArray alloc]init];
    self.secondArray = [[NSMutableArray alloc]init];
    self.thirdArray = [[NSMutableArray alloc]init];
    firstParamer = -1;
    secondParamer = -2;
    
    self.firstArray = [[NSMutableArray alloc]initWithObjects:@"男装",@"女装",@"男鞋",@"女鞋",@"箱包",@"美妆",@"手机数码",@"电脑办公",@"家用电器", nil];
   
    self.secondArray = [[NSMutableArray alloc]initWithObjects:@"时尚男包",@"学生书包",@"拉杆箱",@"钱包",@"手提包",@"帆布包",@"手拿包",@"小方包",@"单肩包", nil];
    
    self.thirdArray = [[NSMutableArray alloc]initWithObjects:@"坚果",@"休闲零食",@"肉甘干肉脯",@"饼干蛋糕",@"蜜饯果干",@"低糖食品",@"新鲜水果",@"新鲜蔬菜",@"饮料", nil];
    
     [self.collectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CollectionViewCell"];
}

#pragma mark -- 二级分类
-(void)createSecondCategory
{
    self.firstCategoryView = [[UIView alloc]initWithFrame:CGRectMake(Screen_Width, NavHeight,Screen_Width-51, ViewHeight)];
    [self.view addSubview:self.firstCategoryView];
    UIPanGestureRecognizer *panGeature = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
    [self.firstCategoryView addGestureRecognizer:panGeature];
    [self.view addSubview:self.firstCategoryView];
    
    self.arrowImage1 = [[UIImageView alloc]initWithFrame:CGRectMake(Screen_Width, firstArrowRect.origin.y+14, 10, 20)];
    self.arrowImage1.image = [UIImage imageNamed:@"Category_Triangle_1"];
    [self.view addSubview:self.arrowImage1];
    
    self.tableView1 = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.firstCategoryView.frame.size.width, self.firstCategoryView.frame.size.height)];
    self.tableView1.delegate = self;
    self.tableView1.dataSource = self;
    self.tableView1.tag = 100;
    self.tableView1.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView1.backgroundColor = [UIColor colorWithHexString:@"EAECEE"];
    [self.tableView1 registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil] forCellReuseIdentifier:@"TableViewCell"];
    
    [self.firstCategoryView addSubview:self.tableView1];
}

- (void)handlePan:(UIPanGestureRecognizer *)panGestureRecognizer
{
    CGPoint translation = [panGestureRecognizer translationInView:self.firstCategoryView];
    //向右滑
    if (translation.x > 0) {
        
        if (self.secondCategoryView.frame.origin.x == Screen_Width) {
            //只有一个第一个view
            self.firstCategoryView.frame = CGRectMake(51+translation.x,NavHeight,Screen_Width-51, ViewHeight);
            self.arrowImage1.frame = CGRectMake(41+translation.x,firstArrowRect.origin.y+14, 10, 20);
            
        }else{
            self.firstCategoryView.frame = CGRectMake(51+translation.x,NavHeight, Screen_Width-51,ViewHeight);
            self.secondCategoryView.frame = CGRectMake(118+translation.x,NavHeight,Screen_Width-118,ViewHeight);
            self.arrowImage1.frame = CGRectMake(41+translation.x,firstArrowRect.origin.y+14, 10, 20);
            self.arrowImage2.frame = CGRectMake(108+translation.x,secondArrowRect.origin.y+14+NavHeight, 10, 20);
        }
    }
    
    if (panGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        
        if (self.secondCategoryView.frame.origin.x == Screen_Width) {
            
            //只有第一个view存在
            [UIView animateWithDuration:0.3 animations:^{
                
                if ((translation.x > Start_X) && (translation.x < Center_Value)) {
                    
                    self.firstCategoryView.frame = CGRectMake(51,NavHeight,Screen_Width-51,ViewHeight);
                    self.arrowImage1.frame = CGRectMake(41,firstArrowRect.origin.y+14, 10, 20);
                    
                }else{
                    
                    self.firstCategoryView.frame = CGRectMake(Screen_Width,NavHeight,Screen_Width-51,ViewHeight);
                    self.arrowImage1.frame = CGRectMake(Screen_Width,firstArrowRect.origin.y+14, 10, 20);
                }
            }];
            
        } else {
            
            //两个view都存在

            if ((translation.x > Start_X) && (translation.x < Center_Value)) {
                
                [UIView animateWithDuration:0.3 animations:^{
                    self.arrowImage1.frame = CGRectMake(41,firstArrowRect.origin.y+14, 10, 20);
                    self.firstCategoryView.frame = CGRectMake(51,NavHeight,Screen_Width-51, ViewHeight);
                    self.secondCategoryView.frame = CGRectMake(118, NavHeight,Screen_Width-118, ViewHeight);
                    self.arrowImage2.frame = CGRectMake(108,secondArrowRect.origin.y+14+66, 10, 20);
                }];
            }else {
                
                [UIView animateWithDuration:0.3 animations:^{
                    self.arrowImage1.frame = CGRectMake(Screen_Width,firstArrowRect.origin.y+14, 10, 20);
                    self.firstCategoryView.frame = CGRectMake(Screen_Width, NavHeight,Screen_Width-51, ViewHeight);
                    self.secondCategoryView.frame = CGRectMake(Screen_Width, NavHeight,Screen_Width-118, ViewHeight);
                    self.arrowImage2.frame = CGRectMake(Screen_Width,secondArrowRect.origin.y+14+NavHeight, 10, 20);
                }];
            }
        }
    }
}

#pragma mark --  三级分类
-(void)createThirdCategory
{
    self.secondCategoryView = [[UIView alloc]initWithFrame:CGRectMake(Screen_Width, NavHeight,Screen_Width-118, ViewHeight)];
    self.secondCategoryView.backgroundColor = [UIColor colorWithHexString:@"e4e4e4"];
    [self.view addSubview:self.secondCategoryView];
    
    UIPanGestureRecognizer *panGeature = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handleSecondPan:)];
    [self.secondCategoryView addGestureRecognizer:panGeature];
    
    self.arrowImage2 = [[UIImageView alloc]initWithFrame:CGRectMake(Screen_Width,secondArrowRect.origin.y+14+NavHeight, 10, 20)];
    self.arrowImage2.image = [UIImage imageNamed:@"Category_Triangle_2"];
    [self.view addSubview:self.arrowImage2];
    
    self.tableView2 = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.secondCategoryView.frame.size.width, self.secondCategoryView.frame.size.height)];
    self.tableView2.delegate = self;
    self.tableView2.dataSource = self;
    self.tableView2.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView2.backgroundColor = [UIColor colorWithHexString:@"99A0A7"];
    [self.tableView2 registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil] forCellReuseIdentifier:@"TableViewCell"];
    
    [self.secondCategoryView addSubview:self.tableView2];
}
- (void)handleSecondPan:(UIPanGestureRecognizer *)sender
{
    CGPoint translation = [sender translationInView:self.secondCategoryView];
    
    if (translation.x > 0) {
        
        self.secondCategoryView.frame = CGRectMake(118+translation.x, NavHeight,Screen_Width-118, ViewHeight);
        self.arrowImage2.frame = CGRectMake(108+translation.x,secondArrowRect.origin.y+14+NavHeight, 10, 20);
    }
    
    if (sender.state==UIGestureRecognizerStateEnded) {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            if ((translation.x > Start_X)  && (translation.x < Center_Value)) {
                
                self.secondCategoryView.frame = CGRectMake(118, NavHeight,Screen_Width-118,ViewHeight);
                self.arrowImage2.frame = CGRectMake(108, secondArrowRect.origin.y+14+NavHeight, 10, 20);
                
            }else{
                
                self.secondCategoryView.frame = CGRectMake(Screen_Width, NavHeight,Screen_Width-118, ViewHeight);
                self.arrowImage2.frame = CGRectMake(Screen_Width,secondArrowRect.origin.y+14+NavHeight, 10, 20);
            }
        }];
    }
}


#pragma mark --  tableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag==100) {
        
        return self.secondArray.count;
    }else{
        return self.thirdArray.count;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 48;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 100) {
        
        TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell"];
        cell.backgroundColor = [UIColor colorWithHexString:@"EAECEE"];
        
        cell.titleLabel.text = self.secondArray[indexPath.row];
        
        if (secondParamer == indexPath.row) {
            cell.titleLabel.textColor = [UIColor colorWithHexString:@"f8b626"];
        }else{
            cell.titleLabel.textColor = [UIColor colorWithHexString:@"2f4266"];
        }
        return cell;
        
    }else{
        
        TableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell"];
        cell1.titleLabel.textColor = [UIColor colorWithHexString:@"ffffff"];
        cell1.defaultImage.hidden = YES;
        cell1.lineView.backgroundColor = [UIColor colorWithHexString:@"BDBFC0"];
        cell1.backgroundColor = [UIColor colorWithHexString:@"99A0A7"];
        
        cell1.titleLabel.text = self.thirdArray[indexPath.row];
        
        return cell1;
        
    }
    return UITableViewCell.new;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==100) {
        
        CGRect rectInTableView = [tableView rectForRowAtIndexPath:indexPath];
        CGRect rect = [tableView convertRect:rectInTableView toView:[tableView superview]];
        secondArrowRect = rect;
        secondParamer = indexPath.row;
        
        if (!self.isClickTabOnce) {
            
            [self createThirdCategory];
        }
        _isClickTabOnce = YES;
        firstParamer = -1;
        
        self.arrowImage2.frame = CGRectMake(self.arrowImage2.frame.origin.x,rect.origin.y+14+NavHeight, 10, 20);
        
        [UIView animateWithDuration:0.3 animations:^{
            
            self.arrowImage2.frame = CGRectMake(108,rect.origin.y+14+NavHeight, 10, 20);
            self.secondCategoryView.frame = CGRectMake(118,NavHeight,Screen_Width-118,ViewHeight);
        }];
        
    
        // 调接口
        [self.tableView1 reloadData];
        
    }else{
#pragma mark -- 跳转三级列表
    }
}

#pragma mark -- collectionDelegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.firstArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];
    
    cell.titleLabel.text = self.firstArray[indexPath.row];
    
    if (firstParamer == indexPath.row) {
        
        cell.backgroundColor = [UIColor colorWithHexString:@"F8B62B"];
        
    }else{
        
        cell.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
    }
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];
    //获取当前cell在collection中的位置
    CGRect rect = [self.collectionView convertRect:cell.frame toView:[self.collectionView superview]];
    firstArrowRect = rect;
    
    firstParamer = indexPath.row;
    [self.collectionView reloadData];
    
    if (!self.isClickColOnce) {
        
         [self createSecondCategory];
    }
    _isClickColOnce = YES;
    secondParamer = -2;
    
    self.arrowImage1.frame = CGRectMake(self.arrowImage1.frame.origin.x,rect.origin.y+14, 10, 20);
    [UIView animateWithDuration:0.3 animations:^{
        
        self.arrowImage1.frame = CGRectMake(41,rect.origin.y+14, 10, 20);
        self.firstCategoryView.frame = CGRectMake(51,NavHeight,Screen_Width-51,ViewHeight);
    }];
    
    if (self.secondCategoryView.frame.origin.x == 118) {
        //三级页面存在
        [UIView animateWithDuration:0.3 animations:^{
            
            self.arrowImage2.frame = CGRectMake(Screen_Width,rect.origin.y+14, 10, 20);
            self.secondCategoryView.frame = CGRectMake(Screen_Width,NavHeight,Screen_Width-118,ViewHeight);
        }];
    }
    
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(Screen_Width, 48);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}



@end
