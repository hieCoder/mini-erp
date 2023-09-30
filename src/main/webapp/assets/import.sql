insert into shteam2_db.accounting (id, created_date, spending, remain, bill, user_id, title, status)
values  ('111ec17d-3921-4bf7-8fcd-283d2fc8d0ec', '2023-07-27 14:14:46', 100000, 200000, null, '1', 'Buy Rice', null),
        ('1dcf16a4-60f7-4799-86ff-68e5827858c8', '2023-09-29 08:38:47', 10000, 210000, '230929083848-User Management Interface.xlsx', '1', 'Buy water', null),
        ('2a079692-66cd-4be0-88a6-04aa6bec23ee

', '2023-09-28 14:14:34', 100000, 200000, null, '1', 'Buy Chair', null),
        ('32c79af6-5685-44bc-a0cb-9b18b4332fbe', '2023-09-29 08:40:40', -50000, 160000, '230929084040-User Management Interface.xlsx', '1', 'Buy water', null),
        ('4b90a870-5ffa-4ea1-a100-63215ce9a02e', '2023-07-27 14:14:43', 100000, 100000, '230930160635-Accounting Management Interface.xlsx', '1', 'Buy watermelon', null),
        ('85c51a98-4121-43eb-bff4-9e16c8d8bea0', '2023-09-30 13:09:54', 150000, 460000, '230930130955-Accounting Management Interface.xlsx,230930130955-Employee Record Form - Vong Tuyen Lam.xls,230930130955-User Management Interface.xlsx', '1', 'Buy food', null),
        ('bfef0edb-bec6-4e24-82b4-97af9bdfae2f', '2023-08-27 14:14:39', 100000, 0, null, '1', 'Buy Door', null),
        ('c9cc5663-8331-46dc-8130-5b17c8fffe2a', '2023-09-30 13:17:22', 150000, 760000, '230930131723-Accounting Management Interface.xlsx,230930131723-Employee Record Form - Vong Tuyen Lam.xls,230930131723-User Management Interface.xlsx', '1', 'Buy food', null),
        ('cc46561c-ced6-4766-84ee-ae7dbfc67328', '2023-09-30 13:16:33', 150000, 610000, '230930131635-Accounting Management Interface.xlsx,230930131635-Employee Record Form - Vong Tuyen Lam.xls,230930131635-User Management Interface.xlsx', '1', 'Buy food', null),
        ('d5526945-39fd-4be9-9217-19be08788a50

', '2023-08-27 14:12:44', -100000, -100000, null, '1', 'Buy Note', null),
        ('d5526945-39fd-4be9-9217-19be08788a56

', '2023-09-27 14:12:44', 100000, 100000, null, '1', 'Buy Desk', null),
        ('fe0008fb-93ac-4be3-9fd1-badc8e84a0cc', '2023-09-29 15:45:26', 150000, 310000, '230929154604-User Management Interface.pptx', '1', 'Buy food', null);


insert into shteam2_db.comment_notification (id, content, created_date, notification_id, user_id, parent_id, modified_date, modified_by)
values  ('19faedc9-2887-4298-859e-17bd1062bfba', 'Nội dung B', '2023-09-30 18:05:29', '378ce1cb-d65c-4abf-add0-ec8f894d7801', '00e7128b-dea1-4e0d-ac76-88af7db1f0be', '48fcb4e1-cbf6-41e5-82c8-11852a189555', null, null),
        ('48fcb4e1-cbf6-41e5-82c8-11852a189555', 'Nội dung A', '2023-09-30 18:05:15', '378ce1cb-d65c-4abf-add0-ec8f894d7801', '00e7128b-dea1-4e0d-ac76-88af7db1f0be', null, null, null),
        ('a01452a9-96bb-4706-9f62-948fe1551438', 'Nội dung C', '2023-09-30 18:17:56', '378ce1cb-d65c-4abf-add0-ec8f894d7801', '2', null, null, null),
        ('ebfd91f1-9b49-4b74-a7d9-737e77ed42af', 'Nội dung C', '2023-09-30 18:18:29', '378ce1cb-d65c-4abf-add0-ec8f894d7801', '2', '48fcb4e1-cbf6-41e5-82c8-11852a189555', null, null);

insert into shteam2_db.notification (id, title, content, file, created_date)
values  ('08567312-55a8-4e74-a829-f3db648cf9b5', 'aaaaaaaaaaaaa', 'aaaaaaaaaaaaaaaa', '230930131552-54674ee19af5f2c633acd48f5e7e2ca2.jpg,230930131552-749352274a62c15fc87d522b46a29822.jpg,230930131552-Cat03.jpg', '2023-09-30 15:15:34'),
        ('09873cb7-7d3b-4ecf-aede-975fc27b42cc', 'fffffffffffffff', 'fffffffffffffffffffffffffff', '230929180356-media_16ad2258cac6171d66942b13b8cd4839f0b6be6f3.png,230929180356-Roderigo · SlidesCarnival.pptx', '2023-09-29 20:03:39'),
        ('0fee9797-85f3-4b0b-b517-d40517ec50dd', 'aaaaaaaaaaaaa', 'aaaaaaaaaaaaaaaa', '230930081631-749352274a62c15fc87d522b46a29822.jpg', '2023-09-30 10:16:12'),
        ('378ce1cb-d65c-4abf-add0-ec8f894d7801', 'shsoftvina.com', '5464646464dtertet', 'hieuShsoftvina', '2023-09-28 15:14:46'),
        ('37ad0da8-997b-4b33-a22c-2280d58f1853', 'aaaaaaaaaaaaa', 'aaaaaaaaaaaaaaaa', '230930131452-749352274a62c15fc87d522b46a29822.jpg', '2023-09-30 15:14:34');

