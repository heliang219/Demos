//
//  CustomerTabBar.m
//  XMNiao_Customer
//
//  Created by Esc on 14/10/21.
//  Copyright (c) 2014年 Luo. All rights reserved.
//

#import "CustomerTabBar.h"

#define SLIDE_ANIMATION_DURATION 0.0

@interface CustomerTabBar ()

@end

@implementation CustomerTabBar
@synthesize viewControllers = _viewControllers;
@synthesize seletedIndex = _seletedIndex;
@synthesize previousNavViewController = _previousNavViewController;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _seletedIndex = -1;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
//    初始化tabBar普通状态和高亮状态的图片名称数组。
    _nomalImageArray = [[NSArray alloc] initWithObjects:@"t-nav1.png", @"t-nav2.png",@"t-nav3.png",nil];
    _hightlightedImageArray = [[NSArray alloc] initWithObjects:@"t-nav1-press.png", @"t-nav2-press.png",@"t-nav3-press.png",nil];
    self.view.backgroundColor = [UIColor clearColor];
//加载自定义tabBar的UI
    [self loadUI];
}

- (void)loadUI{
    
//    创建自定义导航的UI;
    UIButton *mainBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    mainBtn.frame = CGRectMake(0, 0, 320 / 3, 49);
    [mainBtn addTarget:self action:@selector(tabBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    mainBtn.tag = 1;
    
    [mainBtn setImage:[UIImage imageNamed:[_nomalImageArray objectAtIndex:0]] forState:UIControlStateNormal];
    
    UIButton *pictureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    pictureBtn.frame = CGRectMake(320 / 3, 0, 320 / 3, 49);
    [pictureBtn addTarget:self action:@selector(tabBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    pictureBtn.tag = 2;
    
    [pictureBtn setImage:[UIImage imageNamed:[_nomalImageArray objectAtIndex:1]] forState:UIControlStateNormal];
    
    
    UIButton *mySelfBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    mySelfBtn.frame = CGRectMake((320 / 3) * 2, 0, 320 / 3 + 2, 49);
    [mySelfBtn addTarget:self action:@selector(tabBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    mySelfBtn.tag = 3;
    
    [mySelfBtn setImage:[UIImage imageNamed:[_nomalImageArray objectAtIndex:2]] forState:UIControlStateNormal];

    _tabBarView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 49, 320, 49)];
    
//    UIImageView *tabBarBG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"toolbar_bg.png"]];
//    tabBarBG.frame = CGRectMake(0, 0, 320, 49);
    
//    [_tabBarView addSubview:tabBarBG];
    [_tabBarView addSubview:mainBtn];
    [_tabBarView addSubview:pictureBtn];
    [_tabBarView addSubview:mySelfBtn];
    
    [self.view addSubview:_tabBarView];
    
    
}

- (void)setTabBarBackgroundColor:(UIColor *)color{
    _tabBarView.backgroundColor = color;
}

- (void)tabBarButtonClicked:(UIButton *)sender{
    
	long index = sender.tag - 1;
    
	self.seletedIndex = index;
    
}


- (void)setSeletedIndex:(long)aIndex
{
	if (_seletedIndex == aIndex) return;
	
	if (_seletedIndex >= 0)
	{
		UIViewController *priviousViewController = [_viewControllers objectAtIndex:_seletedIndex];
        //[priviousViewController viewWillDisappear:NO];
        [priviousViewController.view removeFromSuperview];
        //[priviousViewController viewDidDisappear:NO];
		
		UIButton *previousButton = (UIButton *)[self.view viewWithTag:_seletedIndex + 1];
		[previousButton setImage:[UIImage imageNamed:[_nomalImageArray objectAtIndex:_seletedIndex]] forState:UIControlStateNormal];
        [previousButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
	}
	
	_seletedIndex = aIndex;
	
	UIButton *currentButton = (UIButton *)[self.view viewWithTag:(aIndex + 1)];
	[currentButton setImage:[UIImage imageNamed:[_hightlightedImageArray objectAtIndex:aIndex]] forState:UIControlStateNormal];
//    [currentButton setBackgroundImage:[UIImage imageNamed:@"tab_button_selected_bg.png"] forState:UIControlStateNormal];
	
	UIViewController *currentViewController = [_viewControllers objectAtIndex:aIndex];
	if ([currentViewController isKindOfClass:[UINavigationController class]])
	{
		((UINavigationController *)currentViewController).delegate = self;
	}
	currentViewController.view.frame = CGRectMake(0, 0, 320, self.view.bounds.size.height - 49);
	
	[self.view addSubview:currentViewController.view];
	[currentViewController viewWillAppear:NO];
	[currentViewController viewDidAppear:NO];
	
    [self.view sendSubviewToBack:currentViewController.view];
}


#pragma mark -
#pragma mark UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
	if (!_previousNavViewController)
	{
		self.previousNavViewController = navigationController.viewControllers;
	}
	
	
	BOOL isPush = NO;
	if ([_previousNavViewController count] <= [navigationController.viewControllers count])
	{
		isPush = YES;
	}
	
	BOOL isPreviousHidden = [[_previousNavViewController lastObject] hidesBottomBarWhenPushed];
	BOOL isCurrentHidden = viewController.hidesBottomBarWhenPushed;
	
	self.previousNavViewController = navigationController.viewControllers;
	
	if (!isPreviousHidden && !isCurrentHidden)
	{
		return;
	}
	else if(isPreviousHidden && isCurrentHidden)
	{
		return;
	}
	else if(!isPreviousHidden && isCurrentHidden)
	{
		//隐藏tabbar
		[self hideTabBar:isPush ? LPSlideDirectionLeft : LPSlideDirectionRight  animated:animated];
	}
	else if(isPreviousHidden && !isCurrentHidden)
	{
		//显示tabbar
		[self showTabBar:isPush ? LPSlideDirectionLeft : LPSlideDirectionRight animated:animated];
	}
	
}

- (void)showTabBar:(LPSlideDirection)direction animated:(BOOL)isAnimated
{
	CGRect tempRect = _tabBarView.frame;
	tempRect.origin.x = self.view.bounds.size.width * ( (direction == LPSlideDirectionLeft) ? 1 : -1);
	_tabBarView.frame = tempRect;
	
	[UIView animateWithDuration:isAnimated ? SLIDE_ANIMATION_DURATION : 0 delay:0 options:0 animations:^
	 {
		 CGRect tempRect = _tabBarView.frame;
		 tempRect.origin.x = 0;
		 _tabBarView.frame = tempRect;
		 
	 }
                     completion:^(BOOL finished)
	 {
		 UIViewController *currentViewController = [_viewControllers objectAtIndex:_seletedIndex];
		 
		 CGRect viewRect = currentViewController.view.frame;
		 viewRect.size.height = self.view.bounds.size.height - 43;
		 currentViewController.view.frame = viewRect;
	 }];
}




- (void)hideTabBar:(LPSlideDirection)direction animated:(BOOL)isAnimated
{
	UIViewController *currentViewController = [_viewControllers objectAtIndex:_seletedIndex];
	
	CGRect viewRect = currentViewController.view.frame;
	viewRect.size.height = self.view.bounds.size.height;
	currentViewController.view.frame = viewRect;
	
	CGRect tempRect = _tabBarView.frame;
	tempRect.origin.x = 0;
	_tabBarView.frame = tempRect;
	
	[UIView animateWithDuration:isAnimated ? SLIDE_ANIMATION_DURATION : 0 delay:0 options:0 animations:^
	 {
         
		 CGRect tempRect = _tabBarView.frame;
		 tempRect.origin.x = self.view.bounds.size.width * (direction == LPSlideDirectionLeft ? -1 : 1);
		 _tabBarView.frame = tempRect;
		 
	 }
                     completion:^(BOOL finished)
	 {
         
	 }];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
