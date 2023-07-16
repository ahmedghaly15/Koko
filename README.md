# Koko-App

This project is a Flutter mobile application for classifying chicken diseases using TensorFlow Lite. The app uses a deep learning model trained on a dataset of chicken images to predict the presence of various diseases in chickens. TensorFlow Lite is utilized for on-device machine learning, allowing real-time and efficient inference directly on the user's mobile device.

## Contents

- [Preview](#preview)
- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [TensorFlow Lite Model](#tensorflow-lite-model)
- [Contributing](#contributing)
- [License](#license)
- [Acknowledgments](#acknowledgments)
- [Contact](#contact)

## Preview

https://github.com/ahmedghaly15/Koko-App/assets/108659381/441d35ea-e3f5-4504-8ef8-d11366e8fa1e

## Features

- **Real-time Classification**: The app allows users to capture or select an image of a chicken and quickly obtain predictions about potential diseases without the need for an internet connection.

- **Disease Prediction**: The trained TensorFlow Lite model can identify common chicken diseases, enabling early detection and timely intervention.

- **User-friendly Interface**: The app features an intuitive and user-friendly interface, making it easy for poultry farmers and enthusiasts to interact with the application.

## Installation

To run this application on your local machine or a mobile device, follow these steps:

### Prerequisites

- Flutter SDK (>= 2.5.0) installed on your machine.
- Android Studio or Xcode installed for Android and iOS development, respectively.
- Android or iOS device/emulator for testing the app.

### Instructions

1. Clone this repository to your local machine using the following command:

   ```
   git clone https://github.com/your-username/your-repo-name.git
   ```

2. Change into the project directory:

   ```
   cd your-repo-name
   ```

3. Get the Flutter dependencies by running:

   ```
   flutter pub get
   ```

4. Connect your Android or iOS device to your machine and ensure it is detected by running:

   ```
   flutter devices
   ```

5. Launch the app on your device by running:

   ```
   flutter run
   ```

   Alternatively, you can use the Android Studio or Xcode IDE to run the application on an emulator.

## Usage

1. Open the Koko-App on your device.

2. Capture a photo of a chicken or select an image from your gallery.

3. Wait for the TensorFlow Lite model to process the image and provide predictions.

4. View the results, which will display the most likely disease(s) present in the chicken.

5. Use this information to take appropriate actions for the well-being of your poultry.

## TensorFlow Lite Model

The TensorFlow Lite model used in this app is trained on a labeled dataset of chicken images, containing various healthy and diseased samples. The model is optimized for mobile deployment, ensuring fast and efficient inference on-device.

The source code for training the TensorFlow model can be found in the `training/` directory of this repository. The model is then converted to TensorFlow Lite format for use in the Flutter app.

## Contributing

Contributions to this project are welcome and encouraged. If you want to contribute to the project, please follow these steps:

1. Fork this repository.

2. Create a new branch with a descriptive name for your feature or bug fix.

3. Make your changes and test thoroughly.

4. Commit your changes and push them to your forked repository.

5. Submit a pull request to this repository, explaining the changes you made.

Please ensure that you adhere to the project's coding standards and best practices while contributing.

## License

This project is licensed under the [MIT License](LICENSE).

## Acknowledgments

We would like to express our gratitude to the contributors of the TensorFlow and Flutter projects, as well as the creators of the chicken disease dataset used for training the model.

## Contact

If you have any questions, suggestions, or issues, feel free to contact the project maintainers:

- [Ahmed Ghaly's Email](ahmedghaly0767@gmail.com)
- [AbdelKareem's Email](kareem01095134688@gmail.com)

Thank you for using the Chicken Disease Classification App! Happy classifying and take good care of your chickens! 🐔🐓
