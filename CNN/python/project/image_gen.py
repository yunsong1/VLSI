import torch
from torchvision import datasets, transforms
import os

# 定义转换函数
def save_image(image, label, save_dir, prefix):
    image_path = os.path.join(save_dir, f'{prefix}_{label}.png')
    image.save(image_path)

# 定义保存图像的目录
save_dir = './MNIST_images'
if not os.path.exists(save_dir):
    os.makedirs(save_dir)

# 下载MNIST数据集并转换为图像格式
transform = transforms.Compose([
    transforms.ToTensor(),
    transforms.Normalize((0.5,), (0.5,))
])

train_set = datasets.MNIST(root='./data', train=True, download=True, transform=transform)
test_set = datasets.MNIST(root='./data', train=False, download=True, transform=transform)

for i, (image, label) in enumerate(train_set):
    image = transforms.ToPILImage()(image)
    save_image(image, label, save_dir, 'train')

for i, (image, label) in enumerate(test_set):
    image = transforms.ToPILImage()(image)
    save_image(image, label, save_dir, 'test')