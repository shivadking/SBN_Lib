//
//  ShuffleCollectionViewController.m
//  Shuffle
//
//  Created by Tim Moose on 5/29/13.
//  Copyright (c) 2013 Tractable Labs. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import <TLIndexPathTools/TLIndexPathDataModel.h>
#import "ShuffleCollectionViewController.h"
#import "UIColor+Hex.h"

#define IDX_TEXT 0
#define IDX_COLOR 1

@implementation ShuffleCollectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //initialize the controller with a list data items. To keep it simple, we'll
    //just use two element arrays (text and color) for our items.
    NSArray *items = @[
           @[@"A", [UIColor colorWithHexRGB:0x443695]],
           @[@"B", [UIColor colorWithHexRGB:0x00B1D7]],
           @[@"C", [UIColor colorWithHexRGB:0xF42994]],
           @[@"D", [UIColor colorWithHexRGB:0x0A0916]],
           @[@"E", [UIColor colorWithHexRGB:0xF4E353]],
           @[@"F", [UIColor colorWithHexRGB:0x537B28]],
           ];
    self.indexPathController.items = items;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [super collectionView:collectionView cellForItemAtIndexPath:indexPath];
    //retrieve the cell data for the given index path from the controller
    //and set the cell's text label and background color
    NSArray *item = [self.indexPathController.dataModel itemAtIndexPath:indexPath];
    UILabel *label = (UILabel *)[cell viewWithTag:1];
    label.text = item[IDX_TEXT];
    cell.backgroundColor = item[IDX_COLOR];
    cell.layer.cornerRadius = 10;
    return cell;
}

- (void)shuffle
{
    //shuffle the items randomly and update the controller with the shuffled items
    NSMutableArray *shuffledItems = [NSMutableArray arrayWithArray:self.indexPathController.items];
    NSInteger count = shuffledItems.count;
    for (int i = 0; i < count; i++) {
        [shuffledItems exchangeObjectAtIndex:i withObjectAtIndex:arc4random() % count];
    }
    self.indexPathController.items = shuffledItems;
}

@end
