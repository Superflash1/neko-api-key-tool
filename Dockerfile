# 使用Node 20进行构建
FROM node:20 as builder

# 定义构建参数，设置默认值
ARG REACT_APP_BASE_URL='{"server1": "https://api.example.com"}'
ARG REACT_APP_SHOW_DETAIL=true
ARG REACT_APP_SHOW_BALANCE=true
ARG REACT_APP_SHOW_ICONGITHUB=true

# 设置环境变量
ENV REACT_APP_BASE_URL=$REACT_APP_BASE_URL
ENV REACT_APP_SHOW_DETAIL=$REACT_APP_SHOW_DETAIL
ENV REACT_APP_SHOW_BALANCE=$REACT_APP_SHOW_BALANCE
ENV REACT_APP_SHOW_ICONGITHUB=$REACT_APP_SHOW_ICONGITHUB

# 设置工作目录
WORKDIR /app

# 复制package文件并安装依赖（利用Docker缓存）
COPY package*.json ./
RUN npm ci --only=production=false

# 复制源代码
COPY . .

# 构建应用
RUN npm run build

# 生产阶段
FROM nginx:1.21.0-alpine

# 复制自定义nginx配置
COPY nginx.conf /etc/nginx/conf.d/default.conf

# 复制构建的应用到nginx目录
COPY --from=builder /app/build /usr/share/nginx/html

# 暴露端口80
EXPOSE 80

# 启动nginx
CMD ["nginx", "-g", "daemon off;"]