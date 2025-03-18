// import 'dart:io';
// import 'dart:typed_data';
// import 'package:tflite_flutter/tflite_flutter.dart';
// import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';
// import 'package:image/image.dart' as img;
// import 'dart:math';

// class FaceEmbeddingModel {
//   late Interpreter interpreter;
//   late List<int> inputShape;
//   late List<int> outputShape;
//   late TfLiteType inputType;
//   late TfLiteType outputType;
//   late InterpreterOptions interpreterOptions;

//   FaceEmbeddingModel();

//   Future<void> loadModel() async {
//     interpreterOptions = InterpreterOptions();
//     // You can add options here, e.g., number of threads.
//     interpreter = await Interpreter.fromAsset('face_embedding.tflite', options: interpreterOptions);
//     inputShape = interpreter.getInputTensor(0).shape;
//     outputShape = interpreter.getOutputTensor(0).shape;
//     inputType = interpreter.getInputTensor(0).type;
//     outputType = interpreter.getOutputTensor(0).type;
//   }

//   /// Preprocess the image:
//   /// - Reads the image from [imagePath]
//   /// - Decodes and resizes to the expected input dimensions.
//   /// - Normalizes pixel values (here, we assume values between -1 and 1).
//   List<double> processImage(String imagePath) {
//     final bytes = File(imagePath).readAsBytesSync();
//     final image = img.decodeImage(bytes);
//     if (image == null) {
//       throw Exception("Failed to decode image");
//     }
//     // Assume model expects input size as given by inputShape [1, height, width, 3]
//     int targetWidth = inputShape[2];
//     int targetHeight = inputShape[1];
//     img.Image resized = img.copyResize(image, width: targetWidth, height: targetHeight);
//     // Convert to float list normalized between -1 and 1.
//     List<double> imageData = [];
//     for (int y = 0; y < resized.height; y++) {
//       for (int x = 0; x < resized.width; x++) {
//         int pixel = resized.getPixel(x, y);
//         // The image package returns pixel values in ARGB format.
//         double r = img.getRed(pixel).toDouble();
//         double g = img.getGreen(pixel).toDouble();
//         double b = img.getBlue(pixel).toDouble();
//         // Normalize assuming input range [0,255] -> [-1, 1]
//         imageData.add((r - 127.5) / 127.5);
//         imageData.add((g - 127.5) / 127.5);
//         imageData.add((b - 127.5) / 127.5);
//       }
//     }
//     return imageData;
//   }

//   /// Run inference and return the embedding vector.
//   Future<List<double>> runInference(String imagePath) async {
//     // Ensure the model is loaded.
//     await loadModel();
//     List<double> input = processImage(imagePath);
//     // Create input tensor of shape [1, height, width, 3]
//     var inputTensor = [input];
//     // Prepare output buffer.
//     List output = List.filled(outputShape.reduce((a, b) => a * b), 0.0);
//     var outputTensor = [output];
//     interpreter.run(inputTensor, outputTensor);
//     // Flatten and return the output as List<double>
//     return List<double>.from(outputTensor[0]);
//   }
// }
// import 'dart:io';

// import 'package:image/image.dart' as img;
// import 'package:tflite_flutter/tflite_flutter.dart';

// class FaceEmbeddingModel {
//   late Interpreter interpreter;
//   late List<int> inputShape;
//   late List<int> outputShape;
//   late TfLiteType inputType;
//   late TfLiteType outputType;
//   late InterpreterOptions interpreterOptions;

//   FaceEmbeddingModel();

//   Future<void> loadModel() async {
//     interpreterOptions = InterpreterOptions();
//     // You can add options here, e.g., number of threads.
//     interpreter = await Interpreter.fromAsset('face_embedding.tflite',
//         options: interpreterOptions);
//     inputShape = interpreter.getInputTensor(0).shape;
//     outputShape = interpreter.getOutputTensor(0).shape;
//     inputType = interpreter.getInputTensor(0).type;
//     outputType = interpreter.getOutputTensor(0).type;
//   }

