import 'package:flutter/material.dart';
import 'package:flutter_base/core/core.dart';
import '../states/i_deeplink_visitor_state.dart';
import 'deeplink_visitor.dart';

class DeepLinkVisitorImp implements IDeepLinkVisitor {
  DeepLinkVisitorImp();

  @override
  void visit(final IDeepLinkVisitorState visitor) {}

  @override
  void visitAdsDetails(AdsDeepLinkVisitorState state) async {
    final context = _getContext;
    if (context != null) {
      const bool isAlreadyOpened = false;
      // AppRouter.getCurrentRoute == AppRoutes.advertismentDetails;
      // ignore: dead_code
      if (isAlreadyOpened) {
        // Navigator.of(context).pushReplacementNamed(
        //   AppRoutes.advertismentDetails,
        //   arguments: ShowAdvertismentDetailsPage(id: state.id),
        // );
      } else {
        // Navigator.of(context).pushNamed(
        //   AppRoutes.advertismentDetails,
        //   arguments: ShowAdvertismentDetailsPage(id: state.id),
        // );
      }
    }
  }

  BuildContext? get _getContext {
    try {
      final context = appNavigatorKey.currentContext;
      if (context?.mounted == true) {
        return context;
      }
      return null;
    } catch (_) {
      return null;
    }
  }
}
