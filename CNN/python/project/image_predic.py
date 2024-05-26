# -*- coding: utf-8 -*-
"""
Created on Mon Dec 25 21:19:27 2023

@author: fu
"""

import torch
import torch.nn as nn
import torch.nn.functional as F
import torch.optim as optim
from torchvision import datasets, transforms
import time
from matplotlib import pyplot as plt
import csv
import scipy.io as sio

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
        data_in = x
        x_conv1 = self.conv1(data_in)
        x_conv1_relu = self.relu(x_conv1)
        x_conv1_relu_max = self.maxpool1(x_conv1_relu)
        x_conv2 = self.conv2(x_conv1_relu_max)
        x_conv2_relu = self.relu(x_conv2)
        x_conv2_relu_max = self.maxpool2(x_conv2_relu)
        x_conv2_relu_max = x_conv2_relu_max.view(-1, 16 * 5 * 5)
        x_fc1_relu = F.relu(self.fc1(x_conv2_relu_max))
        x_fc2_relu = F.relu(self.fc2(x_fc1_relu))
        x_fc3 = self.fc3(x_fc2_relu)
        # output = F.log_softmax(x, dim=1)
        output = x_fc3
        return output,data_in,x_conv1,x_conv1_relu,x_conv1_relu_max\
                    ,x_conv2,x_conv2_relu,x_conv2_relu_max\
                    ,x_fc1_relu,x_fc2_relu,x_fc3

import cv2

if __name__ == '__main__':
    device = torch.device('cuda' if torch.cuda.is_available() else 'cpu')
    model = torch.load('./models/model-mnist.pth')  # 加载模型
    model = model.to(device)
    model.eval()  # 把模型转为test模式

    # 读取要预测的图片
    #img = cv2.imread("./test/1/5.png")
    img = cv2.imread("./test/4/33.png")
    #img = cv2.imread("./test/2/1.png")
    img = cv2.resize(img, dsize=(32, 32), interpolation=cv2.INTER_LANCZOS4)
    imgae = img;

    # 导入图片，图片扩展后为[1，1，32，32]
    trans = transforms.Compose(
        [
            transforms.ToTensor(),
            transforms.Normalize((0.1307,), (0.3081,))
        ])
    img = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)  # 图片转为灰度图，因为mnist数据集都是灰度图
    
    print(img[15:25,15:25])
    mat_file = 'image_check.mat'
    sio.savemat(mat_file, {'img': img})

    img = trans(img)
    img = img.to(device)
    img = img.unsqueeze(0)  # 图片扩展多一维,因为输入到保存的模型中是4维的[batch_size,通道,长，宽]，而普通图片只有三维，[通道,长，宽]
   
    # 输出
    output,data_in,x_conv1,x_conv1_relu,x_conv1_relu_max\
        ,x_conv2,x_conv2_relu,x_conv2_relu_max\
        ,x_fc1_relu,x_fc2_relu,x_fc3 = model(img)
    
    ###################   将每层的输出保存为 mat 文件   ##################
    sio.savemat('data_in.mat', {'data_in': data_in.detach().cpu().numpy()})
    sio.savemat('x_conv1.mat', {'x_conv1': x_conv1.detach().cpu().numpy()})
    sio.savemat('x_conv1_relu.mat', {'x_conv1_relu': x_conv1_relu.detach().cpu().numpy()})
    sio.savemat('x_conv1_relu_max.mat', {'x_conv1_relu_max': x_conv1_relu_max.detach().cpu().numpy()})
    sio.savemat('x_conv2.mat', {'x_conv2': x_conv2.detach().cpu().numpy()})
    sio.savemat('x_conv2_relu.mat', {'x_conv2_relu': x_conv2_relu.detach().cpu().numpy()})
    sio.savemat('x_conv2_relu_max.mat', {'x_conv2_relu_max': x_conv2_relu_max.detach().cpu().numpy()})
    sio.savemat('x_fc1_relu.mat', {'x_fc1_relu': x_fc1_relu.detach().cpu().numpy()})
    sio.savemat('x_fc2_relu.mat', {'x_fc2_relu': x_fc2_relu.detach().cpu().numpy()})
    sio.savemat('x_fc3.mat', {'x_fc3': x_fc3.detach().cpu().numpy()})
    
    ###################  图片预测   ############################
    # output = model(img)
    print(output)
    prob = F.softmax(output, dim=1)  # prob是10个分类的概率
    plt.imshow(imgae, cmap="gray")  # 显示图片
    plt.axis('off')  # 不显示坐标轴
    plt.show()    
    print("概率：", prob)
    value, predicted = torch.max(output.data, 1)
    predict = output.argmax(dim=1)
    print("预测类别：", predict.item())
  