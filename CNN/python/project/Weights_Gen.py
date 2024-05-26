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
        x = self.relu(x)
        x = self.maxpool2(x)
        x = x.view(-1, 16 * 5 * 5)
        x = F.relu(self.fc1(x))
        x = F.relu(self.fc2(x))
        x = self.fc3(x)
        # output = F.log_softmax(x, dim=1)
        output = x
        return output
    
model = torch.load('./models/model-mnist.pth', map_location=torch.device('cpu'))  # 加载模型

# 提取权重数据
weights = model.state_dict()

# 获取权重字典的键列表
weight_keys = weights.keys()

# 遍历键列表并打印权重参数
for key in weight_keys:
    weight_param = weights[key]
    print(f"Key: {key}, Shape: {weight_param.shape}")
    # print(weight_param)
    # print(key)
   
# 选择要查看的特定权重键
selected_key = 'conv1.weight'
weight_param = weights[selected_key]
# 打印权重参数的内容
print(f"Key: {selected_key}")
print(f"Shape: {weight_param.shape}")
print(weight_param)
    

###################   权重保存为mat格式   ############################
# 将权重数据转换为 numpy 数组
weights_numpy = {key: value.numpy() for key, value in weights.items()}
# 定义要保存到 .mat 文件中的数据结构
data = {'weights': weights_numpy}
# 保存为 .mat 文件
sio.savemat('weights.mat', data)



























# # 加载PyTorch训练的.pth权重文件
# state_dict = torch.load('./models/model-mnist.pth')  # 替换为您的.pth文件名

# # 提取权重张量
# weights = {}
# for name, param in state_dict.named_parameters():
#     weights[name] = param.detach().cpu().numpy()

# # 将权重保存为MATLAB文件
# sio.savemat('model.mat', weights)


       
# # 创建一个名为CSV的文件夹
# # 生成不同层的参数的CSV文件
# os.makedirs('CSV', exist_ok=True)
# for name, param in model.named_parameters():
#     data = param.detach().cpu().numpy()  # 使用detach()方法来获取不需要梯度的张量，并转换为NumPy数组
#     flattened_data = data.flatten()  # 展平为一维数组
#     df = pd.DataFrame(flattened_data)
#     csv_filename = f'CSV/{name}.csv'
#     df.to_csv(csv_filename, index=False, header=False)  # 将数据保存为CSV格式


# weights = model.state_dict()
# # 创建MAT文件夹（如果不存在）
# save_folder = 'MAT'
# os.makedirs(save_folder, exist_ok=True)
# # 逐层保存权重为MATLAB文件
# for name, param in model.named_parameters():
#     file_name = os.path.join(save_folder, name + '.mat')  # 使用层名称作为文件名，并指定保存在MAT文件夹下
#     weight_np = param.detach().cpu().numpy()  # 转换为NumPy数组
#     sio.savemat(file_name, {'weights': weight_np})
#     print(f'Saved weights of layer {name} to {file_name}')


# pthfile = r'E:/spyder/project/project/models/model-mnist.pth'  #faster_rcnn_ckpt.pth








  