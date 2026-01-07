# 拉取原始镜像
FROM ieax/renewhelper:latest

# 简单的伪装操作：更新时间戳，避免被轻易识别构建时间
RUN touch /var/log/lastlog

# 这里的 Entrypoint 稍后会在 HF 阶段被覆盖，但保持默认即可
