# -*- coding: utf-8 -*-
"""
Created on Wed Dec 27 00:00:05 2023

@author: 付
"""

import os
import cv2
import torch
import torch.nn as nn
import torch.nn.functional as F
import torch.optim as optim
from torchvision import datasets, transforms
import time
from matplotlib import pyplot as plt
# 图片文件夹路径
image_folder = "E:\\spyder\\project\\project\\image_check"

# 遍历图片文件夹中的所有图片
for filename in os.listdir(image_folder):
    if filename.endswith('.jpg') or filename.endswith('.png'):
        # 读取图像
        image = cv2.imread(image_folder+"\\"+filename)
        print(image_folder+"\\"+filename)
        plt.imshow(image, cmap="gray")  # 显示图片
        plt.axis('off')  # 不显示坐标轴
        plt.show()
        # 显示图像
