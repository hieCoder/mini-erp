insert into shteam2_db.accounting (id, created_date, spending, remain, bill, user_id, title, status)
values  ('111ec17d-3921-4bf7-8fcd-283d2fc8d0ec', '2023-07-27 14:14:46', 100000, 120000, null, '3', 'Buy Rice', 'ACTIVE'),
        ('1dcf16a4-60f7-4799-86ff-68e5827858c8', '2023-09-29 08:38:47', 10000, 170000, '230929083848-User Management Interface.xlsx', '3', 'Buy water', 'ACTIVE'),
        ('2a079692-66cd-4be0-88a6-04aa6bec23ee', '2023-09-28 14:14:34', 100000, 160000, null, '4', 'Buy Chair', 'ACTIVE'),
        ('32c79af6-5685-44bc-a0cb-9b18b4332fbe', '2023-09-29 08:40:40', -50000, 120000, '230929084040-User Management Interface.xlsx', '3', 'Buy water', 'ACTIVE'),
        ('4b90a870-5ffa-4ea1-a100-63215ce9a02e', '2023-07-27 14:14:43', 20000, 20000, '231002121630-Accounting Management Interface.xlsx', '4', 'Buy watermelon', 'ACTIVE'),
        ('85c51a98-4121-43eb-bff4-9e16c8d8bea0', '2023-09-30 13:09:54', -50000, 220000, '231002132744-Accounting Management Interface.xlsx', '5', 'Buy watermelon', 'ACTIVE'),
        ('af42f439-a45c-4516-ae65-093101883b57', '2023-10-02 16:05:48', 60000, 60000, '231002160555-Accounting Management Interface.xlsx,231002160555-User Management Interface.pptx,231002160555-User Management Interface.xlsx', '3', 'Buy food', 'ACTIVE'),
        ('bfef0edb-bec6-4e24-82b4-97af9bdfae2f', '2023-08-27 14:14:39', -50000, -50000, '231002133242-Accounting Management Interface.xlsx', '5', 'Buy watermelon', 'ACTIVE'),
        ('c9cc5663-8331-46dc-8130-5b17c8fffe2a', '2023-09-30 13:17:22', 150000, 520000, '230930131723-Accounting Management Interface.xlsx,230930131723-Employee Record Form - Vong Tuyen Lam.xls,230930131723-User Management Interface.xlsx', '4', 'Buy food', 'ACTIVE'),
        ('cc46561c-ced6-4766-84ee-ae7dbfc67328', '2023-09-30 13:16:33', 150000, 370000, '230930131635-Accounting Management Interface.xlsx,230930131635-Employee Record Form - Vong Tuyen Lam.xls,230930131635-User Management Interface.xlsx', '3', 'Buy food', 'ACTIVE'),
        ('d5526945-39fd-4be9-9217-19be08788a50', '2023-08-27 14:12:44', 30000, 30000, '231002144700-Accounting Management Interface.xlsx', '4', 'Buy watermelon', 'DISABLE'),
        ('d5526945-39fd-4be9-9217-19be08788a56', '2023-09-27 14:12:44', 60000, 60000, '231002150609-Accounting Management Interface.xlsx,231002150609-Employee Record Form - Vong Tuyen Lam.xls,231002150609-User Management Interface.pptx', '4', 'Buy watermelon', 'ACTIVE'),
        ('fe0008fb-93ac-4be3-9fd1-badc8e84a0cc', '2023-09-29 15:45:26', 150000, 270000, '230929154604-User Management Interface.pptx', '4', 'Buy food', 'ACTIVE');

insert into shteam2_db.comment_notification (id, content, created_date, notification_id, user_id, parent_id, modified_date, modified_by)
values
    ('34d70963-fed2-40bf-a858-1a46960d7a39', 'Nội dung D', '2023-10-02 17:41:29', '378ce1cb-d65c-4abf-add0-ec8f894d7801', '3', null, null, null),
    ('96b5f05d-5296-49ec-8cfd-098d51e2b27e', 'Nội dung A', '2023-10-02 11:01:40', '378ce1cb-d65c-4abf-add0-ec8f894d7801', '3', null, null, null),
    ('d4463067-6574-4fab-bda4-a5d880d4115f', 'Nội dung C', '2023-10-02 11:01:50', '378ce1cb-d65c-4abf-add0-ec8f894d7801', '3', null, null, null),
    ('0675c222-9684-4ef0-b8c4-ccb722c3f1ba', 'Nội dung DDDDD', '2023-10-02 17:41:47', '378ce1cb-d65c-4abf-add0-ec8f894d7801', '3', '34d70963-fed2-40bf-a858-1a46960d7a39', '2023-10-02 17:54:41', null),
        ('118a7f28-d217-453a-8c77-b5f857cba3f0', 'Nội dung A2', '2023-10-02 11:02:12', '378ce1cb-d65c-4abf-add0-ec8f894d7801', '3', '96b5f05d-5296-49ec-8cfd-098d51e2b27e', null, null),
        ('1e082e23-703f-460e-b296-497fcb14b236', 'Nội dung B2', '2023-10-02 11:02:26', '378ce1cb-d65c-4abf-add0-ec8f894d7801', '3', '547e003a-8f05-4e62-b884-922cf8bdaca0', null, null),
        ('547e003a-8f05-4e62-b884-922cf8bdaca0', 'Nội dung B-2', '2023-10-02 11:01:46', '378ce1cb-d65c-4abf-add0-ec8f894d7801', '3', null, '2023-10-02 16:40:36', null),
        ('5eacaf0c-3968-4451-8d04-ea51bcdb3622', 'Nội dung B1', '2023-10-02 11:02:30', '378ce1cb-d65c-4abf-add0-ec8f894d7801', '3', '547e003a-8f05-4e62-b884-922cf8bdaca0', null, null),
        ('aefc0c71-1c2b-43e9-8eb8-c8d15a4127ec', 'Nội dung A1', '2023-10-02 11:02:08', '378ce1cb-d65c-4abf-add0-ec8f894d7801', '3', '96b5f05d-5296-49ec-8cfd-098d51e2b27e', null, null),
        ('c7b3549e-4866-4763-9d94-1edc2734662b', 'Nội dung DDD', '2023-10-02 17:55:05', '378ce1cb-d65c-4abf-add0-ec8f894d7801', '3', '34d70963-fed2-40bf-a858-1a46960d7a39', null, null);

