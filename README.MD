docker build --force-rm --tag wanghao_minst --file ubuntu.dockerfile .

docker run -itd --name ubuntu_minst -P 8888:8888 -v /dev:/dev -v /usr/src/:/usr/src -v /lib/modules/:/lib/modules --privileged --cap-add=ALL --hostname minst ubuntu:18.04

docker exec -it ubuntu_minst bash

apt update
apt install git
git clone ****

apt install python3.8
ln -s /usr/bin/python3.8 /usr/bin/python
apt install -y python3-pip
apt install kmod
apt install vim

pip3 install flask
pip3 install numpy
pip3 install torch

apt-get install libjpeg-dev zlib1g-dev
pip3 install Pillow
pip3 install torchvision

安装cv2
apt install cmake
pip3 install -i https://pypi.tuna.tsinghua.edu.cn/simple scikit-build
pip3 install opencv-python

vscode远程连接  https://zhuanlan.zhihu.com/p/361934730