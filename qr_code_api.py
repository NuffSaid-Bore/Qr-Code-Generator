from flask import Flask, request, jsonify, send_from_directory
import qrcode
import os

app = Flask(__name__)

@app.route('/generate_qr', methods=['POST'])
def generate_qr():
    data = request.json.get('data')
    filename = request.json.get('filename', 'qr_code.png')
    qr = qrcode.QRCode(box_size=10, border=4)
    qr.add_data(data)
    image = qr.make_image(fill_color='black', back_color='white')

    image_path = os.path.join('generated_qr_codes', filename)
    image.save(image_path)

    return jsonify({'message': f'QR code saved as {image_path}'})


@app.route('/generated_qr_codes/<path:filename>')
def serve_qr_code(filename):
    return send_from_directory('generated_qr_codes', filename)

@app.route('/list_qr_codes', methods=['GET'])
def list_qr_codes():
    qr_codes_dir = 'generated_qr_codes'
    files = os.listdir(qr_codes_dir)
    # Filter for image files if necessary
    image_files = [file for file in files if file.endswith(('.png', '.jpg', '.jpeg'))]
    return jsonify(image_files)

if __name__ == '__main__':
    if not os.path.exists('generated_qr_codes'):
        os.makedirs('generated_qr_codes')
    app.run(debug=True)
