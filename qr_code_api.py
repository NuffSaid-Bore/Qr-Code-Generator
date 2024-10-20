from flask import Flask, request, jsonify
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



if __name__ == '__main__':
    if not os.path.exists('generated_qr_codes'):
        os.makedirs('generated_qr_codes')
    app.run(debug=True)
