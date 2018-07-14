//
//  FirstPageVC.m
//  XMLY
//
//  Created by 耿荣林 on 2018/7/4.
//  Copyright © 2018年 耿荣林. All rights reserved.
//

#import "FirstPageVC.h"
#import "RequestDATA.h"
#import "defind.h"
#import "MBDICycleScrollView.h"
#import "DealRecommendData.h"
#import "UIImageView+WebCache.h"
#import "BaseTableViewCell.h"
#import "BaseCollectionViewCell.h"
#import "BaseModel.h"
#import "SquareModelTBCell.h"
#import "SquareCollectionViewCell.h"
#import "GuessYouLikeModelTBCell.h"
#import "GuessYouLikeCollectionViewCell.h"

@interface FirstPageVC ()<UISearchBarDelegate,UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) UIView *moveView;
@property (nonatomic,strong) UIScrollView *bigScrollView;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) MBDICycleScrollView *cycleSV;
//轮播图数据集
@property (nonatomic,strong) NSMutableArray *CycleDataList;
//轮播图视图集
@property (nonatomic,strong) NSMutableArray *cycleSVDataArray;
/*推荐页面数据源*/
@property (nonatomic,copy) NSArray *dataSourceArr;
//轮播图：
@property (nonatomic,copy) NSArray *bannerArr;

@end
static NSString *tuijianurl = @"http://mobile.ximalaya.com/discovery-firstpage/explore/ts-1530685322675?appid=0&categoryId=-2&channel=ios-b1&code=43_110000_1100&device=iPhone&deviceId=D6644770-AAC3-4712-B99B-4EE815F86C11&includeActivity=true&includeSpecial=true&network=WIFI&operator=3&scale=3&uid=0&version=6.3.45&xt=1530685322675";
@implementation FirstPageVC

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor whiteColor];
    [super viewDidLoad];
    [self createSearchBar];
    [self createleftAndRightBtn];
    [self createScrollView];
    [self createTopButton];
    [RequestDATA getDataWithUrl:tuijianurl complement:^(id data) {
        NSArray *Arr = [data objectForKey:@"list"];
        self.bannerArr = [[[[Arr objectAtIndex:0] objectForKey:@"list"] objectAtIndex:0] objectForKey:@"data"];
        DealRecommendData *modelData = [[DealRecommendData alloc]init];
        self.dataSourceArr = [modelData getModelWithArr:Arr];
        NSLog(@"-----%@",self.dataSourceArr);
        dispatch_async(dispatch_get_main_queue(), ^{
        [self createTableView];
        });
    }];
}

//创建导航栏按钮：
- (void)createleftAndRightBtn{
    //设置右按钮：
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"时间.png"] style:UIBarButtonItemStylePlain target:self action:@selector(rightClick)];
    UIBarButtonItem *rightItem1 = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"下载.png"] style:UIBarButtonItemStylePlain target:self action:@selector(OtherRightClick)];
    self.navigationItem.rightBarButtonItems = @[rightItem1,rightItem];
    //设置左按钮：
    UIBarButtonItem *leftitem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"信封.png"] style:UIBarButtonItemStylePlain target:self action:@selector(leftClick)];
    self.navigationItem.leftBarButtonItem = leftitem;
    [self.navigationController.navigationBar setTintColor:[UIColor grayColor]];
}

- (void)leftClick{
    
}

- (void)rightClick{
    
}

- (void)OtherRightClick{
    
}

//创建导航栏搜索框：
- (void)createSearchBar{
    CGRect mainViewBounds = self.navigationController.view.bounds;
    UISearchBar *customSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(CGRectGetWidth(mainViewBounds)/2-((CGRectGetWidth(mainViewBounds)-120)/2), CGRectGetMinY(mainViewBounds)+22, CGRectGetWidth(mainViewBounds)-180, 40)];
    customSearchBar.delegate = self;
    customSearchBar.showsCancelButton = NO;
    customSearchBar.searchBarStyle = UISearchBarStyleMinimal;
    [self.navigationController.view addSubview: customSearchBar];
}

