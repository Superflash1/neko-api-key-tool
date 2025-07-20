> 该项目需配合NewAPI才能正常使用：[https://github.com/Calcium-Ion/new-api](https://github.com/Calcium-Ion/new-api)

<div align="center">

<h1 align="center">Neko API Key Tool</h1>

NewAPI 令牌查询页

[![Deploy with Vercel](https://vercel.com/button)](https://vercel.com/new/clone?repository-url=https%3A%2F%2Fgithub.com%2FAI-ASS%2Fneko-api-key-tool&env=REACT_APP_SHOW_DETAIL&env=REACT_APP_SHOW_BALANCE&env=REACT_APP_BASE_URL&env=REACT_APP_SHOW_ICONGITHUB&project-name=neko-api-key-tool&repository-name=neko-api-key-tool)

</div>

![image](img.png)


### 使用方法

#### Vercel 部署
1. 准备好你的 [NewAPI项目](https://github.com/Calcium-Ion/new-api);
2. 点击右侧按钮开始部署：
   [![Deploy with Vercel](https://vercel.com/button)](https://vercel.com/new/clone?repository-url=https%3A%2F%2Fgithub.com%2FAI-ASS%2Fneko-api-key-tool&env=REACT_APP_SHOW_DETAIL&env=REACT_APP_SHOW_BALANCE&env=REACT_APP_BASE_URL&env=REACT_APP_SHOW_ICONGITHUB&project-name=neko-api-key-tool&repository-name=neko-api-key-tool)，直接使用 Github 账号登录即可，记得根据自己需求配置环境变量，环境变量如下： 

```   
REACT_APP_SHOW_BALANCE: 是否展示令牌信息，true 或 false
REACT_APP_SHOW_DETAIL: 是否展示调用详情，true 或 false
REACT_APP_BASE_URL: 你的NewAPI项目地址
REACT_APP_SHOW_ICONGITHUB: 是否展示Github图标，true 或 false
```

例如如下配置：
```
# 展示令牌信息
REACT_APP_SHOW_BALANCE=true

# 展示调用详情
REACT_APP_SHOW_DETAIL=true

# NewAPI的BaseURL（支持多个NewAPI站点聚合查询，键值对中的键为站点名称，值为站点的URL）
REACT_APP_BASE_URL={"server1": "https://nekoapi.com", "server2": "https://gf.nekoapi.com"}

# 展示GitHub图标
REACT_APP_SHOW_ICONGITHUB=true
```

3. 部署完毕后，即可开始使用；
4. （可选）[绑定自定义域名](https://vercel.com/docs/concepts/projects/domains/add-a-domain)：Vercel 分配的域名 DNS 在某些区域被污染了，绑定自定义域名即可直连。

#### Docker 部署
1. 克隆项目到本地:
```bash
git clone https://github.com/AI-ASS/neko-api-key-tool.git
cd neko-api-key-tool
```

2. 创建并配置环境变量文件:
```bash
# 复制.env.example文件为.env
cp .env.example .env
# 根据自己需求配置env文件中的环境变量
vim .env
```

3. 构建并运行 Docker 容器:
```bash
# 构建镜像
docker build -t neko-api-key-tool .

# 运行容器
docker run -d -p 80:80 --name neko-api-key-tool neko-api-key-tool
```

### 二次开发
复制.env.example文件为.env，根据自己需求配置env文件中的环境变量。

---

## 🔧 Docker 改进版本说明

### 📋 更新内容

本版本对 Docker 部署进行了重大改进，解决了环境变量处理和白屏问题：

#### ✅ 主要改进
- **升级 Node.js 版本**：从 Node 16 升级到 Node 20
- **优化环境变量处理**：添加构建参数支持，解决白屏问题
- **新增 nginx 配置**：支持 React SPA 路由，优化性能
- **改进构建流程**：利用 Docker 缓存，提高构建效率

#### 🔧 新增文件
- `nginx.conf`: 自定义 nginx 配置，支持前端路由和静态资源优化

### 🚀 改进后的 Docker 使用方法

#### 方法1：使用默认配置构建
```bash
# 克隆项目
git clone https://github.com/AI-ASS/neko-api-key-tool.git
cd neko-api-key-tool

# 构建镜像（使用默认配置）
docker build -t neko-api-key-tool .

# 运行容器
docker run -d -p 80:80 --name neko-api-key-tool neko-api-key-tool
```

#### 方法2：自定义环境变量构建（推荐）
```bash
# 自定义配置构建
docker build -t neko-api-key-tool:custom \
  --build-arg REACT_APP_BASE_URL='{"your-server": "https://your-api.com"}' \
  --build-arg REACT_APP_SHOW_DETAIL=true \
  --build-arg REACT_APP_SHOW_BALANCE=false \
  --build-arg REACT_APP_SHOW_ICONGITHUB=true \
  .

# 运行自定义版本
docker run -d -p 80:80 --name neko-api-custom neko-api-key-tool:custom
```

### ⚠️ 重要说明：环境变量机制

#### 🔴 关键注意事项
React 应用的 `REACT_APP_*` 环境变量在**构建时**就会被编译到 JavaScript 代码中，**运行时无法修改**。

```bash
# ❌ 这样做无效 - 运行时环境变量不会覆盖构建时的配置
docker run -e REACT_APP_BASE_URL='{"new": "https://new-api.com"}' neko-api-key-tool

# ✅ 正确做法 - 在构建时指定配置
docker build --build-arg REACT_APP_BASE_URL='{"new": "https://new-api.com"}' -t neko-custom .
```

#### 📋 环境变量说明

| 变量名 | 类型 | 运行时可修改 | 说明 |
|--------|------|------------|------|
| `REACT_APP_BASE_URL` | 构建时 | ❌ | API 服务器地址，需在构建时指定 |
| `REACT_APP_SHOW_DETAIL` | 构建时 | ❌ | 是否显示详情，需在构建时指定 |
| `REACT_APP_SHOW_BALANCE` | 构建时 | ❌ | 是否显示余额，需在构建时指定 |
| `REACT_APP_SHOW_ICONGITHUB` | 构建时 | ❌ | 是否显示GitHub图标，需在构建时指定 |

### 🛠️ 故障排查

#### 白屏问题解决
如果遇到白屏问题，通常是环境变量配置问题：

1. **检查浏览器控制台**：
   - 按 F12 打开开发者工具
   - 查看 Console 选项卡是否有 JavaScript 错误
   - 常见错误：`JSON.parse() 参数错误`

2. **检查构建参数**：
   ```bash
   # 确保 REACT_APP_BASE_URL 是有效的 JSON 格式
   --build-arg REACT_APP_BASE_URL='{"server1": "https://api.example.com"}'
   ```

3. **验证镜像**：
   ```bash
   # 进入容器检查文件
   docker exec -it <container_name> sh
   ls -la /usr/share/nginx/html
   ```

### 🔧 nginx 配置特性

新增的 `nginx.conf` 提供了以下优化：

- **SPA 路由支持**：所有路由都正确返回 `index.html`
- **静态资源缓存**：JavaScript、CSS 等文件缓存 1 年
- **Gzip 压缩**：减少传输大小，提高加载速度
- **安全头设置**：添加基本的安全响应头
- **健康检查端点**：`/health` 用于容器健康监控

### 📝 版本说明

- **构建环境**：Node.js 20 + npm
- **运行环境**：nginx 1.21.0-alpine
- **支持架构**：x86_64 (amd64)
- **容器大小**：约 25MB（压缩后）


# 分支说明
main 分支未做修改
test 分支做以上修改，可以改进workflow文件中的yml文件后，构建github action，得到定制的镜像