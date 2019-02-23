//
//  ViewController.m
//  OptimizeCollectionView
//
//  Copyright © 2019 YaHaHa_. All rights reserved.
//

#import "ViewController.h"
//view
#import "TextCell.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)NSArray <NSString*>*dataArr;/**<数据源*/
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.collectionView];
    self.collectionView.frame = self.view.bounds;
    [self.collectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    TextCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass
                      ([TextCell class])
                                                               forIndexPath:indexPath];
    [cell loadNewData:self.dataArr[(NSUInteger)indexPath.item]];
    return cell;
}
- (UICollectionView *)collectionView {

    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake(self.view.bounds.size.width, 30);
        _collectionView = [[UICollectionView alloc]
                initWithFrame:self.view.bounds
         collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[TextCell class]
            forCellWithReuseIdentifier:NSStringFromClass([TextCell class])];
    }
    return _collectionView;
}

- (NSArray<NSString *> *)dataArr {

    if (!_dataArr) {
        _dataArr = [UIFont familyNames].copy;
    }
    return _dataArr;
}


@end