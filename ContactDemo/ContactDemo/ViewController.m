//
//  ViewController.m
//  ContactDemo
//
//  Created by pfl on 15/12/15.
//  Copyright © 2015年 pfl. All rights reserved.
//

#import "ViewController.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "Person.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, readwrite, strong) UITableView *tableView;
@property (nonatomic, readwrite, strong) NSArray *persons;
@property (nonatomic, readwrite, assign) CFIndex nPerson;
@property (nonatomic, readwrite, strong) NSArray *listArr;
@property (nonatomic, readwrite, strong) NSArray *sortArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _listArr = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",@"#"];
    [self getPersonsFromContacts];
    [self.view addSubview:self.tableView];
}


- (UITableView*)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView setContentInset:UIEdgeInsetsMake(20, 0, 0, 0)];
        [_tableView setScrollIndicatorInsets:_tableView.contentInset];
    }
    return _tableView;
}


- (void)getPersonsFromContacts {
    
    NSMutableArray *addressBookTemp = [NSMutableArray array];
    //新建一个通讯录类
    ABAddressBookRef addressBooks = nil;
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0) {
        addressBooks =  ABAddressBookCreateWithOptions(NULL, NULL);
        
        //获取通讯录权限
        
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        
        ABAddressBookRequestAccessWithCompletion(addressBooks, ^(bool granted, CFErrorRef error){dispatch_semaphore_signal(sema);});
        
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    }
    else {
        addressBooks = ABAddressBookCreate();
    }
    
    //获取通讯录中的所有人
    CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople(addressBooks);
    // 获取人数
    CFIndex nPerson = ABAddressBookGetPersonCount(addressBooks);
    self.nPerson = nPerson;
    
    for (int i = 0 ; i < nPerson; i++) {
        Person *person = [[Person alloc]init];
        ABRecordRef personR = CFArrayGetValueAtIndex(allPeople, i);
        CFTypeRef abName = ABRecordCopyValue(personR, kABPersonAddressProperty);
        
        CFTypeRef abLastName = ABRecordCopyValue(personR, kABPersonLastNameProperty);
        CFStringRef abFullName = ABRecordCopyCompositeName(personR);
        NSString *nameString = (__bridge NSString *)abName;
        NSString *lastNameString = (__bridge NSString *)abLastName;
        
        if ((__bridge id)abFullName != nil) {
            nameString = (__bridge NSString *)abFullName;
        } else {
            if ((__bridge id)abLastName != nil)
            {
                nameString = [NSString stringWithFormat:@"%@ %@", nameString, lastNameString];
            }
        }
        
        person.personname = nameString;
        ABPropertyID multiProperties[] = {
            kABPersonPhoneProperty,
            kABPersonEmailProperty
        };
        NSInteger multiPropertiesTotal = sizeof(multiProperties) / sizeof(ABPropertyID);
        for (NSInteger j = 0; j < multiPropertiesTotal; j++) {
            ABPropertyID property = multiProperties[j];
            ABMultiValueRef valuesRef = ABRecordCopyValue(personR, property);
            NSInteger valuesCount = 0;
            if (valuesRef != nil) valuesCount = ABMultiValueGetCount(valuesRef);
            
            if (valuesCount == 0) {
                CFRelease(valuesRef);
                continue;
            }
            //获取电话号码和email
            for (NSInteger k = 0; k < valuesCount; k++) {
                CFTypeRef value = ABMultiValueCopyValueAtIndex(valuesRef, k);
                switch (j) {
                    case 0: {// Phone number
                        person.telephone = (__bridge NSString*)value;
//                        person.personname = (__bridge NSString*)value;
            

                        break;
                    }
                    case 1: {// Email
                        person.email = (__bridge NSString*)value;
                        break;
                    }
                }
                CFRelease(value);
            }
            CFRelease(valuesRef);
        }
        //将个人信息添加到数组中，循环完成后addressBookTemp中包含所有联系人的信息
        [addressBookTemp addObject:person];
        
        if (abName) CFRelease(abName);
        if (abLastName) CFRelease(abLastName);
        if (abFullName) CFRelease(abFullName);

    }
    
    self.persons = [addressBookTemp copy];
    
    [self sortArr:self.persons];
}

- (void)sortArr:(NSArray*)arr1 {
    
    NSMutableArray *temArr = [NSMutableArray arrayWithCapacity:27];
    
    for (int i = 0; i < self.listArr.count; i++) {
        NSMutableArray *arr = [NSMutableArray array];
        [temArr addObject:arr];
    }
    
    for (Person *person in self.persons) {
        
        if (!person.personname) {
            continue;
        }
        CFStringRef cString = (__bridge CFStringRef)(person.personname?:@"");
        
        CFMutableStringRef string = CFStringCreateMutableCopy(NULL, 0, (CFStringRef)cString);
        
        CFStringTransform(string, NULL, kCFStringTransformStripCombiningMarks, false);
        
        NSString *toString = (__bridge NSString *)(string);
        if (toString.length == 0 || !toString) {
            NSMutableArray *arr = [temArr objectAtIndex:self.listArr.count-1];
            [arr addObject:person];
            return;
        }
        NSString *firstString = [toString substringToIndex:1];
        [self.listArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *str = obj;
            if ([str isEqualToString:firstString]) {
                NSMutableArray *arr = [temArr objectAtIndex:idx];
                [arr addObject:person];
            }
            
        }];
        CFRelease(string);

    }
    
    self.sortArr = [temArr copy];
    [self.tableView reloadData];
}



#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sortArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];

    }
    if (self.persons.count) {
        Person *person = self.persons[indexPath.section];
        cell.textLabel.text = person.personname?:@"";
        cell.detailTextLabel.text = person.telephone;
    }
    
    return cell;
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return self.listArr.count;
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.listArr;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.listArr[section];
}





@end