//创建顶部按钮：
- (void)createTopButton{
    NSArray *btnTitleArr = [NSArray arrayWithObjects:@"分类",@"推荐",@"精品",@"直播",@"广播", nil];
    //创建顶部移动视图：
    _moveView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH / 5.0, 64 + 48, SCREEN_WIDTH / 5.0, 2)];
    _moveView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_moveView];
    [_bigScrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0)];
    //循环创建按钮：
    for (int i = 0; i < btnTitleArr.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor whiteColor];
        //设置按钮的颜色：
        if (i == 1) {
            [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        }else{
            [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        }
        btn.tag = 100 + i;
        btn.frame = CGRectMake(i * (SCREEN_WIDTH / 5.0), 64, SCREEN_WIDTH / 5.0, 48);
        [btn setTitle:[btnTitleArr objectAtIndex:i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(moveClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
}

//点击顶部按钮调用方法：
- (void)moveClick:(UIButton *)btn{
    //1、根据点击位置改变moveView的位置
    _moveView.frame = CGRectMake((btn.tag - 100) * (SCREEN_WIDTH / 5.0), 64 + 48, SCREEN_WIDTH / 5.0, 2);
    //3、根据点击的按钮改变UIscrollView的位置：
    [_bigScrollView setContentOffset:CGPointMake((btn.tag - 100) * SCREEN_WIDTH, 0)];
    //2、点击按钮改变标题颜色：
    for (int i = 0; i < 5; i++) {
        //根据tag获取按钮
        UIButton *btn1 = [self.view viewWithTag:100 + i];
        if (btn.tag == btn1.tag) {
            [btn1 setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        }else{
            [btn1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        }
    }
}

//滚动视图滚动结束的协议方法：
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //判断滚动视图的类型：
    if (scrollView.tag == 50) {
        //1、根据当前视图的偏移量设置当前的按钮位置提示：
        _moveView.frame = CGRectMake(scrollView.contentOffset.x / SCREEN_WIDTH * (SCREEN_WIDTH / 5), 64 + 48, SCREEN_WIDTH / 5, 2);
        //2、根据当前的偏移量改变标题颜色：
        for (int i = 0; i < 5; i++) {
            //根据tag获取按钮
            UIButton *btn1 = [self.view viewWithTag:100 + i];
            if (scrollView.contentOffset.x / SCREEN_WIDTH == (btn1.tag - 100)) {
                [btn1 setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            }else{
                [btn1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            }
        }
    }else{
        
    }
}

//创建ScrollView：
- (void)createScrollView{
    _bigScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64 + 50, SCREEN_WIDTH, SCREEN_HEIGHT - (64 + 49 + 50))];
    _bigScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 5, 0);
    //滚动视图的协议：
    _bigScrollView.delegate = self;
    _bigScrollView.pagingEnabled = YES;
    _bigScrollView.tag = 50;
    _bigScrollView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_bigScrollView];
}

//创建测试View
- (void)createTestView{
    for (int i = 0; i < 5; i++) {
        UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(i * SCREEN_WIDTH, 0, SCREEN_WIDTH, _bigScrollView.frame.size.height)];
        view1.backgroundColor = [UIColor colorWithRed:(arc4random() % 255 + 1) / 255.0 green:(arc4random() % 255 + 1) / 255.0 blue:(arc4random() % 255 + 1) / 255.0 alpha:1];
        
        view1.backgroundColor = [UIColor colorWithRed:0/255.0 green:156/255.0 blue:206/255.0 alpha:1];
        [_bigScrollView addSubview:view1];
    }
}

//1、创建列表：
- (void)createTableView{
    for (int i = 0; i < 5; i++) {
        if (i!= 3 && i != 0) {
            UITableView *topTableView = [[UITableView alloc]initWithFrame:CGRectMake(i * SCREEN_WIDTH, 0, SCREEN_WIDTH, _bigScrollView.frame.size.height) style:UITableViewStylePlain];
            [_bigScrollView addSubview:topTableView];
            topTableView.tag = 200 + i;
            
            if (i != 1) {
                [topTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"statecell"];
            }else{
                //1、使用处理好的数据注册cell：
                for (int i = 1; i < self.dataSourceArr.count; i++) {
                    //获取每一个小数组中的第一个model
                    BaseModel *model = [[self.dataSourceArr objectAtIndex:i]objectAtIndex:0];
                    //把对应的model转成对应的字符串，拼接成和TBcell一样的string
                    NSString *modelStr = [NSString stringWithFormat:@"%@%@",NSStringFromClass([model class]),@"TBCell"];
                    //使用对应的cell名做cell的注册
                    [topTableView registerClass:NSClassFromString(modelStr) forCellReuseIdentifier:modelStr];
                 }
            }
            self.tableView.delegate = self;
            self.tableView.dataSource = self;
            self.tableView = topTableView;
        }else if(i == 3){
            UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
            layout.itemSize = CGSizeMake((SCREEN_WIDTH - SCREEN_RATE_640_WIDTH(80)) / 2.0, (SCREEN_WIDTH - SCREEN_RATE_640_WIDTH(80)) / 2 + (SCREEN_WIDTH - SCREEN_RATE_640_WIDTH(80)) / 2 * 2 / 5);
            layout.headerReferenceSize=CGSizeMake(SCREEN_WIDTH, SCREEN_RATE_640_HEIGHT(440, 1242));
            //行间距：
            layout.minimumLineSpacing = SCREEN_RATE_640_WIDTH(20);
            //列间距：
            layout.minimumInteritemSpacing = 0;
            //四周边距：
            layout.sectionInset = UIEdgeInsetsMake(5, SCREEN_RATE_640_WIDTH(30), 0, SCREEN_RATE_640_WIDTH(30));
            UICollectionView *colleView = [[UICollectionView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * 3, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 49 - 50) collectionViewLayout:layout];
            //注册系统cell
            colleView.tag = 800;
            [_bigScrollView addSubview:colleView];
            //注册headercell
            colleView.backgroundColor = [UIColor whiteColor];
        }else{
            UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
            layout.minimumLineSpacing = 1;
            //列间距：
            layout.minimumInteritemSpacing = 0;
            layout.headerReferenceSize=CGSizeMake(SCREEN_WIDTH, 40);
            
            UICollectionView *colleView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 49 - 50) collectionViewLayout:layout];
            //注册系统cell
            colleView.tag = 900;
            colleView.backgroundColor = [UIColor whiteColor];
            [_bigScrollView addSubview:colleView];
        }
    }
    [self creatTableViewheader];
}

