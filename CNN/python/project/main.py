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

pipline_train = transforms.Compose([
    # 随机旋转图片
    transforms.RandomHorizontalFlip(),
    # 将图片尺寸resize到32x32
    transforms.Resize((32, 32)),
    # 将图片转化为Tensor格式
    transforms.ToTensor(),
    # 正则化(当模型出现过拟合的情况时，用来降低模型的复杂度)
    transforms.Normalize((0.1307,), (0.3081,))
])
pipline_test = transforms.Compose([
    # 将图片尺寸resize到32x32
    transforms.Resize((32, 32)),
    transforms.ToTensor(),
    transforms.Normalize((0.1307,), (0.3081,))
])
# 下载数据集
train_set = datasets.MNIST(root="./data", train=True, download=True, transform=pipline_train)
test_set = datasets.MNIST(root="./data", train=False, download=True, transform=pipline_test)
# 加载数据集
trainloader = torch.utils.data.DataLoader(train_set, batch_size=64, shuffle=True)
testloader = torch.utils.data.DataLoader(test_set, batch_size=32, shuffle=False)

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
        output = F.log_softmax(x, dim=1)
        # output = x
        return output


# class LeNet(nn.Module):
#     def __init__(self):
#         super(LeNet, self).__init__()
#         self.conv1 = nn.Conv2d(1, 3, 5)
#         self.relu = nn.ReLU()
#         self.maxpool1 = nn.MaxPool2d(2, 2)
#         self.conv2 = nn.Conv2d(3, 6, 5)
#         self.relu = nn.ReLU()
#         self.maxpool2 = nn.MaxPool2d(2, 2)
#         self.fc1 = nn.Linear(6 * 5 * 5 ,32)
#         self.fc2 = nn.Linear(32, 16)
#         self.fc3 = nn.Linear(16, 10)

#     def forward(self, x):
#         x = self.conv1(x)
#         x = self.relu(x)
#         x = self.maxpool1(x)
#         x = self.conv2(x)
#         x = self.relu(x)
#         x = self.maxpool2(x)
#         x = x.view(-1, 6 * 5 * 5)
#         x = F.relu(self.fc1(x))
#         x = F.relu(self.fc2(x))
#         x = self.fc3(x)
#         output = F.log_softmax(x, dim=1)
#         # output = F.softmax(x, dim=1)
#         return output
    
# 创建模型，部署gpu
device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
model = LeNet().to(device)
# 定义优化器
optimizer = optim.Adam(model.parameters(), lr=0.001)


def train_runner(model, device, trainloader, optimizer, epoch):
    # 训练模型, 启用 BatchNormalization 和 Dropout, 将BatchNormalization和Dropout置为True
    model.train()
    total = 0
    correct = 0.0

    # enumerate迭代已加载的数据集,同时获取数据和数据下标
    for i, data in enumerate(trainloader, 0):
        inputs, labels = data
        # 把模型部署到device上
        inputs, labels = inputs.to(device), labels.to(device)
        # 初始化梯度
        optimizer.zero_grad()
        # 保存训练结果
        outputs = model(inputs)
        # 计算损失和
        # 多分类情况通常使用cross_entropy(交叉熵损失函数), 而对于二分类问题, 通常使用sigmod
        loss = F.cross_entropy(outputs, labels)
        # 获取最大概率的预测结果
        # dim=1表示返回每一行的最大值对应的列下标
        predict = outputs.argmax(dim=1)
        total += labels.size(0)
        correct += (predict == labels).sum().item()
        # 反向传播
        loss.backward()
        # 更新参数
        optimizer.step()
        if i % 1000 == 0:
            # loss.item()表示当前loss的数值
            print(
                "Train Epoch{} \t Loss: {:.6f}, accuracy: {:.6f}%".format(epoch, loss.item(), 100 * (correct / total)))
            Loss.append(loss.item())
            Accuracy.append(correct / total)
    return loss.item(), correct / total


def test_runner(model, device, testloader):
    # 模型验证, 必须要写, 否则只要有输入数据, 即使不训练, 它也会改变权值
    # 因为调用eval()将不启用 BatchNormalization 和 Dropout, BatchNormalization和Dropout置为False
    model.eval()
    # 统计模型正确率, 设置初始值
    correct = 0.0
    test_loss = 0.0
    total = 0
    # torch.no_grad将不会计算梯度, 也不会进行反向传播
    with torch.no_grad():
        for data, label in testloader:
            data, label = data.to(device), label.to(device)
            output = model(data)
            test_loss += F.cross_entropy(output, label).item()
            predict = output.argmax(dim=1)
            # 计算正确数量
            total += label.size(0)
            correct += (predict == label).sum().item()
        # 计算损失值
        print("test_avarage_loss: {:.6f}, accuracy: {:.6f}%".format(test_loss / total, 100 * (correct / total)))


epoch = 5

Loss = []
Accuracy = []
for epoch in range(1, epoch + 1):
    print("start_time", time.strftime('%Y-%m-%d %H:%M:%S', time.localtime(time.time())))
    loss, acc = train_runner(model, device, trainloader, optimizer, epoch)
    Loss.append(loss)
    Accuracy.append(acc)
    test_runner(model, device, testloader)
    print("end_time: ", time.strftime('%Y-%m-%d %H:%M:%S', time.localtime(time.time())), '\n')

print('Finished Training')
plt.subplot(2, 1, 1)
plt.plot(Loss)
plt.title('Loss')
plt.show()
plt.subplot(2, 1, 2)
plt.plot(Accuracy)
plt.title('Accuracy')
plt.show()

             ###################   保存模型   ##################
             
print(model)
torch.save(model, './models/model-mnist.pth')

             ###################   保存模型   ##################

import cv2

if __name__ == '__main__':
    device = torch.device('cuda' if torch.cuda.is_available() else 'cpu') 
    model = torch.load('./models/model-mnist.pth')  # 加载模型
    model = model.to(device)
    model.eval()  # 把模型转为test模式

    # 读取要预测的图片
    img = cv2.imread("./images/test_mnist2.jpg")
    img = cv2.resize(img, dsize=(32, 32), interpolation=cv2.INTER_NEAREST)
    plt.imshow(img, cmap="gray")  # 显示图片
    plt.axis('off')  # 不显示坐标轴
    plt.show()

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
    print("概率：", prob)
    value, predicted = torch.max(output.data, 1)
    predict = output.argmax(dim=1)
    print("预测类别：", predict.item())
    
    
# 保存模型权重
torch.save(model.state_dict(), 'lenet5_weights.pth')

# 打印模型权重
#for name, param in model.named_parameters():
#    if param.requires_grad:
 #       print(name, param.data)    