import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ismart/core/entities/media_entity.dart';
import 'package:ismart/repository/abstractions/media_repository.dart';
import 'package:mime/mime.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';

class GalleryProvider extends ChangeNotifier {
  final MediaRepository _repository = MediaRepository.getInstance();

  final List<String> _selectedMedias = [];
  List<String> get selectedMedias => _selectedMedias;

  late BehaviorSubject<List<MediaEntity>> _mediaStreamController;
  Stream<List<MediaEntity>> get mediaStream => _mediaStreamController.stream;

  void importFromGallery() async {
    var picker = ImagePicker();

    var files = await picker.pickMultiImage(
      imageQuality: 50,
      maxHeight: 500,
      maxWidth: 500,
    );

    if (files.isEmpty) return;

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
    _mediaStreamController.sink.add([
      ...entities,
      ..._mediaStreamController.value,
    ]);
  }

  void importFromCamera() async {
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

      _mediaStreamController.sink.add([
        entity,
        ..._mediaStreamController.value,
      ]);
    }
  }

  void _refresh() async {
    var medias = await _repository.getMedias();
    _mediaStreamController.sink.add(medias);
  }

  GalleryProvider() {
    _mediaStreamController = BehaviorSubject();
    _mediaStreamController.onListen = _refresh;
  }

  void toogleSelection(String mediaId) {
    _selectedMedias.contains(mediaId) ? _selectedMedias.remove(mediaId) : _selectedMedias.add(mediaId);
    notifyListeners();
  }

  void confirmSelection(BuildContext context) {
    var entities = _mediaStreamController.value
        .where(
          (element) => _selectedMedias.contains(element.mediaId),
        )
        .toList();

    Navigator.of(context).pop(entities);
  }

  @override
  void dispose() {
    _mediaStreamController.close();
    super.dispose();
  }
}
