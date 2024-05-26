# -*- coding: utf-8 -*-
"""
Created on Mon Dec 25 21:19:27 2023

@author: fu
"""
import torch
import torch.nn as nn
import torch.nn.functional as F
from torchvision import transforms
import time
from matplotlib import pyplot as plt
import cv2
import os

    
class LeNet(nn.Module):
    def __init__(self):
        super(LeNet, self).__init__()
        self.conv1 = nn.Conv2d(1, 6, 5)
        self.relu = nn.ReLU()
        self.maxpool1 = nn.MaxPool2d(2, 2)
        self.conv2 = nn.Conv2d(6, 16, 5)
        self.maxpool2 = nn.MaxPool2d(2, 2)
        self.fc1 = nn.Linear(16 * 5 * 5, 120)
        self.fc2 = nn.Linear(120, 84)
        self.fc3 = nn.Linear(84, 10)

    def forward(self, x):
        x = self.conv1(x)
        x = self.relu(x)
        x = self.maxpool1(x)
        x = self.conv2(x)
        x = self.maxpool2(x)
        x = x.view(-1, 16 * 5 * 5)
        x = F.relu(self.fc1(x))
        x = F.relu(self.fc2(x))
        x = self.fc3(x)
        output = F.log_softmax(x, dim=1)
        return output
  
if __name__ == '__main__':
    
    image_folder = "E:\\spyder\\python\\project\\image_check"
    # 遍历图片文件夹中的所有图片
    for filename in os.listdir(image_folder):
        if filename.endswith('.jpg') or filename.endswith('.png'):
            # 显示图像
            img = cv2.imread(image_folder+"\\"+filename)
            device = torch.device('cuda' if torch.cuda.is_available() else 'cpu')
            model = torch.load('./models/model-mnist.pth')  # 加载模型
            model = model.to(device)
            model.eval()  # 把模型转为test模式
        
            # 读取要预测的图片
            img = cv2.resize(img, dsize=(32, 32), interpolation=cv2.INTER_LANCZOS4)
            image =img;
            # 导入图片，图片扩展后为[1，1，32，32]
            trans = transforms.Compose(
                [
                    transforms.ToTensor(),
                    transforms.Normalize((0.1307,), (0.3081,))
                ])
            img = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)  # 图片转为灰度图，因为mnist数据集都是灰度图
            img = trans(img)
            img = img.to(device)
            img = img.unsqueeze(0)  # 图片扩展多一维,因为输入到保存的模型中是4维的[batch_size,通道,长，宽]，而普通图片只有三维，[通道,长，宽]
        
            # 预测
            output = model(img)
            prob = F.softmax(output, dim=1)  # prob是10个分类的概率
            plt.imshow(image, cmap="gray")  # 显示图片
            plt.axis('off')  # 不显示坐标轴
            plt.show()            
            print("概率：", prob)
            value, predicted = torch.max(output.data, 1)
            predict = output.argmax(dim=1)
            print("预测类别：", predict.item())
            
            time.sleep(2)  # 暂停2秒
  