//   /// Preprocess the image:
//   /// - Reads the image from [imagePath]
//   /// - Decodes and resizes to the expected input dimensions.
//   /// - Normalizes pixel values (here, we assume values between -1 and 1).
//   List<double> processImage(String imagePath) {
//     final bytes = File(imagePath).readAsBytesSync();
//     final image = img.decodeImage(bytes);
//     if (image == null) {
//       throw Exception("Failed to decode image");
//     }
//     // Assume model expects input size as given by inputShape [1, height, width, 3]
//     int targetWidth = inputShape[2];
//     int targetHeight = inputShape[1];
//     img.Image resized =
//         img.copyResize(image, width: targetWidth, height: targetHeight);
//     // Convert to float list normalized between -1 and 1.
//     List<double> imageData = [];
//     for (int y = 0; y < resized.height; y++) {
//       for (int x = 0; x < resized.width; x++) {
//         int pixel = resized.getPixel(x, y);
//         // The image package returns pixel values in ARGB format.
//         double r = img.getRed(pixel).toDouble();
//         double g = img.getGreen(pixel).toDouble();
//         double b = img.getBlue(pixel).toDouble();
//         // Normalize assuming input range [0,255] -> [-1, 1]
//         imageData.add((r - 127.5) / 127.5);
//         imageData.add((g - 127.5) / 127.5);
//         imageData.add((b - 127.5) / 127.5);
//       }
//     }
//     return imageData;
//   }

//   /// Run inference and return the embedding vector.
//   Future<List<double>> runInference(String imagePath) async {
//     // Ensure the model is loaded.
//     await loadModel();
//     List<double> input = processImage(imagePath);
//     // Create input tensor of shape [1, height, width, 3]
//     var inputTensor = [input];
//     // Prepare output buffer.
//     List output = List.filled(outputShape.reduce((a, b) => a * b), 0.0);
//     var outputTensor = [output];
//     interpreter.run(inputTensor, outputTensor);
//     // Flatten and return the output as List<double>
//     return List<double>.from(outputTensor[0]);
//   }
// }
// import 'dart:io';

// import 'package:image/image.dart' as img;
// import 'package:tflite_flutter/tflite_flutter.dart';

// class FaceEmbeddingModel {
//   late Interpreter interpreter;
//   late List<int> inputShape;
//   late List<int> outputShape;
//   late TensorType inputType;
//   late TensorType outputType;
//   late InterpreterOptions interpreterOptions;

//   FaceEmbeddingModel();

//   Future<void> loadModel() async {
//     interpreterOptions = InterpreterOptions();
//     // You can add options here, e.g., number of threads.
//     interpreter = await Interpreter.fromAsset('assets/mobile_face_net.tflite',
//         options: interpreterOptions);
//     // interpreter = await Interpreter.fromAsset('assets/models/face_embedding.tflite', options: interpreterOptions);

//     inputShape = interpreter.getInputTensor(0).shape;
//     outputShape = interpreter.getOutputTensor(0).shape;
//     inputType = interpreter.getInputTensor(0).type;
//     outputType = interpreter.getOutputTensor(0).type;
//   }

//   /// Preprocess the image:
//   /// - Reads the image from [imagePath]
//   /// - Decodes and resizes to the expected input dimensions.
//   /// - Normalizes pixel values (here, we assume values between -1 and 1).
//   List<double> processImage(String imagePath) {
//     final bytes = File(imagePath).readAsBytesSync();
//     final image = img.decodeImage(bytes);
//     if (image == null) {
//       throw Exception("Failed to decode image");
//     }
//     // Assume model expects input size as given by inputShape [1, height, width, 3]
//     int targetWidth = inputShape[2];
//     int targetHeight = inputShape[1];
//     img.Image resized =
//         img.copyResize(image, width: targetWidth, height: targetHeight);
//     // Convert to float list normalized between -1 and 1.
//     List<double> imageData = [];
//     for (int y = 0; y < resized.height; y++) {
//       for (int x = 0; x < resized.width; x++) {
//         int pixel = resized.getPixel(x, y);
//         // The image package returns pixel values in ARGB format.
//         double r = img.getRed(pixel).toDouble();
//         double g = img.getGreen(pixel).toDouble();
//         double b = img.getBlue(pixel).toDouble();
//         // Normalize assuming input range [0,255] -> [-1, 1]
//         imageData.add((r - 127.5) / 127.5);
//         imageData.add((g - 127.5) / 127.5);
//         imageData.add((b - 127.5) / 127.5);
//       }
//     }
//     return imageData;
//   }

