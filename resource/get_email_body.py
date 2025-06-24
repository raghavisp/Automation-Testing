# ocr_keywords.py
import pytesseract
from PIL import Image
import sys

pytesseract.pytesseract.tesseract_cmd = r"C:\Program Files\Tesseract-OCR\tesseract.exe"

if len(sys.argv) < 2:
    print("Usage: python ocr_keywords.py <image_path>")
    sys.exit(1)

image_path = sys.argv[1]
image = Image.open(image_path)
text = pytesseract.image_to_string(image)
print(text.strip())

