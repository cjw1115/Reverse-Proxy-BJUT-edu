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

3. （确保第二步测试成功，否则后面会比较麻烦）