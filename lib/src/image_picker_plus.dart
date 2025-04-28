import 'package:flutter/material.dart';
import 'package:image_picker_plus/image_picker_plus.dart';
export 'package:image_picker_plus/src/gallery_display.dart';

import 'dart:io';

import 'package:flutter/foundation.dart';

extension ImagePickerPlus on BuildContext {
  Future<SelectedImagesDetails?> pickImage({
    required ImageSource source,
    GalleryDisplaySettings? galleryDisplaySettings,
    bool multiImages = false,
    FilterOptionGroup? filterOption,
  }) async {
    return _pushToCustomPicker(
      galleryDisplaySettings: galleryDisplaySettings,
      multiSelection: multiImages,
      pickerSource: PickerSource.image,
      source: source,
      filterOption: filterOption,
    );
  }

  Future<SelectedImagesDetails?> pickVideo({
    required ImageSource source,
    GalleryDisplaySettings? galleryDisplaySettings,
    bool multiVideos = false,
    FilterOptionGroup? filterOption,
  }) async {
    return _pushToCustomPicker(
      galleryDisplaySettings: galleryDisplaySettings,
      multiSelection: multiVideos,
      pickerSource: PickerSource.video,
      source: source,
      filterOption: filterOption,
    );
  }

  Future<SelectedImagesDetails?> pickBoth({
    required ImageSource source,
    GalleryDisplaySettings? galleryDisplaySettings,
    bool multiSelection = false,
    FilterOptionGroup? filterOption,
  }) async {
    return _pushToCustomPicker(
      galleryDisplaySettings: galleryDisplaySettings,
      multiSelection: multiSelection,
      pickerSource: PickerSource.both,
      source: source,
      filterOption: filterOption,
    );
  }

  Future<SelectedImagesDetails?> _pushToCustomPicker({
    required ImageSource source,
    GalleryDisplaySettings? galleryDisplaySettings,
    bool multiSelection = false,
    required PickerSource pickerSource,
    FilterOptionGroup? filterOption,
  }) =>
      Navigator.of(this, rootNavigator: true).push(
        MaterialPageRoute(
          builder: (context) => CustomImagePicker(
            galleryDisplaySettings: galleryDisplaySettings,
            multiSelection: multiSelection,
            pickerSource: pickerSource,
            source: source,
            filterOption: filterOption,
          ),
          maintainState: false,
        ),
      );
}



/// {@template ecom_image_picker}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class PickImage {
  ///
  factory PickImage() => _internal;

  /// {@macro ecom_image_picker}
  PickImage._();

  static final PickImage _internal = PickImage._();

  late TabsTexts _tabsTexts;

  /// To initialize the tabs texts for your app
  /// just call this method and pass your own [TabsTexts]
  void init({TabsTexts? tabsTexts}) {
    _tabsTexts = tabsTexts ?? const TabsTexts();
  }

  static final _defaultFilterOption = FilterOptionGroup(
    videoOption: FilterOption(
      durationConstraint: DurationConstraint(max: 3.minutes),
    ),
  );

  AppTheme _appTheme(BuildContext context) => AppTheme(
        focusColor: context.adaptiveColor,
        primaryColor: context.reversedAdaptiveColor,
      );

  SliverGridDelegateWithFixedCrossAxisCount _sliverGridDelegate() =>
      const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 1.7,
        mainAxisSpacing: 1.5,
      );

  Future<void> pickImagesAndVideos(
    BuildContext context, {
    required Future<void> Function(
      BuildContext context,
      SelectedImagesDetails,
    ) onMediaPicked,
    bool cropImage = true,
    bool showPreview = true,
    int maxSelection = 10,
    bool multiSelection = true,
  }) =>
      context.pickBoth(
        source: ImageSource.both,
        multiSelection: multiSelection,
        filterOption: _defaultFilterOption,
        galleryDisplaySettings: GalleryDisplaySettings(
          maximumSelection: maxSelection,
          showImagePreview: showPreview,
          cropImage: cropImage,
          tabsTexts: _tabsTexts,
          appTheme: _appTheme(context),
          callbackFunction: (details) => onMediaPicked.call(context, details),
        ),
      );

  Future<SelectedImagesDetails?> pickImage(
    BuildContext context, {
    ImageSource source = ImageSource.gallery,
    int maxSelection = 1,
    bool cropImage = true,
    bool multiImages = false,
    bool showPreview = true,
    bool pickAvatar = false,
  }) =>
      context.pickImage(
        source: source,
        multiImages: multiImages,
        filterOption: _defaultFilterOption,
        galleryDisplaySettings: GalleryDisplaySettings(
          cropImage: cropImage,
          maximumSelection: maxSelection,
          showImagePreview: showPreview,
          tabsTexts: _tabsTexts,
          pickAvatar: pickAvatar,
          appTheme: _appTheme(context),
          gridDelegate: _sliverGridDelegate(),
        ),
      );

  Future<void> pickVideo(
    BuildContext context, {
    required Future<void> Function(
      BuildContext context,
      SelectedImagesDetails,
    ) onMediaPicked,
    ImageSource source = ImageSource.both,
    int maxSelection = 10,
    bool cropImage = true,
    bool multiImages = false,
    bool showPreview = true,
  }) =>
      context.pickVideo(
        source: source,
        filterOption: _defaultFilterOption,
        galleryDisplaySettings: GalleryDisplaySettings(
          showImagePreview: showPreview,
          cropImage: cropImage,
          maximumSelection: maxSelection,
          tabsTexts: _tabsTexts,
          appTheme: _appTheme(context),
          callbackFunction: (details) => onMediaPicked.call(context, details),
        ),
      );

  Widget customMediaPicker({
    required BuildContext context,
    required ImageSource source,
    required PickerSource pickerSource,
    required ValueSetter<SelectedImagesDetails> onMediaPicked,
    Key? key,
    bool multiSelection = true,
    FilterOptionGroup? filterOption,
    VoidCallback? onBackButtonTap,
    bool wantKeepAlive = true,
    int maximumSelection = 10,
  }) =>
      CustomImagePicker(
        key: key,
        galleryDisplaySettings: GalleryDisplaySettings(
          maximumSelection: maximumSelection,
          showImagePreview: true,
          cropImage: true,
          tabsTexts: _tabsTexts,
          appTheme: _appTheme(context),
          callbackFunction: (details) async => onMediaPicked.call(details),
        ),
        wantKeepAlive: wantKeepAlive,
        multiSelection: multiSelection,
        pickerSource: pickerSource,
        source: source,
        filterOption: _defaultFilterOption,
        onBackButtonTap: onBackButtonTap,
      );

  /// Reads image as bytes.
  Future<Uint8List> imageBytes({required File file}) =>
      compute<File, Uint8List>((file) => file.readAsBytes(), file);
}

