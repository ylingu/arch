# Arch Linux on WSL - 快速初始化脚本

## 简介

这是一个用于在 WSL (Windows Subsystem for Linux) 环境中快速初始化和配置 Arch Linux 的 Shell 脚本。它会自动完成一系列繁琐的初始设置，帮助你快速搭建一个可用的、现代化的 Arch Linux 开发环境。

## 功能

该脚本会自动执行以下操作：

1.  **初始化 Pacman 密钥环**并**更新系统**。
2.  设置系统**时区**为 `Asia/Shanghai` (东八区)。
3.  设置系统**语言环境**为 `zh_CN.UTF-8` (中文)，并保留 `en_US.UTF-8` 作为备用。
4.  安装一系列**基础开发软件包**，如 `sudo`, `git`, `neovim` 等。
5.  提示你**创建一个新用户**，并自动将其添加到 `wheel` 组以获取 `sudo` 权限。
6.  配置 WSL **启用 Systemd**，以便更好地管理系统服务（如 Docker）。
7.  将新创建的用户设置为**默认登录用户**。

## 先决条件

在运行此脚本之前，请确保你已经：

- 从 Microsoft Store 安装了 **Arch Linux**。
- 已经启动过一次 Arch Linux，当前应处于 `root` 用户 shell 环境下。

## 使用方法

按照以下步骤在你的 Arch Linux on WSL 环境中下载并运行此脚本。

### 1. 下载脚本

打开你的 Arch Linux 终端，使用 `curl` 或 `wget` 下载 `install.sh` 脚本。

**使用 curl:**
```bash
curl -LO https://raw.githubusercontent.com/ylingu/arch/main/install.sh
```

**或者使用 wget:**
```bash
wget https://raw.githubusercontent.com/ylingu/arch/main/install.sh
```

### 2. 授予执行权限

下载完成后，你需要为脚本添加可执行权限。

```bash
chmod +x install.sh
```

### 3. 运行脚本

由于这是全新的 Arch Linux 环境，你当前默认是 `root` 用户，可以直接运行脚本。

```bash
./install.sh
```

### 4. 遵循脚本指示

脚本运行后，会引导你完成以下操作：

- **输入新用户名**：根据提示输入你想要创建的用户名，然后按 Enter。
- **设置用户密码**：根据提示为新用户输入密码，然后再次输入以确认。

### 5. 完成安装

脚本执行完毕后，会显示最后的说明。**请务必遵循以下关键步骤**：

1.  **关闭**当前的 Arch Linux 窗口。
2.  打开 Windows 的 **PowerShell** 或 **CMD**。
3.  在 PowerShell/CMD 中运行以下命令来**彻底关闭 WSL**：
    ```powershell
    wsl --shutdown
    ```
4.  **重新启动** Arch Linux。此时，你将自动以新创建的用户身份登录，并且所有配置都已生效。

## 注意事项

- 本脚本专为全新的 Arch Linux on WSL 环境设计，请勿在已经配置好的系统上运行，以免造成冲突。
- 运行从网络上下载的脚本存在一定风险，请确保你信任脚本的来源。建议在运行前查看脚本内容。
