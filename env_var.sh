#!/bin/bash

IOX_PATH="${PWD}"
RUN_LIST_PATH=${IOX_PATH}"/run_list"
RESULT_PATH=${IOX_PATH}"/result/logs_$(date | awk  '{print $3$2"-"$4}')"
IOX_CONFIG_PATH=${IOX_PATH}"/iox.config"
MINICOM_LOGS=${IOX_PATH}"/minicom_logs"