//2、创建headerView：
- (void)creatTableViewheader{
    if ([self.view viewWithTag:201]) {
        UITableView *tableView = [self.view viewWithTag:201];
        tableView.tableHeaderView = [self createBanner];
    }
}

//3、实现轮播图：
- (MBDICycleScrollView *)createBanner{
    //将轮播   图放在TableView的HeaderView上
    _cycleSV = [[MBDICycleScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_RATE_640_HEIGHT(500, 1242)) animationDuration:3];
    [self updateCycleSV];
    return _cycleSV;
}

//轮播图添加图片：
-(void)updateCycleSV
{
    _cycleSVDataArray = [[NSMutableArray alloc]initWithCapacity:0];
    _CycleDataList = [NSMutableArray array];
    for (NSInteger i = 0; i < self.bannerArr.count; i++) {
        [_CycleDataList addObject:[[self.bannerArr objectAtIndex:i]objectForKey:@"cover"]];
    } 
    _cycleSVDataArray = [NSMutableArray array];
    [_cycleSVDataArray removeAllObjects];
    for (int i = 0; i<_CycleDataList.count; i++) {
        UIView *photoV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_RATE_640_HEIGHT(500, 1242))];
        photoV.backgroundColor = [UIColor blueColor];
        //        [_cycleSV addSubview:photoV];
        [photoV setUserInteractionEnabled:YES];
        UIImageView *imgv = [[UIImageView alloc]initWithFrame:photoV.bounds];
        [imgv setUserInteractionEnabled:YES];
        //设置图片展示位置：
        [imgv setContentMode:UIViewContentModeScaleAspectFill];
        [imgv sd_setImageWithURL:[NSURL URLWithString:_CycleDataList[i]] placeholderImage:[UIImage imageNamed:@""]];
        [imgv setImage:[UIImage imageNamed:_CycleDataList[i]]];
        [photoV addSubview:imgv];
        [_cycleSVDataArray addObject:photoV];
    }
    __block __weak FirstPageVC *weakSelf = self;
    _cycleSV.arrayView = _cycleSVDataArray;
    //获取点击的位置：
    _cycleSV.TapActionBlock = ^(NSInteger pageIndex){
        NSLog(@"tap:%ld",(long)pageIndex);
        //点击调用方法：
        [weakSelf tapClick:pageIndex];
    };
}

