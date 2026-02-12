-- 王者荣耀数据库建表SQL
-- 包含：英雄表、皮肤表、装备表、铭文表、召唤师技能表、玩家表、玩家英雄表、玩家皮肤表
-- 版本：1.0
-- 日期：2026-02-12

-- 创建数据库（如果不存在）
CREATE DATABASE IF NOT EXISTS wzry DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 使用数据库
USE wzry;

-- 1. 英雄表 (hero)
CREATE TABLE IF NOT EXISTS hero (
    hero_id INT PRIMARY KEY COMMENT '英雄ID',
    hero_name VARCHAR(50) NOT NULL COMMENT '英雄名称',
    hero_title VARCHAR(100) NOT NULL COMMENT '英雄称号',
    hero_type VARCHAR(20) NOT NULL COMMENT '英雄类型：坦克、战士、刺客、法师、射手、辅助',
    hero_subtype VARCHAR(20) COMMENT '英雄次要类型',
    price_gold INT COMMENT '金币价格',
    price_diamond INT COMMENT '钻石价格',
    price_coupon INT COMMENT '点券价格',
    attack FLOAT COMMENT '攻击力',
    defense FLOAT COMMENT '防御力',
    magic FLOAT COMMENT '法术强度',
    difficulty FLOAT COMMENT '难度',
    release_date DATE COMMENT '上线日期',
    description TEXT COMMENT '英雄描述',
    skills TEXT COMMENT '技能描述',
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    INDEX idx_hero_type (hero_type),
    INDEX idx_hero_name (hero_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='英雄表';

-- 2. 皮肤表 (skin)
CREATE TABLE IF NOT EXISTS skin (
    skin_id INT PRIMARY KEY COMMENT '皮肤ID',
    hero_id INT NOT NULL COMMENT '所属英雄ID',
    skin_name VARCHAR(100) NOT NULL COMMENT '皮肤名称',
    skin_type VARCHAR(20) NOT NULL COMMENT '皮肤类型：经典、勇者、史诗、传说、限定、荣耀典藏',
    price_coupon INT COMMENT '点券价格',
    price_fragment INT COMMENT '皮肤碎片价格',
    rarity INT COMMENT '稀有度：1-5',
    release_date DATE COMMENT '上线日期',
    description TEXT COMMENT '皮肤描述',
    is_limited TINYINT DEFAULT 0 COMMENT '是否限定：0否，1是',
    is_available TINYINT DEFAULT 1 COMMENT '是否可购买：0否，1是',
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    FOREIGN KEY (hero_id) REFERENCES hero(hero_id) ON DELETE CASCADE,
    INDEX idx_hero_id (hero_id),
    INDEX idx_skin_type (skin_type)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='皮肤表';

-- 3. 装备表 (item)
CREATE TABLE IF NOT EXISTS item (
    item_id INT PRIMARY KEY COMMENT '装备ID',
    item_name VARCHAR(100) NOT NULL COMMENT '装备名称',
    item_type VARCHAR(20) NOT NULL COMMENT '装备类型：攻击、防御、法术、移动、打野、辅助',
    price INT NOT NULL COMMENT '装备价格',
    sell_price INT NOT NULL COMMENT '出售价格',
    attack FLOAT COMMENT '攻击力',
    defense FLOAT COMMENT '防御力',
    magic FLOAT COMMENT '法术强度',
    life FLOAT COMMENT '生命值',
    mana FLOAT COMMENT '法力值',
    critical FLOAT COMMENT '暴击率',
    attack_speed FLOAT COMMENT '攻击速度',
    cooldown FLOAT COMMENT '冷却缩减',
    movement_speed FLOAT COMMENT '移动速度',
    passivity TEXT COMMENT '被动效果',
    active TEXT COMMENT '主动效果',
    description TEXT COMMENT '装备描述',
    is_epic TINYINT DEFAULT 0 COMMENT '是否史诗装备：0否，1是',
    recipe TEXT COMMENT '合成路径',
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    INDEX idx_item_type (item_type),
    INDEX idx_item_name (item_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='装备表';

-- 4. 铭文表 (rune)
CREATE TABLE IF NOT EXISTS rune (
    rune_id INT PRIMARY KEY COMMENT '铭文ID',
    rune_name VARCHAR(100) NOT NULL COMMENT '铭文名称',
    rune_type VARCHAR(20) NOT NULL COMMENT '铭文类型：红色、蓝色、绿色',
    rune_level INT NOT NULL COMMENT '铭文等级：1-5',
    price_gold INT COMMENT '金币价格',
    price_fragment INT COMMENT '铭文碎片价格',
    attack FLOAT COMMENT '攻击力',
    defense FLOAT COMMENT '防御力',
    magic FLOAT COMMENT '法术强度',
    life FLOAT COMMENT '生命值',
    mana FLOAT COMMENT '法力值',
    critical FLOAT COMMENT '暴击率',
    attack_speed FLOAT COMMENT '攻击速度',
    cooldown FLOAT COMMENT '冷却缩减',
    movement_speed FLOAT COMMENT '移动速度',
    description TEXT COMMENT '铭文描述',
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    INDEX idx_rune_type (rune_type),
    INDEX idx_rune_level (rune_level)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='铭文表';

-- 5. 召唤师技能表 (summoner_skill)
CREATE TABLE IF NOT EXISTS summoner_skill (
    skill_id INT PRIMARY KEY COMMENT '技能ID',
    skill_name VARCHAR(50) NOT NULL COMMENT '技能名称',
    skill_cd INT NOT NULL COMMENT '技能冷却时间（秒）',
    unlock_level INT NOT NULL COMMENT '解锁等级',
    description TEXT NOT NULL COMMENT '技能描述',
    effect TEXT COMMENT '技能效果',
    icon VARCHAR(255) COMMENT '技能图标',
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    INDEX idx_skill_name (skill_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='召唤师技能表';

-- 6. 玩家表 (player)
CREATE TABLE IF NOT EXISTS player (
    player_id INT PRIMARY KEY AUTO_INCREMENT COMMENT '玩家ID',
    username VARCHAR(50) NOT NULL UNIQUE COMMENT '用户名',
    nickname VARCHAR(50) NOT NULL COMMENT '游戏昵称',
    level INT NOT NULL DEFAULT 1 COMMENT '玩家等级',
    exp INT NOT NULL DEFAULT 0 COMMENT '经验值',
    gold INT NOT NULL DEFAULT 0 COMMENT '金币',
    diamond INT NOT NULL DEFAULT 0 COMMENT '钻石',
    coupon INT NOT NULL DEFAULT 0 COMMENT '点券',
    vip_level INT DEFAULT 0 COMMENT 'VIP等级',
    register_date DATE NOT NULL COMMENT '注册日期',
    last_login_date DATETIME COMMENT '最后登录日期',
    avatar VARCHAR(255) COMMENT '头像',
    signature VARCHAR(255) COMMENT '个性签名',
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    INDEX idx_username (username),
    INDEX idx_nickname (nickname)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='玩家表';

-- 7. 玩家英雄表 (player_hero)
CREATE TABLE IF NOT EXISTS player_hero (
    id INT PRIMARY KEY AUTO_INCREMENT COMMENT '记录ID',
    player_id INT NOT NULL COMMENT '玩家ID',
    hero_id INT NOT NULL COMMENT '英雄ID',
    acquire_date DATE NOT NULL COMMENT '获取日期',
   熟练度 INT NOT NULL DEFAULT 0 COMMENT '熟练度',
    play_count INT NOT NULL DEFAULT 0 COMMENT '使用次数',
    win_count INT NOT NULL DEFAULT 0 COMMENT '获胜次数',
    highest_score INT COMMENT '最高评分',
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    UNIQUE KEY uk_player_hero (player_id, hero_id),
    FOREIGN KEY (player_id) REFERENCES player(player_id) ON DELETE CASCADE,
    FOREIGN KEY (hero_id) REFERENCES hero(hero_id) ON DELETE CASCADE,
    INDEX idx_player_id (player_id),
    INDEX idx_hero_id (hero_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='玩家英雄表';

-- 8. 玩家皮肤表 (player_skin)
CREATE TABLE IF NOT EXISTS player_skin (
    id INT PRIMARY KEY AUTO_INCREMENT COMMENT '记录ID',
    player_id INT NOT NULL COMMENT '玩家ID',
    skin_id INT NOT NULL COMMENT '皮肤ID',
    acquire_date DATE NOT NULL COMMENT '获取日期',
    acquire_way VARCHAR(50) COMMENT '获取方式',
    last_use_date DATETIME COMMENT '最后使用日期',
    use_count INT NOT NULL DEFAULT 0 COMMENT '使用次数',
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    UNIQUE KEY uk_player_skin (player_id, skin_id),
    FOREIGN KEY (player_id) REFERENCES player(player_id) ON DELETE CASCADE,
    FOREIGN KEY (skin_id) REFERENCES skin(skin_id) ON DELETE CASCADE,
    INDEX idx_player_id (player_id),
    INDEX idx_skin_id (skin_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='玩家皮肤表';

-- 插入示例数据：英雄表
INSERT INTO hero (hero_id, hero_name, hero_title, hero_type, hero_subtype, price_gold, price_diamond, price_coupon, attack, defense, magic, difficulty, release_date, description, skills) VALUES
(1, '李白', '青莲剑仙', '刺客', '战士', 18888, 688, 688, 9.5, 4.0, 1.5, 8.5, '2016-03-01', '李白是一名机动性极高的刺客英雄，擅长利用技能刷新机制进行连续输出。', '被动：侠客行\n一技能：将进酒\n二技能：神来之笔\n三技能：青莲剑歌'),
(2, '韩信', '国士无双', '刺客', '战士', 18888, 688, 688, 9.0, 3.5, 1.0, 9.0, '2015-11-26', '韩信是一名拥有极高机动性的刺客英雄，擅长打野和带线。', '被动：杀意之枪\n一技能：无情冲锋\n二技能：背水一战\n三技能：国士无双'),
(3, '貂蝉', '绝世舞姬', '法师', '刺客', 13888, 588, 588, 2.0, 3.0, 10.0, 8.0, '2015-12-15', '貂蝉是一名拥有高爆发和持续输出能力的法师英雄。', '被动：语·花印\n一技能：落·红雨\n二技能：缘·心结\n三技能：绽·风华'),
(4, '孙悟空', '齐天大圣', '刺客', '战士', 18888, 688, 688, 9.8, 4.5, 1.0, 7.5, '2015-08-18', '孙悟空是一名拥有高爆发能力的刺客英雄，擅长秒杀脆皮。', '被动：大圣神威\n一技能：如意金箍\n二技能：斗战冲锋\n三技能：大闹天宫'),
(5, '鲁班七号', '机关造物', '射手', NULL, 5888, 288, 288, 8.5, 2.0, 1.0, 6.0, '2015-07-17', '鲁班七号是一名拥有高输出能力的射手英雄，但其机动性较差。', '被动：火力压制\n一技能：河豚手雷\n二技能：无敌鲨嘴炮\n三技能：空中支援'),
(6, '花木兰', '传说之刃', '战士', '刺客', 18888, 688, 688, 8.5, 6.0, 1.0, 9.5, '2016-01-12', '花木兰是一名拥有双形态的战士英雄，切换形态可以获得不同的技能效果。', '被动：战意值\n一技能：空裂斩\n二技能：旋舞之华\n三技能：绽放刀锋'),
(7, '赵云', '苍天翔龙', '战士', '刺客', 5888, 288, 288, 8.0, 5.0, 1.0, 7.0, '2015-09-21', '赵云是一名拥有高机动性和生存能力的战士英雄。', '被动：龙鸣\n一技能：惊雷之龙\n二技能：破云之龙\n三技能：天翔之龙'),
(8, '王昭君', '冰雪之华', '法师', '控制', 8888, 388, 388, 1.5, 3.0, 9.5, 7.0, '2015-10-28', '王昭君是一名拥有强大控制能力的法师英雄。', '被动：冰封之心\n一技能：凋零冰晶\n二技能：禁锢寒霜\n三技能：凛冬已至'),
(9, '项羽', '西楚霸王', '坦克', '战士', 13888, 588, 588, 6.0, 9.0, 1.0, 6.0, '2015-11-09', '项羽是一名拥有强大控制和保护能力的坦克英雄。', '被动：陷阵之志\n一技能：无畏冲锋\n二技能：破釜沉舟\n三技能：霸王斩'),
(10, '妲己', '魅力之狐', '法师', '控制', 5888, 288, 288, 1.0, 2.0, 10.0, 5.0, '2015-07-17', '妲己是一名拥有高爆发能力的法师英雄，操作简单易上手。', '被动：失心\n一技能：灵魂冲击\n二技能：偶像魅力\n三技能：女王崇拜');

-- 插入示例数据：皮肤表
INSERT INTO skin (skin_id, hero_id, skin_name, skin_type, price_coupon, price_fragment, rarity, release_date, description, is_limited, is_available) VALUES
(1, 1, '范海辛', '勇者', 288, 28, 2, '2016-03-01', '李白的勇者皮肤，以西方吸血鬼为主题。', 0, 1),
(2, 1, '千年之狐', '史诗', 788, 78, 4, '2016-10-25', '李白的史诗皮肤，以狐仙为主题，拥有独特的技能特效。', 0, 1),
(3, 1, '凤求凰', '传说', 1688, NULL, 5, '2017-01-27', '李白的传说皮肤，以凤凰为主题，鸡年限定。', 1, 0),
(4, 2, '教廷特使', '勇者', 288, 28, 2, '2015-11-26', '韩信的勇者皮肤，以西方教廷为主题。', 0, 1),
(5, 2, '白龙吟', '史诗', 1188, 118, 4, '2016-03-11', '韩信的史诗皮肤，以白龙为主题，拥有独特的技能特效。', 0, 1),
(6, 3, '异域舞娘', '勇者', 288, 28, 2, '2015-12-15', '貂蝉的勇者皮肤，以异域风情为主题。', 0, 1),
(7, 3, '圣诞恋歌', '史诗', 788, 78, 4, '2015-12-22', '貂蝉的史诗皮肤，圣诞节限定。', 1, 0),
(8, 4, '地狱火', '传说', 1688, NULL, 5, '2016-02-01', '孙悟空的传说皮肤，以地狱火为主题，拥有独特的技能特效。', 0, 1),
(9, 4, '大圣娶亲', '史诗', 888, 88, 4, '2019-02-04', '孙悟空的史诗皮肤，以电影《大话西游》为主题，猪年限定。', 1, 0),
(10, 5, '福禄兄弟', '勇者', 288, 28, 2, '2016-02-01', '鲁班七号的勇者皮肤，春节限定。', 1, 0),
(11, 5, '电玩小子', '史诗', 2888, 288, 4, '2016-06-01', '鲁班七号的史诗皮肤，以电玩游戏为主题，拥有独特的技能特效。', 0, 1),
(12, 6, '剑舞者', '勇者', 288, 28, 2, '2016-01-12', '花木兰的勇者皮肤，以剑舞者为主题。', 0, 1),
(13, 6, '水晶猎龙者', '史诗', 888, 88, 4, '2016-07-12', '花木兰的史诗皮肤，以猎龙者为主题，拥有独特的技能特效。', 0, 1),
(14, 7, '未来纪元', '勇者', 888, 88, 3, '2016-02-01', '赵云的勇者皮肤，以未来科技为主题。', 0, 1),
(15, 7, '引擎之心', '传说', 888, NULL, 4, '2016-04-11', '赵云的传说皮肤，与宝马合作推出，限定。', 1, 0),
(16, 8, '凤凰于飞', '史诗', 888, 88, 4, '2016-02-01', '王昭君的史诗皮肤，以凤凰为主题，鸡年限定。', 1, 0),
(17, 9, '帝国元帅', '勇者', 288, 28, 2, '2015-11-09', '项羽的勇者皮肤，以帝国元帅为主题。', 0, 1),
(18, 10, '少女阿狸', '勇者', 288, 28, 2, '2015-07-17', '妲己的勇者皮肤，以可爱少女为主题。', 0, 1),
(19, 10, '仙境爱丽丝', '史诗', 888, 88, 4, '2016-03-01', '妲己的史诗皮肤，以爱丽丝梦游仙境为主题。', 0, 1),
(20, 10, '热情桑巴', '史诗', 998, NULL, 4, '2016-08-01', '妲己的史诗皮肤，巴西世界杯限定。', 1, 0);

-- 插入示例数据：装备表
INSERT INTO item (item_id, item_name, item_type, price, sell_price, attack, defense, magic, life, mana, critical, attack_speed, cooldown, movement_speed, passivity, active, description, is_epic, recipe) VALUES
(1, '暗影战斧', '攻击', 2090, 1254, 85, 40, 0, 0, 0, 0, 0, 15, 0, '切割：增加物理穿透，击败或助攻会减少技能冷却', NULL, '物理攻击装备，适合战士和刺客', 0, '铁剑+日冕+陨星'),
(2, '破军', '攻击', 2950, 1770, 180, 0, 0, 0, 0, 0, 0, 0, 0, '破军：对生命值低于50%的敌人造成额外伤害', NULL, '物理攻击装备，适合射手和刺客', 0, '风暴巨剑+破败王者之刃'),
(3, '无尽战刃', '攻击', 2140, 1284, 110, 0, 0, 0, 0, 20, 0, 0, 0, '无尽：增加暴击效果', NULL, '物理攻击装备，适合射手', 0, '风暴巨剑+红玛瑙+搏击拳套'),
(4, '泣血之刃', '攻击', 1740, 1044, 100, 0, 0, 0, 0, 0, 0, 0, 0, '嗜血：增加物理吸血', NULL, '物理攻击装备，适合射手', 0, '风暴巨剑+吸血之镰'),
(5, '不祥征兆', '防御', 2180, 1308, 0, 270, 0, 1200, 0, 0, 0, 0, 0, '寒铁：受到攻击时减少攻击者攻速和移速', NULL, '物理防御装备，适合坦克', 0, '力量腰带+布甲+守护者之铠'),
(6, '魔女斗篷', '防御', 2080, 1248, 0, 0, 0, 1000, 0, 0, 0, 0, 0, '迷雾：获得法术护盾', NULL, '法术防御装备，适合坦克', 0, '力量腰带+抗魔披风+神隐斗篷'),
(7, '不死鸟之眼', '防御', 2100, 1260, 0, 0, 0, 1200, 0, 0, 0, 0, 0, '血统：增加生命回复效果', NULL, '法术防御装备，适合战士', 0, '力量腰带+抗魔披风+提神水晶'),
(8, '回响之杖', '法术', 2100, 1260, 0, 0, 240, 0, 0, 0, 0, 0, 7, '回响：技能命中后触发小范围爆炸', NULL, '法术攻击装备，适合法师', 0, '大棒+元素杖'),
(9, '博学者之怒', '法术', 2300, 1380, 0, 0, 240, 0, 0, 0, 0, 0, 0, '毁灭：增加法术强度', NULL, '法术攻击装备，适合法师', 0, '大棒+大棒'),
(10, '虚无法杖', '法术', 2110, 1266, 0, 0, 180, 0, 0, 0, 0, 0, 0, '虚空：增加法术穿透', NULL, '法术攻击装备，适合法师', 0, '大棒+元素杖+圣者法典'),
(11, '疾步之靴', '移动', 500, 300, 0, 0, 0, 0, 0, 0, 0, 0, 60, NULL, NULL, '移动装备，增加移速', 0, NULL),
(12, '抵抗之靴', '移动', 710, 426, 0, 0, 0, 0, 0, 0, 0, 0, 45, '韧性：减少控制效果持续时间', NULL, '移动装备，增加韧性', 0, NULL),
(13, '暗影战斧', '攻击', 2090, 1254, 85, 40, 0, 0, 0, 0, 0, 15, 0, '切割：增加物理穿透，击败或助攻会减少技能冷却', NULL, '物理攻击装备，适合战士和刺客', 0, '铁剑+日冕+陨星'),
(14, '红buff', '打野', 0, 0, 20, 0, 0, 0, 0, 0, 0, 0, 0, '灼烧：普通攻击附带真实伤害', NULL, '打野装备', 0, NULL),
(15, '蓝buff', '打野', 0, 0, 0, 0, 20, 0, 0, 0, 0, 0, 0, '回蓝：减少技能冷却，增加法力回复', NULL, '打野装备', 0, NULL);

-- 插入示例数据：铭文表
INSERT INTO rune (rune_id, rune_name, rune_type, rune_level, price_gold, price_fragment, attack, defense, magic, life, mana, critical, attack_speed, cooldown, movement_speed, description) VALUES
(1, '异变', '红色', 5, 0, 1600, 2, 0, 0, 0, 0, 0, 0, 0, 0, '物理攻击+物理穿透', 1),
(2, '鹰眼', '绿色', 5, 0, 1600, 0.9, 0, 0, 0, 0, 0, 0, 0, 0, '物理攻击+物理穿透', 1),
(3, '狩猎', '蓝色', 5, 0, 1600, 0, 0, 0, 0, 0, 0, 1, 0, 1, '攻击速度+移动速度', 1),
(4, '红月', '红色', 5, 0, 1600, 1.6, 0, 0, 0, 0, 0.5, 0, 0, 0, '攻击速度+暴击率', 1),
(5, '心眼', '绿色', 5, 0, 1600, 0.6, 0, 0, 0, 0, 0, 0.6, 0, 0, '攻击速度+法术穿透', 1),
(6, '隐匿', '蓝色', 5, 0, 1600, 1.6, 0, 0, 0, 0, 0, 0, 0, 1, '物理攻击+移动速度', 1),
(7, '圣人', '红色', 5, 0, 1600, 0, 0, 5.3, 0, 0, 0, 0, 0, 0, '法术强度', 1),
(8, '怜悯', '绿色', 5, 0, 1600, 0, 0, 0, 0, 0, 0, 0, 1, 0, '冷却缩减', 1),
(9, '轮回', '蓝色', 5, 0, 1600, 0, 0, 2.4, 0, 0, 0, 0, 0, 0, '法术强度+法术吸血', 1),
(10, '宿命', '红色', 5, 0, 1600, 1, 2.3, 0, 60, 0, 0, 0, 0, 0, '生命值+物理防御+攻击速度', 1),
(11, '调和', '蓝色', 5, 0, 1600, 0, 0, 0, 45, 52, 0, 0, 0, 0.4, '生命值+生命回复+移动速度', 1),
(12, '虚空', '绿色', 5, 0, 1600, 0, 0, 0, 37.5, 0, 0, 0, 0.6, 0, '生命值+冷却缩减', 1);

-- 插入示例数据：召唤师技能表
INSERT INTO summoner_skill (skill_id, skill_name, skill_cd, unlock_level, description, effect, icon) VALUES
(1, '惩戒', 30, 1, '对野怪和小兵造成真实伤害并眩晕', '对目标造成基于等级的真实伤害，并眩晕目标1秒', '惩戒.png'),
(2, '闪现', 120, 7, '向指定方向瞬间移动一段距离', '向指定方向位移一段距离', '闪现.png'),
(3, '治疗术', 120, 1, '恢复自己和附近队友的生命值', '恢复自己和附近队友15%的最大生命值，并增加移动速度', '治疗术.png'),
(4, '净化', 120, 10, '解除自身所有负面状态', '解除自身所有控制效果，并在接下来的2秒内免疫控制', '净化.png'),
(5, '眩晕', 90, 3, '对指定方向的敌人造成伤害并眩晕', '对指定方向的敌人造成伤害，并眩晕1秒', '眩晕.png'),
(6, '终结', 90, 5, '对生命值低于50%的敌人造成真实伤害', '对目标造成基于目标已损失生命值的真实伤害', '终结.png'),
(7, '狂暴', 60, 1, '增加攻击速度和物理吸血', '增加攻击速度和物理吸血，持续7秒', '狂暴.png'),
(8, '干扰', 60, 9, '沉默敌方防御塔', '沉默敌方防御塔4秒', '干扰.png'),
(9, '弱化', 90, 8, '减少附近敌人的伤害输出', '减少附近敌人30%的伤害输出，持续2.5秒', '弱化.png'),
(10, '疾跑', 100, 6, '增加移动速度', '增加30%的移动速度，持续10秒', '疾跑.png');

-- 插入示例数据：玩家表
INSERT INTO player (player_id, username, nickname, level, exp, gold, diamond, coupon, vip_level, register_date, last_login_date, avatar, signature) VALUES
(1, 'player1', '王者荣耀大神', 30, 99999, 50000, 1000, 500, 5, '2025-01-01', '2026-02-12 12:00:00', 'avatar1.png', '无敌是多么寂寞'),
(2, 'player2', '荣耀王者', 30, 99999, 45000, 800, 300, 4, '2025-02-01', '2026-02-12 11:00:00', 'avatar2.png', '最强王者不是梦'),
(3, 'player3', '钻石选手', 25, 50000, 30000, 500, 100, 3, '2025-03-01', '2026-02-12 10:00:00', 'avatar3.png', '努力冲上王者'),
(4, 'player4', '铂金菜鸟', 20, 30000, 20000, 300, 50, 2, '2025-04-01', '2026-02-12 09:00:00', 'avatar4.png', '新手求带'),
(5, 'player5', '黄金大神', 15, 15000, 10000, 100, 0, 1, '2025-05-01', '2026-02-12 08:00:00', 'avatar5.png', '黄金段位无敌手');

-- 插入示例数据：玩家英雄表
INSERT INTO player_hero (player_id, hero_id, acquire_date,熟练度, play_count, win_count, highest_score) VALUES
(1, 1, '2025-01-02', 10000, 500, 350, 16.0),
(1, 2, '2025-01-03', 8000, 400, 280, 15.5),
(1, 3, '2025-01-04', 9000, 450, 315, 15.8),
(2, 4, '2025-02-02', 7000, 300, 210, 15.0),
(2, 5, '2025-02-03', 6000, 250, 175, 14.5),
(3, 6, '2025-03-02', 5000, 200, 120, 14.0),
(3, 7, '2025-03-03', 4000, 150, 90, 13.5),
(4, 8, '2025-04-02', 3000, 100, 60, 13.0),
(4, 9, '2025-04-03', 2000, 80, 40, 12.5),
(5, 10, '2025-05-02', 1000, 50, 25, 12.0);

-- 插入示例数据：玩家皮肤表
INSERT INTO player_skin (player_id, skin_id, acquire_date, acquire_way, last_use_date, use_count) VALUES
(1, 1, '2025-01-02', '点券购买', '2026-02-12 12:00:00', 100),
(1, 2, '2025-01-03', '点券购买', '2026-02-12 11:30:00', 80),
(1, 3, '2025-02-01', '活动获取', '2026-02-12 11:00:00', 50),
(2, 4, '2025-02-02', '点券购买', '2026-02-12 10:30:00', 70),
(2, 5, '2025-02-03', '点券购买', '2026-02-12 10:00:00', 60),
(3, 6, '2025-03-02', '皮肤碎片兑换', '2026-02-12 09:30:00', 40),
(3, 7, '2025-03-03', '活动获取', '2026-02-12 09:00:00', 30),
(4, 8, '2025-04-02', '点券购买', '2026-02-12 08:30:00', 20),
(4, 9, '2025-04-03', '活动获取', '2026-02-12 08:00:00', 15),
(5, 10, '2025-05-02', '皮肤碎片兑换', '2026-02-12 07:30:00', 10);

-- 数据库初始化完成
SELECT '王者荣耀数据库初始化完成！' AS message;