enum StaticPageTypeEnum {
  aboutUs,
  termsAndConditions,
  privacyPolicy,
  usagePolicy;

  String get title {
    switch (this) {
      case StaticPageTypeEnum.aboutUs:
        return "";
      case StaticPageTypeEnum.termsAndConditions:
        return "";
      case StaticPageTypeEnum.privacyPolicy:
        return "";
      case StaticPageTypeEnum.usagePolicy:
        return "";
    }
  }

  String get key {
    switch (this) {
      case StaticPageTypeEnum.aboutUs:
        return "about-app";
      case StaticPageTypeEnum.termsAndConditions:
        return "terms-and-conditions";
      case StaticPageTypeEnum.privacyPolicy:
        return "privacy-policy";
      case StaticPageTypeEnum.usagePolicy:
        return "usage-policy";
    }
  }
}
