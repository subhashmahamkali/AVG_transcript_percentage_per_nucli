#!/usr/bin/env python
# coding: utf-8

# In[937]:


import cv2
import numpy as np

def find_and_highlight_pixel(image_path, pixel_intensity):
    # Load the image with the cv2.IMREAD_UNCHANGED flag
    image = cv2.imread(image_path, cv2.IMREAD_UNCHANGED)

    # Find the locations where the intensity matches
    match_locations = np.where(image == pixel_intensity)

    # Create a copy of the original image
    marked_image = cv2.cvtColor(image, cv2.COLOR_GRAY2BGR)

    # Highlight the matching pixel locations on the image
    marked_image[match_locations] = [0, 0, 255]  # Mark in red color

    # Get the image dimensions
    height, width, _ = marked_image.shape

    # Create a resizable window matching the image dimensions
    cv2.namedWindow("Highlighted Image", cv2.WINDOW_NORMAL)
    cv2.resizeWindow("Highlighted Image", width, height)

    # Display the marked image
    cv2.imshow("Highlighted Image", marked_image)
    cv2.waitKey(0)
    cv2.destroyAllWindows()

# Example usage
image_path = "B2.tif"
pixel_intensity =1767
find_and_highlight_pixel(image_path, pixel_intensity)

