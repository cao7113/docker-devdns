# Why do this?

 本地搭建开发友好的域名系统
 避免大量修改/etc/hosts文件

## Quickstart

```
rake build
docker-compose up -d
dig @localhost -p5300 a.test.dev

# 查看log
docker logs -f devdns
```

## Usage on Mac host

```
sudo ln -s /path/to/etc-resolver-dev /etc/resolver/dev
sudo ln -s /path/to/etc-resolver-dev /etc/resolver/lh
# try 
ping some.demo.dev
```

## How to build and publish public docker images?

```
# first test locally, then
docker login # login docker hub registry to push
docker tag devdns:latest cao7113/devdns:v0.0.1
docker push cao7113/devdns:v0.0.1
```

Has configured autobuild with github pushed tags: vx.x.x

## History

* 2016.12 开始使用https://github.com/madleech/MichaelsDnsServer

  build top on rubydns
  make bootable at mac host using plist file

* 2017.8 基于docker搭建本地环境

  rubydns不错且活跃,rubydns底层实现技术已发生变化(不再使用celluloid-io); MichaelsDnsServer个人项目，好久不更新

  决定基于rubydns最新版本，参照MichaelDnsServer实现个人版本, 并通过版本关联和docker部署机制实现依赖固化

  更多参考[rubydns samples](https://github.com/socketry/rubydns/tree/master/examples)

