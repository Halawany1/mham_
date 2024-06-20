class ApiConstant{
  static const String baseUrl=
      'https://ma7am.com/api';
  static const String register='/user/register';
  static const String registerDriver='/auth/driver/register';
  static const String login='/auth/login';
  static  String deleteUser(int id)=>'/user/$id';
  static const String loginDriver='/auth/login';
  static const String transactions='/transactions';
  static const String logout='/auth/logout';
  static const String refresh='/auth/refresh';
  static const String wallet='/wallets/me';
  static const String profile='/user/profile';
  static const String profileDriver='/drivers/me';
  static const String notifications='/notifications';
  static String cancelOrder(int id)=>'/orders/$id/cancel';
  static String cancelProduct(int id)=>'/order-items/$id/cancel';
  static const String updateProfile='/user/updateProfile';
  static const String verifyOtp='/auth/forget-password';
  static const String returnsMe='/users/me/return-products';
  static const String productRating='/product-ratings';
  static const String product='/products/getAll';
  static const String carModelsAvailable='/carModelsAvailable';
  static const String getCart='/cart';
  static  String returnOrder(int orderId)=>
      "/orders/$orderId/returns";
  static const String myScrap='/users/me/scraps';
  static const String increaseReview='/products/getOneForUser/';
  static const String deleteCart='/cart/cart-items/';
  static const String productDetails='/products/getOneForUser/';
  static const String updateCart='/cart/updateCartProduct';
  static const String addToCart='/cart/cart-items/';
  static const String addScrap='/user/addScrap';
  static const String addRate='/products/addRate/';
  static const String orders='/users/me/orders';
  static const String updateOrder='/orders';
  static const String updateOrderItemStatus='/order-items';
  static const String orderDriver='/orders';
  static  String historyOrder(int driverId)=>
      '/drivers/$driverId/orders';
  static  String assignedOrder(int driverId)=>
      '/drivers/$driverId/active-order';
  static  String returnAssignedOrder(int driverId)=>
      '/drivers/$driverId/active-return';
  static  String cancelOrderDriver(int id)=>
      '/api/orders/$id/cancel';
  static const String addAndRemoveFavorite='/products/addAndRemoveFromFavourite/';
}