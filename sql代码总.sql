create database chongwu;

-- 宠物领养信息平台数据库模型设计

CREATE TABLE pet_info (
    pet_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    species VARCHAR(50) NOT NULL,
    breed VARCHAR(50),
    age INT,
    gender VARCHAR(10),
    description TEXT,
    image_url VARCHAR(255),
    status VARCHAR(20) DEFAULT 'available' -- available, adopted, pending
);

CREATE TABLE contact_person (
    contact_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(100),
    address VARCHAR(255)
);

CREATE TABLE adoption_application (
    application_id INT AUTO_INCREMENT PRIMARY KEY,
    pet_id INT NOT NULL,
    contact_id INT NOT NULL,adoption_application
    application_application_datedate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) DEFAULT 'pending', -- pending, approved, rejected
    FOREIGN KEY (pet_id) REFERENCES pet_info(pet_id),
    FOREIGN KEY (contact_id) REFERENCES contact_person(contact_id)
);

-- 索引优化
CREATE INDEX idx_pet_status ON pet_info(status);
CREATE INDEX idx_application_status ON adoption_application(status);

-- 宠物领养系统测试数据
-- 使用前请确保已创建数据库和表结构

USE chongwu;

-- 清空现有数据（可选，如果需要重置数据）
-- TRUNCATE TABLE adoption_application;
-- TRUNCATE TABLE contact_person;
-- TRUNCATE TABLE pet_info;

-- 插入宠物信息数据
INSERT INTO pet_info (name, species, breed, age, gender, description, image_url, status) VALUES
('小白', '狗', '金毛', 2, '公', '温顺可爱的金毛，喜欢和人玩耍，已经完成疫苗接种，身体健康。适合有孩子的家庭。', 'https://images.unsplash.com/photo-1552053831-71594a27632d?w=400', 'available'),
('小花', '猫', '英国短毛猫', 1, '母', '活泼好动的小猫咪，性格温顺，喜欢被抚摸。已经绝育，身体健康。', 'https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?w=400', 'available'),
('小黑', '狗', '拉布拉多', 3, '公', '聪明听话的拉布拉多，训练有素，会基本的指令。适合作为家庭宠物。', 'https://images.unsplash.com/photo-1534361960057-19889c938271?w=400', 'available'),
('咪咪', '猫', '橘猫', 2, '母', '可爱的橘猫，性格温和，喜欢晒太阳。已经完成疫苗接种。', 'https://images.unsplash.com/photo-1574158622682-e40e69881006?w=400', 'available'),
('旺财', '狗', '哈士奇', 4, '公', '精力充沛的哈士奇，需要大量运动。性格友好，适合有经验的养狗人士。', 'https://images.unsplash.com/photo-1583337130417-3346a1be7dee?w=400', 'available'),
('小橘', '猫', '橘猫', 1, '公', '活泼可爱的小橘猫，喜欢玩耍，性格开朗。适合有孩子的家庭。', 'https://images.unsplash.com/photo-1513245543132-31f507417b26?w=400', 'available'),
('豆豆', '狗', '泰迪', 2, '母', '小巧可爱的泰迪，性格温顺，适合公寓饲养。已经完成疫苗接种和绝育。', 'https://images.unsplash.com/photo-1587300003388-59208cc962cb?w=400', 'available'),
('球球', '猫', '美国短毛猫', 3, '公', '温顺的短毛猫，喜欢安静的环境。身体健康，已经绝育。', 'https://images.unsplash.com/photo-1571566882372-1598d88abd90?w=400', 'available'),
('大毛', '狗', '萨摩耶', 5, '公', '温顺友好的萨摩耶，性格温和，适合家庭饲养。需要定期梳理毛发。', 'https://images.unsplash.com/photo-1601758228041-f3b2795255f1?w=400', 'adopted'),
('小美', '猫', '波斯猫', 2, '母', '优雅的波斯猫，性格安静，喜欢独处。需要定期护理长毛。', 'https://images.unsplash.com/photo-1574158622682-e40e69881006?w=400', 'adopted'),
('乐乐', '狗', '比熊', 1, '母', '活泼可爱的小比熊，性格开朗，喜欢和人互动。适合新手饲养。', 'https://images.unsplash.com/photo-1605568427561-40dd23c2acea?w=400', 'pending'),
('小灰', '猫', '英短蓝猫', 2, '公', '温顺的蓝猫，性格独立但友好。已经完成疫苗接种，身体健康。', 'https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?w=400', 'pending'),
('多多', '狗', '柯基', 3, '公', '聪明活泼的柯基，短腿长身，非常可爱。训练有素，适合家庭饲养。', 'https://images.unsplash.com/photo-1534361960057-19889c938271?w=400', 'available'),
('小黄', '猫', '橘猫', 1, '母', '活泼好动的小橘猫，喜欢玩耍，性格开朗。适合有经验的养猫人士。', 'https://images.unsplash.com/photo-1513245543132-31f507417b26?w=400', 'available'),
('大黑', '狗', '德牧', 4, '公', '聪明忠诚的德牧，训练有素，适合有经验的养狗人士。需要大量运动。', 'https://images.unsplash.com/photo-1583337130417-3346a1be7dee?w=400', 'available');

