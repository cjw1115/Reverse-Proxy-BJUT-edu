#!/bin/bash
logs_path="/var/log/nginx/"
logs_path_new="/home/cjw1115/nginx/log/"
access_log="access.log"
error_log="error.log"
mv "${logs_path}${access_log}" ${logs_path_new}access/access_$(date -d "yesterday" +"%Y%m%d").log
mv "${logs_path}${error_log}" ${logs_path_new}error/error_$(date -d "yesterday" +"%Y%m%d").log
nginx -s reload
