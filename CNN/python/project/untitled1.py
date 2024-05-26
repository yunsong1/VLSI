# -*- coding: utf-8 -*-
"""
Created on Wed Dec 27 09:32:54 2023

@author: 付
"""

import torch
import scipy.io as sio

tensor = torch.randn(2,3,4,5)
# tensor = torch.randn(2,3,4)
print(tensor)

sio.savemat('tensor.mat',{'tensor':tensor.numpy()})

mat_file=sio.loadmat('tensor.mat')
#print(mat_file)
print(type(mat_file['tensor']))
tensor=torch.from_numpy(mat_file['tensor'])
print(tensor)

import torch
import scipy.io as sio

# 假设您已经加载了模型并获取了state_dict
model = YourModel()
weights = model.state_dict()

# 逐层保存权重为MATLAB文件
for layer_name, weight_tensor in weights.items():
    file_name = layer_name + '.mat'  # 使用层名称作为文件名
    weight_np = weight_tensor.numpy()  # 转换为NumPy数组
    sio.savemat(file_name, {'weights': weight_np})

    print(f'Saved weights of layer {layer_name} to {file_name}')