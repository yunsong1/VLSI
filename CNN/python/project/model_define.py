# -*- coding: utf-8 -*-
"""
Created on Tue Dec 26 08:49:31 2023

@author: 付
"""

# 数据维度 = (输入维度+2Padding-kernel_size)/Stride步长 + 1
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
        self.relu = nn.ReLU()
        self.maxpool2 = nn.MaxPool2d(2, 2)
        self.fc1 = nn.Linear(16 * 5 * 5, 120)
        self.fc2 = nn.Linear(120, 84)
        self.fc3 = nn.Linear(84, 10)

    def forward(self, x):
        x = self.conv1(x)
        x = self.relu(x)
        x = self.maxpool1(x)
        x = self.conv2(x)
        x = self.relu(x)
        x = self.maxpool2(x)
        x = x.view(-1, 16 * 5 * 5)
        x = F.relu(self.fc1(x))
        x = F.relu(self.fc2(x))
        x = self.fc3(x)
        output = F.log_softmax(x, dim=1)
        return output


# net = LeNet()  # 实例化
# from torchinfo import summary
# summary_str = summary(net, (20, 1, 32, 32), verbose=0)
# print(summary_str)

model=LeNet();
# 遍历网络的层参数
for name, param in model.named_parameters():
    print(name, param.shape)
    print(name, param.data)
    






