//   /// Run inference and return the embedding vector.
//   Future<List<double>> runInference(String imagePath) async {
//     // Ensure the model is loaded.
//     await loadModel();
//     List<double> input = processImage(imagePath);
//     // Create input tensor of shape [1, height, width, 3]
//     var inputTensor = [input];
//     // Prepare output buffer.
//     List output = List.filled(outputShape.reduce((a, b) => a * b), 0.0);
//     var outputTensor = [output];
//     interpreter.run(inputTensor, outputTensor);
//     // Flatten and return the output as List<double>
//     return List<double>.from(outputTensor[0]);
//   }
// }

// import 'dart:io';

// import 'package:image/image.dart' as img;
// import 'package:tflite_flutter/tflite_flutter.dart';

// class FaceEmbeddingModel {
//   late Interpreter interpreter;
//   late List<int> inputShape;
//   late List<int> outputShape;
//   late TensorType inputType; // UPDATED
//   late TensorType outputType; // UPDATED
//   late InterpreterOptions interpreterOptions;

//   FaceEmbeddingModel();

//   Future<void> loadModel() async {
//     interpreterOptions = InterpreterOptions();
//     interpreter = await Interpreter.fromAsset('assets/mobile_face_net.tflite',
//         options: interpreterOptions);
//     inputShape = interpreter.getInputTensor(0).shape;
//     outputShape = interpreter.getOutputTensor(0).shape;
//     inputType = interpreter.getInputTensor(0).type; // Now returns TensorType
//     outputType = interpreter.getOutputTensor(0).type;
//   }

//   List<double> processImage(
//       String imagePath, int targetWidth, int targetHeight) {
//     final bytes = File(imagePath).readAsBytesSync();
//     final image = img.decodeImage(bytes);
//     if (image == null) {
//       throw Exception("Failed to decode image");
//     }
//     img.Image resized =
//         img.copyResize(image, width: targetWidth, height: targetHeight);
//     List<double> imageData = [];
//     for (int y = 0; y < resized.height; y++) {
//       for (int x = 0; x < resized.width; x++) {
//         int pixel = resized.getPixel(x, y);
//         double r = img.getRed(pixel).toDouble();
//         double g = img.getGreen(pixel).toDouble();
//         double b = img.getBlue(pixel).toDouble();
//         imageData.add((r - 127.5) / 127.5);
//         imageData.add((g - 127.5) / 127.5);
//         imageData.add((b - 127.5) / 127.5);
//       }
//     }
//     return imageData;
//   }

//   List<List<List<List<double>>>> buildInputTensor(
//       List<double> flatImageData, int targetWidth, int targetHeight) {
//     return List.generate(
//       1,
//       (_) => List.generate(
//         targetHeight,
//         (y) => List.generate(
//           targetWidth,
//           (x) {
//             int index = (y * targetWidth + x) * 3;
//             return flatImageData.sublist(index, index + 3);
//           },
//         ),
//       ),
//     );
//   }

//   Future<List<double>> runInference(String imagePath) async {
//     await loadModel();
//     // Override dimensions: model expects 8 x 16 x 3 = 384 elements.
//     int targetHeight = 8;  // Hardcoded based on your model requirements
//     int targetWidth = 16;  // Hardcoded based on your model requirements

//     // Process image and build flat input.
//     List<double> flatInput = processImage(imagePath, targetWidth, targetHeight);
//     var inputTensor = buildInputTensor(flatInput, targetWidth, targetHeight);
//     List output = List.filled(outputShape.reduce((a, b) => a * b), 0.0);
//     var outputTensor = [output];
//     interpreter.run(inputTensor, outputTensor);
//     return List<double>.from(outputTensor[0]);
//   }

// }

// import 'dart:io';

// import 'package:image/image.dart' as img;
// import 'package:tflite_flutter/tflite_flutter.dart';

