//
//  MainViewController.m
//  SpringyFlowLayoutExample
//
//  Created by Julio Andrés Carrettoni on 08/08/13.
//  Copyright (c) 2013 Julio Andrés Carrettoni. All rights reserved.
//

#import "MainViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface MainViewController ()
@end

@implementation MainViewController {
    IBOutlet UICollectionView *aCollectionView;
    NSArray* _colors;
}


- (void) viewDidLoad {
    [super viewDidLoad];
    NSMutableArray* mutArray = [NSMutableArray array];
    int size = 50;
    for (int i = 0; i < size; i++) {
        int random = arc4random()%size;
        UIColor *color = [UIColor colorWithHue:(random/(float)size)
                                    saturation:1.0
                                    brightness:1.0
                                         alpha:1.0];
        [mutArray addObject:color];
    }
    _colors = [NSArray arrayWithArray:mutArray];
    
    [aCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"sample"];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _colors.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"sample" forIndexPath:indexPath];
    
    cell.backgroundColor = [_colors objectAtIndex:indexPath.row];
    return cell;
}



@end
