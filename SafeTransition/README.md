SafeTransition
==============

If you push (or pop) a view controller with animation(animated:YES) it doesn't complete right away, and bad things happen if you do another push or pop before the animation completes. 

To reproduce this bug, try pushing or popping two view controllers at the same time. Example:

	- (void)viewWillAppear:(BOOL)animated
	{
		[super viewWillAppear:animated];
		UIViewController *vc = [[UIViewController alloc] init];
		[self.navigationController pushViewController:vc animated:YES];
	}

You will receive this error:
> 2014-07-03 11:54:25.051 Demo[2840:60b] nested push animation can result in corrupted navigation bar
> 2014-07-03 11:54:25.406 Demo[2840:60b] Finishing up a navigation transition in an unexpected state. Navigation Bar subview tree might get corrupted.

Just add the code files into your project and makes your navigation controller as a subclass of APBaseNavigationController, and you'll be good to do.
