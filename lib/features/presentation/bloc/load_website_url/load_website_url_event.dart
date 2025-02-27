part of 'load_website_url_bloc.dart';

abstract class LoadWebsiteUrlEvent {}

class LoadWebsiteUrlLoadEvent extends LoadWebsiteUrlEvent {
  String redirectUrl;
  LoadWebsiteUrlLoadEvent({
    required this.redirectUrl,
  });
}

class LoadCustomUrlLoadEvent extends LoadWebsiteUrlEvent {
  String? customUrl;
  LoadCustomUrlLoadEvent({
    required this.customUrl,
  });
}
