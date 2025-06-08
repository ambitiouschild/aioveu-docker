# aioveu-docker
aioveu-docker








├── mysql                      #1.mysql数据库                       
│   ├── conf
│   │   └── my.cnf
│   └── data
├── nacos                      #2.nacos  注册中心
│   ├── conf
│   │   └── application.properties
│   │   └── jdbc.properties  nacos-logback.xml
│   │   └── nacos-logback.xml
│   └── datadir
│   └── logs
│   └── wait-for-mysql.sh
├── seata                     #3.seata  分布式事务
│   ├── config
│   │   └── file.conf
│   │   └── registry.conf
│   ├── lib
│   └── logs
├── redis                   #4.redis  缓存
│   ├── conf
│   │   └── redis.conf
│   └── data
├── minio                   #5.minio  云存储
├── rabbitmq                #6.rabbitmq  消息队列
├── xxl-job-admin           #7.xxl-job-admin
├── gateway                 #1.gateway  网关
├── auth                    #2.auth  安全中心
├── system                  #3.system  系统设置
├── oms                     #4.oms  订单服务
├── pms                     #5.pms  商品服务
├── sms                     #6.sms  营销服务
├── ums                     #7.ums  会员服务
 

├── docker-compose.yaml                     # 创建一个名为 "aioveu-server" 的桥接网络，在同一个网络中的容器可以通过容器名互相访问
├── run.md                                  ## 安装


我们遇到了两个主要问题：

配置文件 '/etc/my.cnf' 被忽略，因为它是全局可写的（world-writable），这存在安全风险，MySQL 出于安全考虑会忽略这样的配置文件。
数据目录 '/var/lib/mysql/' 已经存在文件，而我们在初始化时要求数据目录为空。

解决方案：

修复配置文件的权限，确保不是全局可写。
清理数据目录，确保初始化时数据目录为空。

但是注意：如果这是第一次初始化，那么数据目录应该是空的。如果之前已经初始化过，那么再次初始化就会失败。因此，我们需要确保数据目录是空的。

但是，由于我们使用的是MySQL官方镜像，它已经有一个entrypoint脚本。我们可以通过环境变量或者挂载卷的方式来解决。

所以，出现这个错误可能是因为之前初始化失败，导致数据目录留下了一些文件，而再次启动时，entrypoint脚本尝试初始化，但发现数据目录非空，因此报错。

因此，我们可以采取以下步骤：

停止并删除当前容器（如果存在）。
删除关联的数据卷（或者手动删除数据目录的内容）。
修复配置文件权限：在容器启动前，确保配置文件权限正确，或者在Dockerfile中设置好权限。

例如，在运行容器时，我们可以通过以下步骤：
步骤1：创建一个自定义的entrypoint脚本，在调用MySQL的entrypoint之前，先修复权限并清理数据目录（如果需要重新初始化）。
步骤2：或者，在运行容器时，通过命令在启动前删除数据目录的内容。

但是，通常我们不建议在每次启动时都清理数据目录，因为这样会丢失数据。所以，这个操作应该只在初始化失败时进行。

根据错误信息，我们可以手动处理：

进入容器或者宿主机的数据目录，删除数据目录中的所有文件（如果数据不重要）。
修改配置文件权限。

进入 MySQL 容器内部。可以使用命令（假设<mysql - container - name>是你的 MySQL 容器名称）。
docker exec -it aioveu-mysql bash
登录到 MySQL 数据库。在容器内部，使用mysql -u root -p命令，然后输入密码登录。
SHOW DATABASES;查看所有数据库；

SHOW DATABASES;
use mysql，进入mysql数据库

use mysql

.查询用户的权限信息。使用SELECT user, host FROM user;命令可以查看所有用户及其允许连接的主机信息。
SELECT user, host FROM user;

修改user表中的Host:update user set Host='%' where User='root';

update user set Host='%' where User='root';

刷新权限。使用FLUSH PRIVILEGES;命令，使权限设置生效。

FLUSH PRIVILEGES;

查看当前登录的IP是否被允许
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '775825';



配置加载优先级
Seata 配置加载优先级如下 (从高到低)：

​环境变量​ (如 SEATA_STORE_DB_DATASOURCE)
​JVM 系统属性​ (通过 JAVA_OPTS 设置)
​配置文件​ (Nacos 中的配置)
​本地配置文件​ (registry.conf)
配置中心优势
​集中管理​：所有配置在 Nacos 统一管理
​动态更新​：修改配置无需重启服务
​版本控制​：Nacos 提供配置历史记录
​权限管理​：可控制不同团队对配置的访问权限


Seata 使用以下配置加载优先级（从高到低）：

​JVM 系统属性​ (-D 参数)
​环境变量​
​Nacos 配置中心​
​本地配置文件​ (registry.conf)
​Seata 内部默认值