# Ping-prober

## 概述

![image.png](https://i.loli.net/2021/04/06/tEyjnD8KHZqVQ3w.png)

Ping-prober是分布式的网络质量监控解决方案，用于探测公有云环境中各区域间/VPC间的网络延迟和丢包率等指标。

![grafana](https://i.loli.net/2021/04/25/4wTZJgA5S89kceu.png)



## 特点

- 分布式架构，ping-prober探针的数量无限制；
- ping-prober探针之间形成逻辑上的Full mesh连接，可探测任意两个区域/VPC之间的网络质量；
- ping-prober探针自动注册和注销，并依靠Consul Service健康检查实现健康性检测，在ping-prober掉线后还可以自动重新注册；
- 基于Consul的Watch功能，实现Prometheus配置文件自动更新和重载，无需人工干预；
- 提供定制化Grafana dashboard；
- 支持k8s和虚拟机两种部署方式。



## 工作流程

1. 用户启动ping-probe探针时，探针中的ping-probe-register容器会将该Pod的信息（podIP、podName、region、vpc、account）注册为Consul Services的一条记录。
2. config-generator监听到Services的变化，会根据模板重新渲染配置文件并将其保存到Consul Key/Value中。
3. Prometheus采集器Pod中的Consul Template容器监听到Consul Key/Value中对应的Key发生变化，会重新拉取Prometheus配置文件并重载。
4. Prometheus从配置文件指定的ping-exporter中获取该区域/VPC到其他区域/VPC的ping结果数据。
5. Prometheus周期性地将采集到的指标Remote Write到Thanos时序数据库中。



## 依赖组件

- [Consul](https://github.com/hashicorp/consul)：保存ping-probe探针的Service数据及Prometheus配置文件；
- [Consul template](https://github.com/hashicorp/consul-template)：Watch Prometheus配置文件的变化，并自动拉取和重载配置文件；
- [Prometheus](https://github.com/prometheus/prometheus)：定时抓取Metrics并周期性地Remote write到Thanos时序数据库中；
- [Thanos](https://github.com/thanos-io/thanos)：保存Metrics并提供查询能力；
- [Grafana](https://github.com/grafana/grafana)：UI展示；
- [Ping exporter](https://github.com/zbd20/ping-exporter)：Ping指标探测和暴露；
- [Ping probe register](https://github.com/zbd20/ping-probe-register)：自研组件，实现探针的自动注册和注销；
- [Ping prober config generator](https://github.com/zbd20/ping-prober-config-generator)：自研组件，Watch Consul Services的变化并生成Prometheus的配置文件。



## 部署

### k8s部署

请参考[k8s部署方式](https://github.com/zbd20/ping-prober/blob/master/deploy/k8s)

### 虚拟机部署

请参考[虚拟机部署方式](https://github.com/zbd20/ping-prober/blob/master/deploy/vm)

