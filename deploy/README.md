## ping-prober

ping-prober基于Consul，实现ping监控探针的自动注册和注销功能。

在各个VPC中部署ping-prober探针之前，请保证网络可达：

- ping-prober需要访问consul的8500端口，注册探针
- Consul需要访问各个ping-prober探针的9347端口，做Service的健康检查
- Prometheus采集器需要访问各个ping-prober探针的9346端口
- VPC之间开放ICMP访问

请根据部署环境选择对应的k8s或者vm目录下的文件进行部署。

注意：使用k8s部署时，以下框选的字段请按照所在的集群信息填写。

![image-20210425184517007](https://i.loli.net/2021/04/25/WeJiN9Itjc3fMSV.png)
