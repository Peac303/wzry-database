# 王者荣耀数据库设计 (wzry-database)

基于 AI 生成的王者荣耀完整游戏数据库结构，适用于后端学习、游戏数据分析与课程设计。

## 项目简介

本项目提供了一套标准化的《王者荣耀》游戏数据模型，涵盖了核心的游戏实体与关系，可作为后端 API 开发、数据分析或学习数据库设计的基础。

## 核心表结构

| 表名 | 说明 |
|------|------|
| `user` | 用户表，存储玩家账号信息 |
| `hero` | 英雄表，存储英雄基础属性与定位 |
| `skin` | 皮肤表，存储英雄皮肤信息 |
| `item` | 装备表，存储游戏内装备属性 |
| `inscription` | 铭文表，存储铭文套装与属性 |
| `user_hero` | 用户-英雄关联表，记录玩家拥有的英雄 |
| `user_skin` | 用户-皮肤关联表，记录玩家拥有的皮肤 |
| `user_inscription` | 用户-铭文关联表，记录玩家的铭文套装 |

## 快速开始

1.  **克隆仓库**
    ```bash
    git clone https://github.com/Peac303/wzry-database.git
    ```

2.  **导入数据库**
    -   使用 MySQL 客户端执行 `wzry_database.sql` 文件
    -   或通过图形化工具（如 Navicat、DBeaver）导入 SQL 文件

3.  **验证安装**
    -   连接到数据库，执行 `SHOW TABLES;` 查看所有表
    -   执行 `SELECT * FROM hero LIMIT 10;` 验证数据

## 技术栈

-   **数据库**: MySQL 5.7 / 8.0
-   **生成工具**: 字节跳动 Trae Builder
-   **版本控制**: Git & GitHub

## 适用场景

-   后端学习项目
-   游戏数据分析
-   Java/Python/Go 课程设计
-   接口开发练手

## 贡献

欢迎提交 Issue 或 Pull Request 来完善项目。
