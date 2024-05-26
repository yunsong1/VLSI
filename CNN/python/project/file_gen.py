# -*- coding: utf-8 -*-
"""
Created on Wed Dec 27 08:52:29 2023

@author: 付
"""
import torch
import torch.nn as nn
import torch.nn.functional as F
import torch.optim as optim
import os
import numpy as np
import pandas as pd
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
    
model = torch.load('./models/model-mnist.pth')  # 加载模型

# 打印模型权重
for name, param in model.named_parameters():
    if param.requires_grad:
        print(name, param.data)  
for name in model.state_dict():
  print(name)      
net = LeNet()  # 实例化
from torchinfo import summary
summary_str = summary(net, (20, 1, 32, 32), verbose=0)
print(summary_str)
# 创建一个名为TXT的文件夹
# 将模型的state_dict保存到不同的文件
os.makedirs('PTH', exist_ok=True)
for name, param in model.named_parameters():
    filename = f'PTH/{name}.pth'
    torch.save(param, filename)  
# 创建一个名为TXT的文件夹
# 生成不同层的参数的txt文件
os.makedirs('TXT', exist_ok=True)
for name, param in model.named_parameters():
    filename = f'TXT/{name}.txt'
    with open(filename, 'w') as file:
        # data = param.data
        # file.write(f'{data}\n')
        data = param.detach().cpu().numpy()  # 使用detach()方法来获取不需要梯度的张量，并转换为NumPy数组
        file.write(','.join(map(str, data.flatten())))     