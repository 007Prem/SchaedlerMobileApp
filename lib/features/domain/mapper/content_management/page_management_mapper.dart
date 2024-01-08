import 'package:commerce_flutter_app/features/domain/converter/cms_converter/action_layout_type_converter.dart';
import 'package:commerce_flutter_app/features/domain/converter/cms_converter/page_type_converter.dart';
import 'package:commerce_flutter_app/features/domain/converter/cms_converter/page_widget_type_converter.dart';
import 'package:commerce_flutter_app/features/domain/converter/cms_converter/product_carousel_type_converter.dart';
import 'package:commerce_flutter_app/features/domain/converter/cms_converter/top_sellers_categories_converter.dart';
import 'package:commerce_flutter_app/features/domain/entity/content_management/page_content_management_entity.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class PageContentManagementMapper {
  PageContentManagementEntity toEntity(PageContentManagement model) =>
      PageContentManagementEntity(
        page: model.page != null ? toPageInformationEntity(model.page!) : null,
        statusCode: model.statusCode,
        redirectTo: model.redirectTo,
        authorizationFailed: model.authorizationFailed,
        isAuthenticatedOnServer: model.isAuthenticatedOnServer,
        bypassedAuthorization: model.bypassedAuthorization,
        requiresAuthorization: model.requiresAuthorization,
        alternateLanguageUrls: model.alternateLanguageUrls,
      );

  PageInformationEntity toPageInformationEntity(PageInformation model) =>
      PageInformationEntity(
        nodeId: model.nodeId,
        name: model.name,
        type: PageTypeConverter.convert(model.type ?? ""),
        parentId: model.parentId,
        sortOrder: model.sortOrder,
        websiteId: model.websiteId,
        variantName: model.variantName,
        layoutPageId: model.layoutPageId,
        templateHash: model.templateHash,
        widgets: null,
        id: model.id,
        generalFields: model.generalFields != null
            ? toPageSettingsEntity(model.generalFields!)
            : null,
        translatableFields: model.translatableFields != null
            ? toLocalizationEntity(model.translatableFields!)
            : null,
        contextualFields: model.contextualFields,
      );

  PageSettingsEntity toPageSettingsEntity(PageSettings model) =>
      PageSettingsEntity(
        hideHeader: model.hideHeader,
        hideFooter: model.hideFooter,
        hideFromSearchEngines: model.hideFromSearchEngines,
        hideFromSiteSearch: model.hideFromSiteSearch,
        hideBreadcrumbs: model.hideBreadcrumbs,
        excludeFromNavigation: model.excludeFromNavigation,
        excludeFromSignInRequired: model.excludeFromSignInRequired,
        variantName: model.variantName,
        horizontalRule: model.horizontalRule,
        tags: model.tags,
      );

  PageWidgetEntity toPageWidgetEntity(PageWidget model) => PageWidgetEntity(
        parentId: model.parentId,
        type: PageWidgetTypeConverter.convert(model.type ?? ''),
        zone: model.zone,
        isLayout: model.isLayout,
        id: model.id,
        generalFields: model.generalFields != null
            ? toPageWidgetFieldsEntity(model.generalFields!)
            : null,
        translatableFields: model.translatableFields != null
            ? toTranslatableFieldsEntity(model.translatableFields!)
            : null,
        contextualFields: model.contextualFields,
      );

  PageWidgetFieldsEntity toPageWidgetFieldsEntity(PageWidgetFields model) =>
      PageWidgetFieldsEntity(
        timerSpeed: model.timerSpeed,
        animationSpeed: model.animationSpeed,
        carouselType:
            ProductCarouselTypeConverter.convert(model.carouselType ?? ''),
        displayProductsFrom: TopSellersCategoriesSpanConverter.convert(
            model.displayProductsFrom ?? ''),
        selectedCategoryIds: model.selectedCategoryIds,
        showImage: model.showImage,
        showTitle: model.showTitle,
        showPrice: model.showPrice,
        layout: ActionsLayoutConverter.convert(model.layout ?? ''),
      );

  TranslatableFieldsEntity toTranslatableFieldsEntity(
          TranslatableFields model) =>
      TranslatableFieldsEntity(
        title: model.title,
        slides: model.slides,
        links: model.links,
      );

  LocalizationEntity toLocalizationEntity(Localization model) =>
      LocalizationEntity(
        title: model.title,
        links: model.links,
        slides: model.slides,
      );
}
