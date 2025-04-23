# services/cloudinary.py
import cloudinary
import cloudinary.uploader
import cloudinary.api

cloudinary.config( 
  cloud_name = 'ddudykruo', 
  api_key = '331346271764311', 
  api_secret = 'n_8A5GzgoYV3VjJkKBO__0fcPcY'
)

def upload_image(image_file):
    upload_result = cloudinary.uploader.upload(image_file)
    return upload_result['secure_url']  # Returning the URL of the uploaded image
