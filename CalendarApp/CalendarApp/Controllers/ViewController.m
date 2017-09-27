//
//  ViewController.m
//  CalendarApp
//
//  Created by kawaharadai on 2017/09/27.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import "ViewController.h"
#import "CustomCollectionViewCell.h"

@interface ViewController () <UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSDate *daysData;
@property (strong, nonatomic) NSArray *dayOfTheWeek;
@end

static int const DaysWeek = 7;
static int const DaysWeekIndex = 6;
static int const LastWeekStartIndex = 28;
static int const FirstDayCount = 1;
static int const OverFirstWeekCount = 8;
static int const UnderLastWeekCount = 22;
static double const DayCellSizeMagnification = 0.8;
static double const DateCellSizeMagnification = 1.5;
static NSInteger SectionCount = 2;
static CGFloat const CellMargin = 2.0f;

@implementation ViewController

#pragma mark - LifeCycle methods
- (void)viewDidLoad {
    [super viewDidLoad];
    // 当日の日付を取得（これを基準に表示月を決定）
    self.daysData = [NSDate date];
    // カスタムセルnibの登録
    UINib *nib = [UINib nibWithNibName:@"CustomCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:@"Cell"];
    // 曜日用の配列を用意
    self.dayOfTheWeek = @[@"日", @"月", @"火", @"水", @"木", @"金", @"土"];
    // タイトルバーに日付を設定
    [self setbarTitle:self.daysData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Action methods
// 「次へ」ボタン
- (IBAction)moveNextMonth:(id)sender {
    // 来月の日数情報を取得
    self.daysData = [self getNextMonthDate];
    // タイトルバーを当日の日付に合わせて変更
    [self setbarTitle:self.daysData];
    // リロード処理
    [self.collectionView reloadData];
}
// 「前へ」ボタン
- (IBAction)moveBeforeMonth:(id)sender {
    // 来月の日数情報を取得
    self.daysData = [self getBeforeMonthDate];
    // タイトルバーを当日の日付に合わせて変更
    [self setbarTitle:self.daysData];
    // リロード処理
    [self.collectionView reloadData];
}

#pragma mark - private methods
// 初日から日付データを取得していく
- (NSDate *)getTargetDate:(NSIndexPath *)indexPath {
    // その月の初めの日を返す
    NSInteger ordinalityOfFirstDay = [NSCalendar.currentCalendar ordinalityOfUnit:NSCalendarUnitDay
                                                                           inUnit:NSCalendarUnitWeekOfMonth
                                                                          forDate:[self firstDayofMonth]];
    // データコンポーネントを初期化して用意
    NSDateComponents *dateComponents = [[NSDateComponents alloc]init] ;
    // 先月の月末の日数を出している
    dateComponents.day = indexPath.item - (ordinalityOfFirstDay - 1);
    // 本日の日付を出す
    NSDate *date = [NSCalendar.currentCalendar dateByAddingComponents:dateComponents
                                                               toDate:[self firstDayofMonth]
                                                              options:0];
    return date;
}
// 先月最後の日付を出すメソッド
- (NSDate *)firstDayofMonth {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay
                                                                   fromDate:self.daysData];
    // 当月の日を1日に戻す
    components.day = FirstDayCount;
    // 当日の日付を返す
    NSDate *firstDateMonth = [[NSCalendar currentCalendar] dateFromComponents:components];
    return firstDateMonth;
}
// 投げられた日付によってナビゲーションバーのタイトルを変更
- (void)setbarTitle:(NSDate *)selectedDate {
    self.daysData = selectedDate;
    // フォーマットを作って、受け取った値に合わせてタイトルを変更
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy年M月";
    self.title = [formatter stringFromDate:selectedDate];
}
// 来月の予定を表示
- (NSDate *)getNextMonthDate {
    NSInteger nextMonthCount = 1;
    NSCalendar *calendar = NSCalendar.currentCalendar;
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = nextMonthCount;
    return [calendar dateByAddingComponents:dateComponents toDate:self.daysData options:0];
}
// 先月の予定を表示
- (NSDate *)getBeforeMonthDate {
    NSInteger beforeMonthCount = -1;
    NSCalendar *calendar = NSCalendar.currentCalendar;
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = beforeMonthCount;
    return [calendar dateByAddingComponents:dateComponents toDate:self.daysData options:0];
}

#pragma mark - UICollectionViewDataSource methods
// セクションの数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return SectionCount;
}
// セッションの内容
- (UICollectionReusableView*)collectionView:(UICollectionView *)collectionView
          viewForSupplementaryElementOfKind:(NSString *)kind
                                atIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header" forIndexPath:indexPath];
    return header;
}
// セルの数
- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    
    if (section == 0) {
        return DaysWeek;
    } else {
        // seが含まれている月の週の数を数える
        NSRange rangeOfWeeks = [NSCalendar.currentCalendar rangeOfUnit:NSCalendarUnitWeekOfMonth
                                                                inUnit:NSCalendarUnitMonth
                                                               forDate:self.daysData];
        // その月が何週間あるかを数える
        NSUInteger numberOfWeeks = rangeOfWeeks.length;
        // 週間＊7日で月の全日数を計算
        NSInteger numberOfItems = numberOfWeeks *DaysWeek;
        // 日数を返す
        return numberOfItems;
    }
}
// セルの内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CustomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell"
                                                                               forIndexPath:indexPath];
    // セルのテキストカラーを初期化
    cell.cellLabel.textColor = [UIColor blackColor];
    
    if (indexPath.section == 0) {
        cell.cellLabel.text = self.dayOfTheWeek[indexPath.row];
    } else {
        // 日付のフォーマットを作成
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        // daysのみを指定
        formatter.dateFormat = @"d";
        // セットした日付からindex順に取り出す
        cell.cellLabel.text = [formatter stringFromDate:[self getTargetDate:indexPath]];
    }
    
    // 日曜と土曜の場合の色を変えている
    if (indexPath.row % DaysWeek == 0) {
        cell.cellLabel.textColor = [UIColor redColor];
    } else if (indexPath.row % DaysWeek == DaysWeekIndex) {
        cell.cellLabel.textColor = [UIColor blueColor];
    }
    
    // 先月、翌月の日にちは非活性（テキストカラーをグレーに変更）
    if (indexPath.row <= DaysWeekIndex) {
        NSString *indexText = cell.cellLabel.text;
        int indexTextValue = [indexText intValue];
        if (indexTextValue >= OverFirstWeekCount) {
            cell.cellLabel.textColor = [UIColor lightGrayColor];
        }
    } else if (indexPath.row >= LastWeekStartIndex) {
        NSString *indexText = cell.cellLabel.text;
        int indexTextValue = [indexText intValue];
        if (indexTextValue <= UnderLastWeekCount) {
            cell.cellLabel.textColor = [UIColor lightGrayColor];
        }
    }
    return cell;
}

#pragma mark - UICollectionViewDelegate methods
// セルのサイズレイアウトを決定
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    // 隙間の数（7日で１列の場合、隙間は8）
    NSInteger numberOfMargin = OverFirstWeekCount;
    // セルの横幅
    CGFloat width = floorf((collectionView.frame.size.width - CellMargin * numberOfMargin) / DaysWeek);
    // セルの高さ(曜日と日にちエリアでサイズを差別化)
    CGFloat height = 0;
    if (indexPath.section == 0) {
        height = width * DayCellSizeMagnification;
    } else {
        height = width * DateCellSizeMagnification;
    }
    return CGSizeMake(width, height);
}
// セル間のマージンを決定する
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(CellMargin, CellMargin, CellMargin, CellMargin);
}
// セルの隙間を埋める
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return CellMargin;
}
// セルの隙間を調整
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return CellMargin;
}

// セクションのサイズを設定（高さを０にする）
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    CGFloat cellHeight = 0;
    CGFloat sectionWidth = self.collectionView.bounds.size.width;
    CGSize sectionSize = CGSizeMake(sectionWidth, cellHeight);
    return sectionSize;
}

@end
