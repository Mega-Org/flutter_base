import '../deep_link_utils.dart';
import '../factory/deeplink_visitor.dart';

abstract class IDeepLinkVisitorState {
  const IDeepLinkVisitorState();

  factory IDeepLinkVisitorState.fromUri(final Uri uri) {
    final List<String> linkSeqments = uri.pathSegments;
    if (linkSeqments.contains(DeepLinksUtils.shareAdsSeqment)) {
      final int? id = int.tryParse(linkSeqments.lastOrNull ?? '');
      if (id != null) {
        return AdsDeepLinkVisitorState(id: id);
      }
    }
    return const GenericDeepLinkVisitorState();
  }

  void accept(final IDeepLinkVisitor visitor);
}

class GenericDeepLinkVisitorState implements IDeepLinkVisitorState {
  const GenericDeepLinkVisitorState();

  @override
  void accept(final IDeepLinkVisitor visitor) => visitor.visit(this);
}

class AdsDeepLinkVisitorState implements IDeepLinkVisitorState {
  final int id;
  const AdsDeepLinkVisitorState({required this.id});

  @override
  void accept(final IDeepLinkVisitor visitor) => visitor.visitAdsDetails(this);
}
