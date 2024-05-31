import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:whatif_project/core/api/api_manager.dart';
import 'package:whatif_project/core/enum/screen_state.dart';
import 'package:whatif_project/features/questions/data/remote/data_sources/question_remote_ds_impl.dart';
import 'package:whatif_project/features/questions/data/remote/models/response_model.dart';
import 'package:whatif_project/features/questions/data/repositories/question_repo_impl.dart';
import 'package:whatif_project/features/questions/domain/use_cases/get_response_use_case.dart';
import 'package:whatif_project/features/questions/presentation/bloc/question_bloc.dart';
import 'package:whatif_project/features/story/data/models/clues_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:flutter_image/flutter_image.dart';

class StoryScreen extends StatelessWidget {
  CluesModel cluesModel;

  StoryScreen({
    super.key,
    required this.cluesModel,
  });

  ResponseModel? story;
  int ind=0;

  List<String> paragraphs = [];

  ScreenshotController screenshotController = ScreenshotController();

  void splitStoryToParagraphs(String fullStory) {
    paragraphs = fullStory.split('\n\n');
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuestionBloc(
        GetResponseUseCase(
          QuestionRepoImpl(
            QuestionsRemoteDSImpl(
              ApiManager(),
            ),
          ),
        ),
        cluesModel,
      )..add(QuestionGetResponse()),
      child: BlocConsumer<QuestionBloc, QuestionState>(
        listener: (context, state) {
          if (state.type == ScreenType.failures) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text("Error"),
                content: Text(state.failures?.message ?? ""),
              ),
            );
          } else if (state.type == ScreenType.success) {
            story = state.responseModel;
            splitStoryToParagraphs(story!.response.toString());
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.deepPurple,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: Text(
                "WHAT IF?!",
                style: TextStyle(
                    fontFamily: 'Jersey', color: Colors.white, fontSize: 35),
              ),
              centerTitle: true,
              iconTheme: IconThemeData(color: Colors.white),
            ),
            body: Container(
              height: MediaQuery.of(context).size.height * .95,
              child: state.type == ScreenType.loading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: Colors.green,
                      ),
                    )
                  : Column(
                      children: [
                        Screenshot(
                          controller: screenshotController,
                          child: CarouselSlider.builder(
                            itemCount: paragraphs.length,
                            itemBuilder: (BuildContext context, int index,
                                int realIndex) {
                              ind =index;
                              return Center(
                                child: SingleChildScrollView(
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * .9,
                                    // height: MediaQuery.of(context).size.height * .9,
                                    margin: EdgeInsets.all(15),
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: Colors.orangeAccent,
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    child: Text(
                                      paragraphs[index],
                                      style: TextStyle(
                                        fontFamily: 'Marhey',
                                          color: Colors.black, fontSize: 30),
                                      textAlign: TextAlign.center,
                                      textDirection: TextDirection.rtl,
                                    ),
                                  ),
                                ),
                              );
                            },
                            options: CarouselOptions(
                              autoPlay: false,
                              height: MediaQuery.of(context).size.height * .7,
                              viewportFraction: 0.8,
                              enableInfiniteScroll: false,
                              aspectRatio:2.0,
                              enlargeCenterPage: false,

                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => createImageWithText(paragraphs[ind]),
                          child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * .85,
                            padding: EdgeInsets.symmetric(vertical: 7),
                            decoration: BoxDecoration(
                                color: Colors.orangeAccent,
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              "Save Image",
                              style: TextStyle(
                                  fontFamily: 'Jersey',
                                  color: Colors.white,
                                  fontSize: 30),
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          );
        },
      ),
    );
  }

  Future<Uint8List?> _captureImage() async {
    return await screenshotController.capture();
  }

  void _saveImage() async {
    final imageBytes = await screenshotController.capture();
    if (imageBytes != null) {
      final directory = await getApplicationDocumentsDirectory();
      final filename = DateTime.now().toString() + '.png';
      final path = File(join(directory.path, filename)); // Use join method here
      await path.writeAsBytes(imageBytes);

      // Save image to gallery
      final result = await ImageGallerySaver.saveImage(Uint8List.fromList(imageBytes));

      if (result['isSuccess']) {
        print("Image Saved");
      } else {
        print("Failed to save image: ${result['error']}");
      }
    } else {
      print('Failed to capture screenshot!');
    }
  }


  Future<bool> _requestStoragePermission() async {
    // Check if rationale should be shown before requesting
    if (await Permission.storage.shouldShowRequestRationale) {
      print("9999999999999999999999999999999999999");
    }
    var permissionStatus = await Permission.storage.request();
    print(Permission.storage.status);
    if (permissionStatus.isGranted) {
      // Permission granted!
      return true;
    } else if (permissionStatus.isDenied) {
      // Permission denied
      await openAppSettings(); // Open app settings for user to allow permission manually
      return false;
    } else if (permissionStatus.isPermanentlyDenied) {
      // Permission permanently denied, you can display a message asking the user
      // to enable it from app settings
      return false;
    } else {
      // We don't know what happened yet
      return false;
    }
  }


  Future<void> createImageWithText(String text) async {
    // Load an image from assets
    final ByteData data = await rootBundle.load('assets/images/background.png');
    final Uint8List bytes = data.buffer.asUint8List();
    final ui.Image image = await decodeImageFromList(bytes);

    // Define the target width and height for the text
    final double targetWidth = 2500;
    final double targetHeight = 2000;

    // Calculate the scale factors for width and height
    final double widthScaleFactor = targetWidth / image.width.toDouble();
    final double heightScaleFactor = targetHeight / image.height.toDouble();

    // Determine the minimum scale factor needed to fit the text in both dimensions
    final double minScaleFactor = widthScaleFactor < heightScaleFactor ? widthScaleFactor : heightScaleFactor;

    // Calculate the scaled font size
    final double scaledFontSize = 150 * minScaleFactor;

    // Define text properties using ui.TextStyle
    final textStyle = ui.TextStyle(
      fontFamily: 'Marhey',
      color: Colors.black,
      fontSize: scaledFontSize,
    );

    // Calculate text size
    final paragraphStyle = ui.ParagraphStyle(
      textAlign: TextAlign.center,
      fontSize: scaledFontSize,
      textDirection: TextDirection.ltr,
    );

    final paragraphBuilder = ui.ParagraphBuilder(paragraphStyle)
      ..pushStyle(textStyle)
      ..addText(text);
    final paragraph = paragraphBuilder.build();
    paragraph.layout(ui.ParagraphConstraints(width: targetWidth));

    // Calculate text position
    final textOffset = Offset(
      (image.width - paragraph.width) / 2,
      (image.height - paragraph.height) / 2,
    );

    // Create a Picture and Canvas
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);

    // Draw the image
    canvas.drawImage(image, Offset.zero, Paint());

    // Print text onto the image
    canvas.drawParagraph(paragraph, textOffset);

    // Convert the Picture to a Drawable
    final picture = recorder.endRecording();
    final img = await picture.toImage(image.width, image.height);

    // Convert the Drawable to a byte buffer
    final ByteData? byteData = await img.toByteData(format: ui.ImageByteFormat.png);
    if (byteData != null) {
      final buffer = byteData.buffer.asUint8List();

      // Save the modified image to a temporary file
      final directory = await getTemporaryDirectory();
      final imagePath = '${directory.path}/image_with_text.png';
      final File file = File(imagePath);
      await file.writeAsBytes(buffer);

      // Save the image to the gallery
      final result = await ImageGallerySaver.saveFile(imagePath);
      print('Image saved to gallery: $result');
    } else {
      print('Failed to convert image.');
    }
  }


}


