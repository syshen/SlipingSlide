//
//  SSViewController.m
//  SlipingSlide
//
//  Created by Shen Steven on 4/16/13.
//  Copyright (c) 2013 syshen. All rights reserved.
//

#import "SSViewController.h"

@interface SSViewController () <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *colors;
@end

@implementation SSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
  [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"collectionViewCell"];
  self.colors = @[[UIColor blueColor], [UIColor yellowColor], [UIColor redColor], [UIColor blackColor], [UIColor lightGrayColor], [UIColor orangeColor], [UIColor lightGrayColor]];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return 30;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  
  UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionViewCell" forIndexPath:indexPath];
  cell.backgroundColor = self.colors[indexPath.row % self.colors.count];
  return cell;
}
@end