// class FaceEmbeddingModel {
//   late Interpreter interpreter;
//   late List<int> inputShape;
//   late List<int> outputShape;
//   late TensorType inputType;
//   late TensorType outputType;
//   late InterpreterOptions interpreterOptions;

//   FaceEmbeddingModel();

//   Future<void> loadModel() async {
//     interpreterOptions = InterpreterOptions();
//     // **CHANGED:** Load the model from assets (make sure asset is declared in pubspec.yaml)
//     interpreter = await Interpreter.fromAsset('assets/mobile_face_net.tflite',
//         options: interpreterOptions);
//     inputShape = interpreter.getInputTensor(0).shape;
//     outputShape = interpreter.getOutputTensor(0).shape;
//     inputType = interpreter.getInputTensor(0).type;
//     outputType = interpreter.getOutputTensor(0).type;
//   }

//   /// Preprocess the image:
//   /// - Reads the image from [imagePath]
//   /// - Decodes and resizes to the expected input dimensions.
//   /// - Normalizes pixel values (assumed between -1 and 1).
//   List<double> processImage(String imagePath) {
//     final bytes = File(imagePath).readAsBytesSync();
//     final image = img.decodeImage(bytes);
//     if (image == null) {
//       throw Exception("Failed to decode image");
//     }
//     // Assume model expects input size as given by inputShape [1, height, width, 3]
//     int targetWidth = inputShape[2]; // e.g., 112 or 100 depending on your model
//     int targetHeight = inputShape[1];
//     img.Image resized =
//         img.copyResize(image, width: targetWidth, height: targetHeight);
//     // Convert image to a flat list of normalized pixel values.
//     List<double> imageData = [];
//     for (int y = 0; y < resized.height; y++) {
//       for (int x = 0; x < resized.width; x++) {
//         int pixel = resized.getPixel(x, y);
//         double r = img.getRed(pixel).toDouble();
//         double g = img.getGreen(pixel).toDouble();
//         double b = img.getBlue(pixel).toDouble();
//         // Normalize: map [0,255] to [-1, 1]
//         imageData.add((r - 127.5) / 127.5);
//         imageData.add((g - 127.5) / 127.5);
//         imageData.add((b - 127.5) / 127.5);
//       }
//     }
//     return imageData;
//   }

//   Future<List<double>> runInference(String imagePath) async {
//     await loadModel();
//     List<double> input = processImage(imagePath);

//     // Get model expected input dimensions: [batch, height, width, channels]
//     int batchSize = inputShape[0]; // should be 1
//     int height = inputShape[1];
//     int width = inputShape[2];
//     int channels = inputShape[3];

//     // Reshape the flat input list to a 4D tensor [1, height, width, channels].
//     List<List<List<List<double>>>> inputTensor = List.generate(
//         batchSize,
//         (_) => List.generate(
//             height,
//             (i) => List.generate(width, (j) {
//                   int start = (i * width + j) * channels;
//                   return input.sublist(start, start + channels);
//                 }, growable: false),
//             growable: false),
//         growable: false);

//     // **CHANGED:** Create output tensor with shape exactly as required by the model.
//     // For example, if outputShape = [2, 192]:
//     List<List<double>> outputTensor =
//         List.generate(outputShape[0], (_) => List.filled(outputShape[1], 0.0));

//     // Run inference.
//     interpreter.run(inputTensor, outputTensor);

//     // Flatten the output tensor into a single list.
//     return outputTensor.expand((element) => element).toList();
//   }
// }

import 'dart:io';
import 'dart:math';

import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';

class FaceEmbeddingModel {
  late Interpreter interpreter;
  late List<int> inputShape;
  late List<int> outputShape;
  late TensorType inputType;
  late TensorType outputType;
  late InterpreterOptions interpreterOptions;

  FaceEmbeddingModel();

  Future<void> loadModel() async {
    interpreterOptions = InterpreterOptions();
    // Ensure your model file is in assets and declared in pubspec.yaml
    interpreter = await Interpreter.fromAsset('assets/mobile_face_net.tflite',
        options: interpreterOptions);
    inputShape = interpreter.getInputTensor(0).shape;
    outputShape = interpreter.getOutputTensor(0).shape;
    inputType = interpreter.getInputTensor(0).type;
    outputType = interpreter.getOutputTensor(0).type;
  }

