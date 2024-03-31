import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ismart/core/entities/media_entity.dart';
import 'package:ismart/repository/abstractions/i_media_repository.dart';
import 'package:mime/mime.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';

class GalleryListProvider extends ChangeNotifier {
  final IMediaRepository _repository = IMediaRepository.getInstance();

  final List<String> _selectedMedias = [];
  List<String> get selectedMedias => _selectedMedias;

  late BehaviorSubject<List<MediaEntity>> _mediaStreamController;
  Stream<List<MediaEntity>> get mediaStream => _mediaStreamController.stream;

  Future<List<MediaEntity>> _importFromGallery() async {
    var picker = ImagePicker();

    var files = await picker.pickMultiImage(
      imageQuality: 50,
      maxHeight: 500,
      maxWidth: 500,
    );

    var bytes = await Future.wait(files.map((e) => e.readAsBytes()));

    var entities = files
        .mapIndexed(
          (index, element) => MediaEntity(
            mediaId: const Uuid().v4(),
            data: bytes[index],
            mimeType: lookupMimeType(element.name) ?? '',
            name: element.name,
          ),
        )
        .toList();

    await _repository.addMedias(entities);

    return entities;
  }

  Future<List<MediaEntity>> _importFromCamera() async {
    var picker = ImagePicker();

    var file = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxHeight: 500,
      maxWidth: 500,
    );

    if (file is XFile) {
      var bytes = await file.readAsBytes();

      var entity = MediaEntity(
        mediaId: const Uuid().v4(),
        data: bytes,
        mimeType: lookupMimeType(file.name) ?? '',
        name: file.name,
      );

      await _repository.addMedias([entity]);
      return [entity];
    }

    return [];
  }

  void _initialize() async {
    var medias = await _repository.getMedias();
    _mediaStreamController.sink.add(medias);
  }

  GalleryListProvider() {
    _mediaStreamController = BehaviorSubject();
    _mediaStreamController.onListen = _initialize;
  }

  void toogleSelection(String mediaId) {
    _selectedMedias.contains(mediaId) ? _selectedMedias.remove(mediaId) : _selectedMedias.add(mediaId);
    notifyListeners();
  }

  @override
  void dispose() {
    _mediaStreamController.close();
    super.dispose();
  }
}