insert into shteam2_db.notification (id, title, content, file, created_date)
values  ('08567312-55a8-4e74-a829-f3db648cf9b5', 'aaaaaaaaaaaaa', 'aaaaaaaaaaaaaaaa', '230930131552-54674ee19af5f2c633acd48f5e7e2ca2.jpg,230930131552-749352274a62c15fc87d522b46a29822.jpg,230930131552-Cat03.jpg', '2023-09-30 15:15:34'),
        ('09873cb7-7d3b-4ecf-aede-975fc27b42cc', 'fffffffffffffff', 'fffffffffffffffffffffffffff', '230929180356-media_16ad2258cac6171d66942b13b8cd4839f0b6be6f3.png,230929180356-Roderigo · SlidesCarnival.pptx', '2023-09-29 20:03:39'),
        ('0fee9797-85f3-4b0b-b517-d40517ec50dd', 'aaaaaaaaaaaaa', 'aaaaaaaaaaaaaaaa', '230930081631-749352274a62c15fc87d522b46a29822.jpg', '2023-09-30 10:16:12'),
        ('378ce1cb-d65c-4abf-add0-ec8f894d7801', 'shsoftvina.com', '5464646464dtertet', 'hieuShsoftvina', '2023-09-28 15:14:46'),
        ('37ad0da8-997b-4b33-a22c-2280d58f1853', 'aaaaaaaaaaaaa', 'aaaaaaaaaaaaaaaa', '230930131452-749352274a62c15fc87d522b46a29822.jpg', '2023-09-30 15:14:34');

insert into shteam2_db.user (id, fullname, date_of_birth, phone, emergency_phone, avatar, type, department, atm, email, password, role, status, position, resume, address, is_first_update_profile, timesheets_code)
values  ('1', '', null, null, null, null, null, null, null, '1@gmail.com', '$2a$10$hWGR2TDU4tGzM/7mtPAX6uRmogPQOFTkysjb1NiVKDYogCKGLfga.', 'OWNER', 'ACTIVE', 'INTERN', null, null, null, null),
        ('3', 'Thằng Hiếu phá', '2001-03-02', '0366474', '123456789', 'avatar1', 'OFFICIAL', 'DEV2', '0302564654', 'hieu@gmail.com', '$2a$12$f6ld0R7LiYdJ6TwzjxLxT.QJ45febxzuZV1UbDg7TQUwPf.nRvTl2', 'OWNER', 'ACTIVE', 'INTERN', 'profile1', 'HCM', null, null),
        ('4', 'Thằng Hiếu phá thế', null, null, null, null, null, null, null, 'hieubao@gmail.com', '$2a$12$f6ld0R7LiYdJ6TwzjxLxT.QJ45febxzuZV1UbDg7TQUwPf.nRvTl2', 'MANAGER', 'ACTIVE', null, null, null, null, null),
        ('5', 'Trung Hieu', '1990-01-01', '039647433', '123456798', 'avartarHieu', 'OFFICIAL', 'DEV2', '123456798', 'hieu@example.com', '$2a$12$/A8gr45pnnOTlBNlxLf2M.41gh/9WDFZew8MDoWqBy.ti13GN3296', 'MANAGER', 'ACTIVE', 'INTERN', 'profile1', 'HCM', true, 'Mã timesheets'),
        ('b0e9aca9-393e-4be5-9e06-7f8e5d7f4ba9', 'hieu', '2000-01-02', '031325464', '132465798', 'avatar1', 'OFFICIAL', 'DEV2', '123456798', 'hieuahaha@gmail.com', '$2a$10$hWGR2TDU4tGzM/7mtPAX6uRmogPQOFTkysjb1NiVKDYogCKGLfga.', 'MANAGER', 'ACTIVE', 'INTERN', 'profile1', 'HCM', false, '132465');

