# 反向代理工大教务管理系统

所谓反向代理工大教务管理系统的目的，就是方便在外网（工大外部网络）使用工大教务管理系统。

## 使用条件

1. 一台可以在公网环境访问的机器（通常就是云虚拟机），安装系统位Ubuntu 14;

2. 一个工大学生或老师账号，总之要能访问 vpn.bjut.edu.cn;

## 虚拟机环境配置
1. Nginx
2. MotionPro（必须是带命令行的版本，通过一番搜索我终于 找到了，本次使用MotionPro_Linux_CentOS_x86-64_1.0.4.sh）

## 用到的脚本
1. rc.local (/etc/rc.loacl，linux的开机启动自动执行脚本)
2. connect.sh (通过MotionPro连接工大vpn)
3. route_add.sh （修改路由表，目的是你的linux机器可以同时访问工大vpn和公网，如果不修改路由表，你的虚拟机在连接到vpn后，会和你自己断开连接，这时候连ssh都连不上了，只能通过主机提供商的后台重启机器，切记切记）
4. reboot.sh (很直白，就重启linux主机)
5. spilt.sh （时间久了，nginx的日志会很大，这个就是切割日志用的，not important）
6. init.corn (这个是通过 主动调用crontab init.cron,设置定时任务，定时重启机器，定时切割日志)
7. nginx.conf (nginx 的配置文件，很重要)

别看这么多文件，实际没什么东西，都很简单

## 脚本执行顺序

1. 安装Nginx，配置对gdjwlg.bjut.edu.cn 的反向代理，nginx安装完成后会生成/etc/nginx/nginx.conf 配置文件，参考我在github上提供的nginx.conf，完成反向代理设置，这个nginx这块不细细讲，主要是我也不会。但我提供的配置脚本原则上没啥问题，可以直接用

2. 安装Motion Pro，我在github上提供了可以用的一个MotionPro,原则上你可以直接安装使用(装完后可以自己想办法调用connect.sh试试是否装的成功，但是执行这个脚本后，你就和你的虚拟主机失去联系了，当然，如果你有一台linux的pc，那就可以直接测试了，成功的标志就是能打开工大的教务系统，但是却连不上百度)

3. （确保第二步测试成功，否则后面会比较麻烦）此时需要的软件就都装好了，我们需要在终端执行crontab init.cron，添加定时任务，主要有两个，一个是定时重启，一个是定时分割日志，分割日志这个不重要，说说问什么要定时重启

    定时重启是因为学校的vpn连接会自动断开，原因不详，据我观察应该是24个小时断开，所以就需要添加一个重启脚本，每天00:00重启我们的主机

4. rc.loacl，我们只需要变基这个文件，它位于/etc/rc.local，是系统的自启动脚本，记录了什么软件需要开机后启动，这个文件我已经编辑好，放在此项目目录下面了，你只需要对照更改你虚拟机上的即可。

5. 没有5了，所有的任务都在rc.local里面执行了。

## rc.local 

rc.local 里面按照顺序是:

    connext.sh ---> route_add.sh ---> nginx
下面是rc.local里相关的内容


    sh /home/cjw1115/route/connect.sh           #连接vpn
    sleep 4s            #确保vpn连接成功，稍微等等
    sh /home/cjw1115/route/route_add.sh >> /home/cjw1115/route/log_add.txt                  #修改路由表
    sleep 4s
    ./usr/sbin/nginx            #启动nginx
    ./usr/sbin/nginx -s reload          #以防万一，重新加载一下

## 结束

至此，我们就完成了反向代理出教务系统的的全部操作，其实你会发现，以上内容里面，和教务系统相关的大概就只有nginx配置里面的代理网址了，所以意思就是工大内部的任何网站，你都可以通过这种方式反向代理出来。

## 毕竟有些网站不让外部使用，自然有它的目的。所以我们仅限技术研究。