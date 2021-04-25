## 虚拟机部署方式

### 二进制文件编译

程序更新后，如需更新二进制文件，请使用如下方式：

ping-exporter：将[ping-exporter](https://github.com/zbd20/ping-exporter)项目clone到本地，在项目主目录下执行make即可生成二进制文件，并将其复制到当前目录。

ping-probe-register：将[ping-probe-register](https://github.com/zbd20/ping-probe-register)项目clone到本地，在项目主目录下执行make build即可生成二进制文件，并将其复制到当前目录。

### 部署方式

- 设置必需的环境变量
  - POD_NAME：主机的hostname
  - POD_IP：主机的IP
  - REGION：区域
  - VPC：vpc
  - ACCOUNT：主机所属的云账号

- ping-exporter：直接启动即可，监听9346端口
- ping-probe：启动时使用--config=ping-probe-cfg.yaml指定配置文件，监听9347端口
- 拷贝vm文件夹到服务器后，执行deploy.sh部署。

建议ping-exporter启动后再启动ping-probe-register

