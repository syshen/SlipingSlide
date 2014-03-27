//
//  SSSlipingSlideLayout.m
//  SlipingSlide
//
//  Created by Shen Steven on 4/16/13.
//  Copyright (c) 2013 syshen. All rights reserved.
//

#import "SSSlipingSlideLayout.h"

@interface SSSlipingSlideLayout()
@property (nonatomic,assign) CGFloat minItemHeight;
@property (nonatomic,assign) CGFloat maxItemHeight;
@end

@implementation SSSlipingSlideLayout

- (void) prepareLayout {
  self.minimumInteritemSpacing = 0;
  self.minimumLineSpacing = 0;
  self.itemSize = CGSizeMake(self.collectionView.frame.size.width, self.collectionView.frame.size.height/4);
  self.minItemHeight = self.collectionView.frame.size.height/4;
  self.maxItemHeight = self.collectionView.frame.size.height/2;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
  CGPoint currentOffset = self.collectionView.contentOffset;
  
  NSMutableArray *attributes = [NSMutableArray arrayWithArray:[super layoutAttributesForElementsInRect:rect]];
  
  for (UICollectionViewLayoutAttributes *attr in attributes) {
    CGFloat y = attr.indexPath.row * self.minItemHeight;
    
    if (y == currentOffset.y) {
        
      attr.frame = CGRectMake(attr.frame.origin.x, y, attr.size.width, self.maxItemHeight);
      
    } else if (y < currentOffset.y && (y+self.minItemHeight) > currentOffset.y) {
      
      CGFloat h = y + self.minItemHeight - currentOffset.y;
      attr.frame = CGRectMake(attr.frame.origin.x, y, attr.size.width, 2 * h);
      
    } else if (y > currentOffset.y && y <= (currentOffset.y + self.minItemHeight)) {
      
      CGFloat h = y - currentOffset.y;
      attr.frame = CGRectMake(attr.frame.origin.x, (attr.indexPath.row-1)*self.minItemHeight+2*h, attr.size.width, 3*self.minItemHeight - 2*h);
      
    } else if (y < currentOffset.y) {
      
      attr.frame = CGRectMake(attr.frame.origin.x, y, attr.size.width, self.minItemHeight);
    } else {
    
      attr.frame = CGRectMake(attr.frame.origin.x, y + self.minItemHeight, attr.size.width, self.minItemHeight);
        
    }
    
  
  }
  return [NSArray arrayWithArray:attributes];
}

- (CGSize)collectionViewContentSize {
  NSInteger numOfItem = [self.collectionView numberOfItemsInSection:0];
  return CGSizeMake(self.collectionView.frame.size.width, numOfItem * self.minItemHeight + self.collectionView.frame.size.height - self.minItemHeight);
}

- (BOOL) shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
  return YES;
}

- (CGPoint) targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
  NSInteger base = (NSInteger)(self.collectionView.contentOffset.y / self.minItemHeight);
  if (velocity.y > 0)
    base ++;
  return CGPointMake(proposedContentOffset.x, base * self.minItemHeight);
}
@end
