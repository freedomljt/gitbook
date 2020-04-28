# Docker常用命令

清理none镜像

```javascript
docker rmi $(docker images --filter "dangling=true" -q --no-trunc)
```

停止所有容器

```javascript
docker stop $(docker ps -aq)
```

删除所有容器

```javascript
docker rm $(docker ps -aq)
```

删除所有镜像

```javascript
docker rmi $(docker images -q)
```

按照镜像名称删除镜像

```javascript
docker rmi $(docker images |grep 'imagename')
```

