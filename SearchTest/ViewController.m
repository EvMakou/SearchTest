//
//  ViewController.m
//  SearchTest
//
//  Created by supermacho on 19.10.16.
//  Copyright © 2016 supermacho. All rights reserved.
//

#import "ViewController.h"
#import "NSString+Random.h"
#import "Section.h"
@interface ViewController ()


@property (strong, nonatomic) NSArray* namesArray;
@property (strong, nonatomic) NSArray* sectionArray;

//@property (strong, nonatomic) NSArray* namesArray;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSMutableArray* array = [NSMutableArray array];
    
    for (int i = 0; i < 100; i++) {
        [array addObject:[[NSString randomAlphanumericString] capitalizedString]];
    }
    NSLog(@"%@",array);
    NSSortDescriptor* descriptor = [[NSSortDescriptor alloc] initWithKey:@"self" ascending:YES];
    
    [array sortUsingDescriptors:@[descriptor]];
    
    self.namesArray = array;
    self.sectionArray = [self generateSectionsFromArray:array withFilter:self.searchBar.text];
    [self.tableView reloadData];
} 


- (NSArray*) generateSectionsFromArray:(NSArray*) array withFilter:(NSString*) stringFilter {
    
    NSMutableArray* sectionsArray = [NSMutableArray array];
       
    NSString* currentLetter = nil;//переменная для сравнения
    
    for (NSString* string in self.namesArray) {
        
        if ([stringFilter length] > 0 && [string rangeOfString:stringFilter].location == NSNotFound) {
            continue;
        }
        
        
        NSString* firstLetter = [string substringToIndex:1];
         
        Section* section = nil;
   //         NSLog(@"%@ %@", currentLetter, firstLetter);
//        if (![currentLetter isEqualToString:firstLetter]) {
//       
//            section = [[Section alloc]init];
//            section.sectionName = firstLetter;
//            section.itemsArray = [NSMutableArray array];
//            currentLetter = firstLetter;
//            //NSLog(@"%@ %@", currentLetter, firstLetter);
//            [sectionsArray addObject:section];
//        } else {
//            section = [sectionsArray lastObject];
//        }
        if (![currentLetter isEqualToString:firstLetter]) {
        section = [[Section alloc]init];
        section.itemsArray = [NSMutableArray array];
        section.sectionName = firstLetter;
            currentLetter = firstLetter;
        [section.itemsArray addObject:string];
            NSLog(@"%@",section.itemsArray);
        [sectionsArray addObject:section];
            NSLog(@"%ld",[sectionsArray count]);
        } else {
            section = [sectionsArray lastObject];
            [section.itemsArray addObject:string];
        }
    }
     NSLog(@"Count group %ld",[sectionsArray count]);
    [self.tableView reloadData];
    return sectionsArray;
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDataSource

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    NSMutableArray* array = [NSMutableArray array];
    
    for (Section* section in self.sectionArray) {
        [array addObject:section.sectionName];
    }
    
    return array;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.sectionArray count];
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
   
    return [[self.sectionArray objectAtIndex:section] sectionName];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    Section* sec = [self.sectionArray objectAtIndex:section];
    
    return [sec.itemsArray count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString* identifier = @"Cell";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    Section* section = [self.sectionArray objectAtIndex:indexPath.section];
    
    NSString* name = [section.itemsArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = name;
    
    
    return cell;
    
    
}


#pragma mark - UISearchBarDelegate

- (void) searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
    
}

- (void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(@"textDidChange %@",searchText);
     NSMutableArray* sectionsArray = [NSMutableArray array];
    //self.sectionArray = [self generateSectionsFromArray:self.namesArray withFilter:searchText];
    
     NSString* currentLetter = nil;
    for (NSString* string in self.namesArray) {
        
        if ([searchText length] > 0 && [string rangeOfString:searchText].location == NSNotFound) {
            continue;//если слово начинается не с введённой буквы(searchText)пропускает цикл и ищет в другом слове,но,т.к. слова
        }//в алфавитном порядке больше совпадений по первой букве не будет
       
        NSLog(@"currentLetter %@",currentLetter);
        Section* section = nil;
        NSString* firstLetter = [string substringToIndex:1];
        NSLog(@"firstLetter %@",firstLetter);
        if (![currentLetter isEqualToString:firstLetter]) {

        
        
        section = [[Section alloc]init];
        section.itemsArray = [NSMutableArray array];
        section.sectionName = firstLetter;
            currentLetter = firstLetter;
        [section.itemsArray addObject:string];
            
        [sectionsArray addObject:section];
        } else {
            section = [sectionsArray lastObject];
            [section.itemsArray addObject:string];
        }
    }
    self.sectionArray = sectionsArray;
    
    
    [self.tableView reloadData];
}



@end