  /// Aligns the face using Google ML Kit.
  /// Detects faces and returns a cropped image containing the first detected face.
  Future<img.Image> alignFace(String imagePath) async {
    final inputImage = InputImage.fromFilePath(imagePath);
    final faceDetector = GoogleMlKit.vision.faceDetector();
    final List<Face> faces = await faceDetector.processImage(inputImage);
    faceDetector.close();
    if (faces.isEmpty) {
      throw Exception("No face detected");
    }
    final face = faces.first;
    final File file = File(imagePath);
    final bytes = await file.readAsBytes();
    final originalImage = img.decodeImage(bytes);
    if (originalImage == null) throw Exception("Failed to decode image");
    // Get the face bounding box and clamp it within image bounds.
    int x = face.boundingBox.left.toInt().clamp(0, originalImage.width - 1);
    int y = face.boundingBox.top.toInt().clamp(0, originalImage.height - 1);
    int w = face.boundingBox.width.toInt().clamp(0, originalImage.width - x);
    int h = face.boundingBox.height.toInt().clamp(0, originalImage.height - y);
    // Crop to the detected face.
    return img.copyCrop(originalImage, x, y, w, h);
  }

  /// Preprocess the image:
  /// - Aligns the face.
  /// - Resizes to expected dimensions.
  /// - Normalizes pixel values to [-1, 1].
  Future<List<double>> processImage(String imagePath) async {
    // **CHANGED:** Align face before processing.
    img.Image alignedImage = await alignFace(imagePath);
    // Resize aligned image to target size.
    int targetWidth = inputShape[2]; // e.g., 112
    int targetHeight = inputShape[1];
    img.Image resized =
        img.copyResize(alignedImage, width: targetWidth, height: targetHeight);
    List<double> imageData = [];
    for (int y = 0; y < resized.height; y++) {
      for (int x = 0; x < resized.width; x++) {
        int pixel = resized.getPixel(x, y);
        double r = img.getRed(pixel).toDouble();
        double g = img.getGreen(pixel).toDouble();
        double b = img.getBlue(pixel).toDouble();
        // Normalize pixel values from [0,255] to [-1, 1]
        imageData.add((r - 127.5) / 127.5);
        imageData.add((g - 127.5) / 127.5);
        imageData.add((b - 127.5) / 127.5);
      }
    }
    return imageData;
  }

  /// Run inference:
  /// - Preprocesses (and aligns) the image.
  /// - Reshapes the input to a 4D tensor.
  /// - Runs inference and returns the embedding.
  /// - Applies L2 normalization to the embedding.
  Future<List<double>> runInference(String imagePath) async {
    await loadModel();
    List<double> input = await processImage(imagePath);

    // Get expected input dimensions: [batch, height, width, channels]
    int batchSize = inputShape[0]; // Should be 1
    int height = inputShape[1];
    int width = inputShape[2];
    int channels = inputShape[3];

    // **CHANGED:** Reshape the flat input list into a 4D tensor [1, height, width, channels]
    List<List<List<List<double>>>> inputTensor = List.generate(
      batchSize,
      (_) => List.generate(
        height,
        (i) => List.generate(
          width,
          (j) {
            int start = (i * width + j) * channels;
            return input.sublist(start, start + channels);
          },
          growable: false,
        ),
        growable: false,
      ),
      growable: false,
    );

    // Create output tensor with the exact shape from the model.
    List<List<double>> outputTensor = List.generate(
      outputShape[0],
      (_) => List.filled(outputShape[1], 0.0),
    );

    interpreter.run(inputTensor, outputTensor);

    // Flatten the output tensor into a single list.
    List<double> embedding = outputTensor.expand((element) => element).toList();

    // **CHANGED:** Apply L2 normalization to the embedding.
    double norm = sqrt(embedding.fold(0, (prev, e) => prev + e * e));
    if (norm > 0) {
      embedding = embedding.map((e) => e / norm).toList();
    }
    return embedding;
  }
}
