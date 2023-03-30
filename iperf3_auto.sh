#!/bin/bash

# 测试服务器和端口
SERVER="填写iperf3服务节点IP"
PORT="5201"

# 循环测试次数
NUM_TESTS=999999

# 每次测试时间
TEST_DURATION=30

# 测试带宽范围（Mbps）
MIN_BW=50
MAX_BW=300

# 循环测试
for ((i=1; i<=$NUM_TESTS; i++)); do
  # 随机生成测试带宽
  BANDWIDTH=$(( $RANDOM % ($MAX_BW - $MIN_BW + 1) + $MIN_BW ))

  # 随机选择上传或下载
  DIRECTION=""
  if (( $RANDOM % 2 == 0 )); then
    DIRECTION="-R"
  fi

  # 执行iperf3测试命令
  iperf3 -c $SERVER -p $PORT $DIRECTION -t $TEST_DURATION -b ${BANDWIDTH}M

  # 输出测试结果
  echo "Test $i - Bandwidth: ${BANDWIDTH} Mbps, Direction: ${DIRECTION:-Download}"
  echo "=================================================="

  # 间隔5秒后进行下一次测试
  sleep 10
done
