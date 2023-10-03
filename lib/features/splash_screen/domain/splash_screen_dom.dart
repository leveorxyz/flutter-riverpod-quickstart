abstract class SplashDomain {
  void versionCheck();

  void permissionCheck();

  void showNotification();
  // void showNotification({@required RemoteMessage message});
}

class SplashDomI implements SplashDomain {
  @override
  void permissionCheck() {
    // TODO: location Permission Check
    // TODO: Push notification Permission Check
  }

  @override
  void showNotification() {
    // TODO:  Notifcation Showing
  }

  @override
  void versionCheck() {
    // TODO: version check From Api
  }
}