-- 插入联系人信息数据
INSERT INTO contact_person (name, phone, email, address) VALUES
('张三', '13800138001', 'zhangsan@example.com', '北京市朝阳区某某街道123号'),
('李四', '13800138002', 'lisi@example.com', '上海市浦东新区某某路456号'),
('王五', '13800138003', 'wangwu@example.com', '广州市天河区某某大道789号'),
('赵六', '13800138004', 'zhaoliu@example.com', '深圳市南山区某某街101号'),
('钱七', '13800138005', 'qianqi@example.com', '杭州市西湖区某某路202号'),
('孙八', '13800138006', 'sunba@example.com', '成都市锦江区某某街303号'),
('周九', '13800138007', 'zhoujiu@example.com', '武汉市武昌区某某路404号'),
('吴十', '13800138008', 'wushi@example.com', '南京市鼓楼区某某街505号'),
('郑一', '13800138009', 'zhengyi@example.com', '西安市雁塔区某某路606号'),
('王二', '13800138010', 'wanger@example.com', '重庆市渝中区某某街707号');

-- 插入领养申请数据
INSERT INTO adoption_application (pet_id, contact_id, application_date, status) VALUES
(9, 1, '2024-11-01 10:00:00', 'approved'),  -- 大毛已被张三领养
(10, 2, '2024-11-05 14:30:00', 'approved'), -- 小美已被李四领养
(11, 3, '2024-11-10 09:15:00', 'pending'),   -- 乐乐待审核
(12, 4, '2024-11-12 16:20:00', 'pending'),  -- 小灰待审核
(1, 5, '2024-11-15 11:00:00', 'pending'),   -- 小白待审核
(2, 6, '2024-11-18 13:45:00', 'pending'),   -- 小花待审核
(3, 7, '2024-11-20 10:30:00', 'rejected'),  -- 小黑申请被拒绝
(4, 8, '2024-11-22 15:00:00', 'pending');   -- 咪咪待审核

-- 查询验证数据
SELECT '宠物信息表记录数:' AS info, COUNT(*) AS count FROM pet_info
UNION ALL
SELECT '联系人信息表记录数:', COUNT(*) FROM contact_person
UNION ALL
SELECT '领养申请表记录数:', COUNT(*) FROM adoption_application;

-- 系统用户表（用于登录验证和权限控制）
CREATE TABLE `user` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `username` VARCHAR(50) UNIQUE NOT NULL,
  `password` VARCHAR(100) NOT NULL,
  `role` ENUM('user','admin') DEFAULT 'user',
  `status` ENUM('normal','disabled') DEFAULT 'normal'
);

-- 插入管理员测试数据（账号：admin，密码：123456）
INSERT INTO `user`(username,password,role,status) VALUES('admin','123456','admin','normal');

ALTER TABLE adoption_application ADD COLUMN adopt_motive TEXT;



