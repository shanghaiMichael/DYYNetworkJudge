# DYYNetworkJudge
针对iOS10 APP的网络被禁止的判断
Judge network in iOS10

原理：采用SFSafariViewController来发起请求，由于SFSafariViewController和APP是“隔离”的，所以即使该APP的网络权限被禁止了，SFSafariViewController仍然可以访问网络。最后根据- (void)safariViewController:(SFSafariViewController *)controller didCompleteInitialLoad:(BOOL)didLoadSuccessfully;来判断SFSafariViewController网络状态，加上普通的网络请求状态，就可以获得三个网络状态：1、网络连接成功 2、网络连接失败 3、APP的网络被用户禁止了

PS: 苹果要求SFSafariViewController必须展示，所以做好相关遇险措施！！！
