# QR Code Generator

## Overview

This project consists of a Python backend and a Flutter frontend that allows users to generate QR codes easily. The server-side application uses the `qrcode` library to create and store QR codes, which are then served to the Flutter app for display and interaction.

## Features

- Generate QR codes from text or links.
- Optional filename for the generated QR codes (default: `qr_code.png`).
- Display a list of recently generated QR codes.
- All QR codes are stored in the `generated_qr_codes` folder.
- Upcoming features include user authentication and sharing QR codes with other applications.

## Technologies Used

- **Backend**: Python
  - **Library**: `qrcode` for generating QR codes.
- **Frontend**: Flutter

## Getting Started

### Prerequisites

- Python 3.x installed on your machine.
- Flutter SDK installed.
- An IDE of your choice (e.g., VS Code, PyCharm).

### Running the Server

1. Clone this repository:
   ```bash
   git clone <repository-url>
   cd <repository-name>
2. Open the project in your favorite IDE and navigate to the qr_code_api.py file.

3. In your terminal, run the following command to start the server:
    python qr_code_api.py
The server will run locally on your machine, accessible via localhost or your IP address.

### Running the Flutter App
1. Open the qr_code_generator folder, which contains the Flutter frontend project.

2. In your terminal, navigate to the Flutter project directory and run:
    flutter pub get
3. Locate main.dart and run the project in your preferred emulator, web browser, or desktop.

### Using the Application
    Once the application is running, you can:
    -Enter the text or link you want to generate a QR code for.
    -Optionally provide a filename for the QR code.
    -View a list of recently generated QR codes.

### Requirements
1. To install the necessary Python libraries, you can use the requirements.txt file included in the project. This file contains the following dependencies:

-Flask
-qrcode
-Pillow
-To install these dependencies, run the following command in your terminal:
    pip install -r requirements.txt
### Future Development
-Implement user authentication for login and registration, ensuring that each QR code belongs to the logged-in user.
-Enable sharing of QR codes with other applications.
### Contributing
Feel free to submit issues and pull requests for any enhancements or bug fixes! Your contributions are welcome.