//轮播图的点击方法：
-(void)tapClick:(NSInteger)index
{
  
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.dataSourceArr.count) {
        if (section == 0 || section == 1 || section == 2 || section == 7 || section == 8 || section == 9 || section == 11) {
            return 1;
        }else{
            NSArray *arr = [self.dataSourceArr objectAtIndex:(section + 1)];
            return arr.count;
        }
    }else{
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return SCREEN_RATE_640_HEIGHT(240, 1242);
    }else if (indexPath.section == 1){
        return ((SCREEN_RATE_640_HEIGHT(140, 1242)+((SCREEN_WIDTH-SCREEN_RATE_640_WIDTH(90))/3.0))*2) + SCREEN_RATE_640_HEIGHT(150, 1242) * 2;
    }else{
        return 40;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.dataSourceArr.count) {
        return self.dataSourceArr.count - 1;
    }else{
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 201) {
        if (indexPath.section == 0) {
            //通过对应的标识符取出cell
            SquareModelTBCell *cell = [tableView dequeueReusableCellWithIdentifier:[self getCellWithIndexPath:indexPath]];
            //注册collectionView
            [cell.menuCollectionView registerClass:[SquareCollectionViewCell class] forCellWithReuseIdentifier:@"SquareCollectionViewCell"];
            //3、设置cellctionView的delegate：
            cell.menuCollectionView.delegate = self;
            cell.menuCollectionView.dataSource = self;
            //tag
            cell.menuCollectionView.tag = 1000;
            cell.menuCollectionView.backgroundColor = [UIColor whiteColor];
            return cell;
        }else if (indexPath.section == 1) {
            GuessYouLikeModelTBCell *cell = [tableView dequeueReusableCellWithIdentifier:[self getCellWithIndexPath:indexPath]];
            [cell.guessListCollectionView registerClass:[GuessYouLikeCollectionViewCell class] forCellWithReuseIdentifier:@"guessListCollectionView"];
            cell.guessListCollectionView.delegate = self;
            cell.guessListCollectionView.dataSource = self;
            cell.guessListCollectionView.backgroundColor = [UIColor whiteColor];
            cell.guessListCollectionView.tag = 1100;
            return cell;
        }else{
            //2、重用注册的cell：
            BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"%@",[self getCellWithIndexPath:indexPath]]];
            
            
            
            return cell;
        }
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"statecell"];
        return cell;
    }
}

- (id)getCellWithIndexPath:(NSIndexPath *)indexPath{
    BaseModel *model = [[self.dataSourceArr objectAtIndex:(indexPath.section + 1)] objectAtIndex:indexPath.row];
    NSString *cellNameStr = [NSStringFromClass([model class]) stringByAppendingFormat:@"%@",@"TBCell"];
    return cellNameStr;
}

//4、实现collctionView的协议方法：
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
  
    if (collectionView.tag == 1000) {
        
        //5、使用collectionViewcell：
        SquareCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SquareCollectionViewCell" forIndexPath:indexPath];
        cell.model = [[self.dataSourceArr objectAtIndex:1] objectAtIndex:indexPath.item];
        return cell;
    }else{
        GuessYouLikeCollectionViewCell  *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"guessListCollectionView" forIndexPath:indexPath];
        NSLog(@"-----------------%ld",indexPath.row);
        cell.model = [[self.dataSourceArr objectAtIndex:2] objectAtIndex:indexPath.row];
        return cell;
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (collectionView.tag == 1000) {
        NSArray *arr = [self.dataSourceArr objectAtIndex: 1];
        return arr.count;
    }else{
        NSArray *arr = [self.dataSourceArr objectAtIndex: 2];
        return arr.count;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
