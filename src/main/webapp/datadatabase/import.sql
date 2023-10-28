insert into shteam2_db.USER (ID, FULLNAME, DATE_OF_BIRTH, PHONE, EMERGENCY_PHONE, AVATAR, TYPE, DEPARTMENT, ATM, EMAIL, PASSWORD, ROLE, STATUS, POSITION, RESUME, ADDRESS, IS_FIRST_UPDATE_PROFILE, TIMESHEETS_CODE)
values  ('1', 'canh', '2023-10-17', '1234567890', '1234567890', '1.jpg', 'OFFICIAL', 'ADMINISTRATION', 'ATM', 'canh@gmail.com', '$2a$12$aJnAhkNHyVeFGkx6e5jDNui/g95VLQ/FVnf.ySZtAT9Kig9pR6D/2', 'DEVELOPER', 'ACTIVE', 'INTERN', null, 'Quận 10 HCM', true, ''),
        ('100', 'hieu', '2000-01-02', '031325464', '132465798', null, 'OFFICIAL', 'DEV2', '123456798', 'hieu@gmail.com', '$2a$12$fu3qYldcIpqc6zvssy5vxe7DVyv7RPxh0lkmDZ7DCtbb5hQp7EUHe', 'OWNER', 'ACTIVE', 'INTERN', null, null, true, null),
        ('185b3fe3-9542-483f-80c4-77304f0e5abf', 'thinh2', null, null, null, null, null, null, null, 'thinh2@gmail.com', '$2a$10$RgcxFVwzpZ0j0Y1mHyLbUOmF2eq9tFsll7k1xbJL2IbP6E3tx8GQW', null, 'PENDING', null, null, null, null, null),
        ('2', 'TrungHieu', '2000-03-02', '999999', '20202', '231003123245-Cat03.jpg', 'OFFICIAL', 'DEV2', '12123', '1@gmail.com', '$2a$12$T3ZmWXzjWW39kFHyfFohbeEHvm71vohXjyIKs3DVQER3hEEJTr2Fe', 'OWNER', 'ACTIVE', 'INTERN', '231003123245-sample.pdf', 'adress2', true, '1'),
        ('3', 'TrungHieu99999', null, '11111', null, '231003123245-Cat03.jpg', 'OFFICIAL', 'DEV2', null, null, null, 'DEVELOPER', 'ACTIVE', 'INTERN', '231003170723-sample.pdf', null, true, null),
        ('3cdf6ada-7e35-453b-9d63-cb07f53430c4', 'thinh1', '2023-10-16', '809808', '78979', 'avartarHieu', null, null, null, 'thinh1@gmail.com', '$2a$10$dMAZ9G9KMjuNnN37p3ll4eLI5R1qhEynyan49xuOGWoye09lrcFWW', 'MANAGER', 'ACTIVE', null, null, null, true, null),
        ('4', 'Thằng Hiếu phá thế', null, null, null, null, null, null, null, 'hieubao@gmail.com', '$2a$12$f6ld0R7LiYdJ6TwzjxLxT.QJ45febxzuZV1UbDg7TQUwPf.nRvTl2', 'MANAGER', 'ACTIVE', null, null, null, null, null),
        ('5', 'Trung Hieu', '1990-01-01', '039647433', '123456798', 'avartarHieu', 'OFFICIAL', 'DEV2', '123456798', 'hieu@example.com', '$2a$12$/A8gr45pnnOTlBNlxLf2M.41gh/9WDFZew8MDoWqBy.ti13GN3296', 'MANAGER', 'ACTIVE', 'INTERN', 'profile1', 'HCM', true, 'Mã timesheets'),
        ('961c8858-a43c-4cab-b878-6dba81c8c291', 'thinh', '2023-10-16', '555555', '55555555', 'avartarHieu', 'OFFICIAL', 'DEV2', '12354545', 'thinh@gmail.com', '$2a$10$SbyvoJF58hDfZluuHWY6hupJ5dShNfTcxMK/yI.ZRzFyiqLfQKpou', 'MANAGER', 'ACTIVE', 'INTERN', 'profile1', 'HCM', true, '1111111'),
        ('b0e9aca9-393e-4be5-9e06-7f8e5d7f4ba9', 'hieu', '2000-01-02', '031325464', '132465798', 'avatar1', 'OFFICIAL', 'DEV2', '123456798', 'hieuahaha@gmail.com', '$2a$10$hWGR2TDU4tGzM/7mtPAX6uRmogPQOFTkysjb1NiVKDYogCKGLfga.', 'MANAGER', 'ACTIVE', 'INTERN', 'profile1', 'HCM', false, '132465'),
        ('cdcd7b02-a995-48ad-894d-4557aa675c26', 'canh2@gmail.com', null, null, null, null, null, null, null, 'n18dccn107@student.ptithcm.edu.vn', '$2a$10$sKfNweDjBKk0EQIucutXv.x0siMg4GFD3PymhbSHuMbjUnttnvMKS', null, 'PENDING', null, null, null, null, null);

insert into shteam2_db.ACCOUNTING (ID, CREATED_DATE, SPENDING, REMAIN, BILL, USER_ID, TITLE, STATUS, NOTE)
values  ('0aa291bc-1e67-4df8-b83d-158e159de09e', '2023-10-13 14:45:51', -4254, -389123, '231013144551-휴가 신청서_VONG_TUYEN_LAM.xlsx', '3', 'test', 'ACTIVE', 'abcxyz'),
        ('111ec17d-3921-4bf7-8fcd-283d2fc8d0ec', '2023-07-27 14:14:46', 100000, 120000, null, '3', 'Buy Rice', 'ACTIVE', 'abcxyz'),
        ('13c96bfa-416b-4916-aaf2-c8f75fae2ee9', '2023-10-16 13:04:31', 150000, -738798, '231016130513-Employee Record Form - Vọng Tuyền Lấm hỏi ngã.xls', '3', 'buy bye', 'DISABLE', 'abcxyz'),
        ('1dcf16a4-60f7-4799-86ff-68e5827858c8', '2023-09-29 08:38:47', 10000, 170000, '230929083848-User Management Interface.xlsx', '3', 'Buy water', 'ACTIVE', 'abcxyz'),
        ('2a079692-66cd-4be0-88a6-04aa6bec23ee', '2023-09-28 14:14:34', 100000, 160000, null, '4', 'Buy Chair', 'ACTIVE', 'abcxyz'),
        ('2ad75175-42bd-4dd9-9d87-d430081f4123', '2023-10-12 11:43:06', 10000, 46602991, null, '3', 'dfgjhdfj', 'DISABLE', 'abcxyz'),
        ('32c79af6-5685-44bc-a0cb-9b18b4332fbe', '2023-09-29 08:40:40', -50000, 120000, '230929084040-User Management Interface.xlsx', '3', 'Buy water', 'ACTIVE', 'abcxyz'),
        ('368af6e2-6b90-4751-a242-2cc66b4ce94c', '2023-10-13 14:23:12', 24532, -411557, '231013142313-IC-WBS-With-Gantt-Chart-Template-8721.xlsx', '3', 'hieuhieu', 'ACTIVE', 'abcxyz'),
        ('37e298d3-0343-422b-9fad-add2bd3a7b82', '2023-10-12 10:42:36', -161653, 13347, '231012104237-Employee Record Form - Vong Tuyen Lam.xls,231012104237-IC-WBS-With-Gantt-Chart-Template-8721.xlsx', '2', 'iglglghl', 'ACTIVE', 'abcxyz'),
        ('3bae3f5c-c791-4c71-ab6b-d0f75d35c960', '2023-10-13 14:23:55', 2444, -409113, '231013142356-Employee Record Form - Vong Tuyen Lam.xls', '3', 'vkfkf', 'ACTIVE', null),
        ('4b90a870-5ffa-4ea1-a100-63215ce9a02e', '2023-07-27 14:14:43', 20000, 20000, '231002121630-Accounting Management Interface.xlsx', '4', 'Buy watermelon', 'ACTIVE', null),
        ('5de7944f-2c14-4517-815b-8a0c953f540a', '2023-10-13 15:08:09', -5241, -390929, null, '3', 'aaaa', 'ACTIVE', 'abcxyz'),
        ('6fd1922a-e91e-41a9-879e-2f6e678ebba1', '2023-10-04 09:05:24', 50000, 175000, '231017115746-Accounting Management Interface.xlsx,231017115746-Employee Record Form - Vọng Tuyền Lấm hỏi ngã.xls', '2', 'Buy food', 'ACTIVE', 'abc'),
        ('7633a140-6c21-4b1f-90ec-c2117d15ca4d', '2023-10-16 14:31:11', 150000, -738798, null, '2', '145634', 'ACTIVE', ''),
        ('7a670c16-4bb9-494a-9fa9-fdc3b05e3252', '2023-10-16 14:39:39', -30000, -768798, '231016145204-Accounting Management Interface.xlsx,231016145204-Employee Record Form - Vọng Tuyền Lấm hỏi ngã.xls,231016145204-IC-WBS-With-Gantt-Chart-Template-8721.xlsx', '2', 'hieuuuu', 'ACTIVE', 'trả tiền cho ttttt'),
        ('85c51a98-4121-43eb-bff4-9e16c8d8bea0', '2023-09-30 13:09:54', -50000, 220000, '231002132744-Accounting Management Interface.xlsx', '5', 'Buy watermelon', 'ACTIVE', 'abcxyz'),
        ('86a0c2bd-eb14-4161-b487-12272b9dfe2b', '2023-10-13 11:39:35', 564, -386089, '231017115957-Accounting Management Interface.xlsx', '2', '1+1', 'ACTIVE', '123'),
        ('8807a223-9b47-4b8a-a833-007adbfea2b4', '2023-10-13 14:52:26', 3435, -385688, null, '3', 'sdfgsdg', 'ACTIVE', 'abcxyz'),
        ('af42f439-a45c-4516-ae65-093101883b57', '2023-10-02 16:05:48', 65000, 65000, '231013164433-휴가 신청서_VONG_TUYEN_LAM.xlsx', '3', 'Buy food', 'ACTIVE', null),
        ('b2ca856c-c227-4c8a-8fa8-9739f552ef2f', '2023-10-16 09:24:13', -500000, -888798, '231016092414-IC-WBS-With-Gantt-Chart-Template-8721.xlsx,231016092414-User Management Interface.xlsx', '3', 'buy cat', 'ACTIVE', 'abcxyz'),
        ('b86a0c69-3e73-4481-aa68-a063b86b1828', '2023-10-13 14:00:44', -50000, -436089, '231013140045-Accounting Management Interface.xlsx', '3', 'Hieu', 'ACTIVE', null),
        ('b8dfca81-325e-4500-80d5-55f6ec526fbd', '2023-10-13 15:36:55', 2131, -388798, '231013154457-휴가 신청서_VONG_TUYEN_LAM.xlsx', '3', 'mumummu', 'ACTIVE', 'abcxyz'),
        ('bfef0edb-bec6-4e24-82b4-97af9bdfae2f', '2023-08-27 14:14:39', -50000, -50000, '231002133242-Accounting Management Interface.xlsx', '5', 'Buy watermelon', 'ACTIVE', null),
        ('c0b064aa-4ef9-4889-af58-f614fb374158', '2023-10-03 10:00:25', 60000, 125000, '231016174402-Accounting Management Interface.xlsx', '2', 'Buy food', 'ACTIVE', 'abcxyz'),
        ('c9cc5663-8331-46dc-8130-5b17c8fffe2a', '2023-09-30 13:17:22', 150000, 520000, '230930131723-Accounting Management Interface.xlsx,230930131723-Employee Record Form - Vong Tuyen Lam.xls,230930131723-User Management Interface.xlsx', '4', 'Buy food', 'ACTIVE', null),
        ('cc46561c-ced6-4766-84ee-ae7dbfc67328', '2023-09-30 13:16:33', 150000, 370000, '230930131635-Accounting Management Interface.xlsx,230930131635-Employee Record Form - Vong Tuyen Lam.xls,230930131635-User Management Interface.xlsx', '3', 'Buy food', 'ACTIVE', 'abcxyz'),
        ('d5526945-39fd-4be9-9217-19be08788a50', '2023-08-27 14:12:44', 30000, 30000, '231002144700-Accounting Management Interface.xlsx', '4', 'Buy watermelon', 'DISABLE', null),
        ('d5526945-39fd-4be9-9217-19be08788a56', '2023-09-27 14:12:44', 60000, 60000, '231002150609-Accounting Management Interface.xlsx,231002150609-Employee Record Form - Vong Tuyen Lam.xls,231002150609-User Management Interface.pptx', '4', 'Buy watermelon', 'ACTIVE', 'abcxyz'),
        ('d99faa5c-38b4-4f49-8d68-87c6d574cf31', '2023-10-13 14:42:51', 24244, -384869, '231016075730-Employee Record Form - Vọng Tuyền Lấm hỏi ngã.xls', '3', 'hello', 'ACTIVE', null),
        ('f2cd01c3-7332-4db8-b8a9-1a6ef048aa86', '2023-10-03 09:50:55', 60000, 120000, '231003095056-Accounting Management Interface.xlsx,231003095056-User Management Interface.pptx,231003095056-User Management Interface.xlsx', '3', 'Buy food', 'DISABLE', 'abcxyz'),
        ('f4956a3d-2d71-42fb-85fe-0512eed1f02e', '2023-10-12 13:07:24', -400000, -386653, '231017115838-Accounting Management Interface.xlsx,231017115838-Employee Record Form - Vọng Tuyền Lấm hỏi ngã.xls', '2', 'fdsafash5678', 'ACTIVE', 'alo'),
        ('fa1f91a8-eb22-4c6e-9491-d92f53f07bc5', '2023-10-12 11:14:36', 46584644, 46597991, '231012111437-Accounting Management Interface.xlsx,231012111437-Employee Record Form - Vong Tuyen Lam.xls,231012111437-IC-WBS-With-Gantt-Chart-Template-8721.xlsx', '3', 'fjfghjgj', 'DISABLE', 'abcxyz'),
        ('fe0008fb-93ac-4be3-9fd1-badc8e84a0c5', '2022-09-29 15:45:26', 50000, 50000, null, '2', 'Buy headphone', 'ACTIVE', null),
        ('fe0008fb-93ac-4be3-9fd1-badc8e84a0cc', '2023-09-29 15:45:26', 150000, 270000, '230929154604-User Management Interface.pptx', '4', 'Buy food', 'ACTIVE', 'abcxyz');

insert into shteam2_db.NOTIFICATION (ID, TITLE, CONTENT, FILES, CREATED_DATE, USER_ID)
values  ('5e42d479-df2a-4941-a525-35128b2c1844', 'áda', 'ád', '', '2023-10-17 11:28:51', '961c8858-a43c-4cab-b878-6dba81c8c291'),
        ('624c1388-6242-4f27-b26e-ec78bc8b9ddb', 'sdfs', 'fsdfsdfsdf', null, '2023-10-17 11:39:09', '961c8858-a43c-4cab-b878-6dba81c8c291'),
        ('825000b5-24f7-4ebe-bd4f-b81f0084ca11', '22', '22s', '231017120540-tét - Copy (2) - Copy.pptx,231017120557-tét - Copy (2) - Copy.pptx', '2023-10-17 12:04:10', '961c8858-a43c-4cab-b878-6dba81c8c291'),
        ('a9f1b8a0-292e-4cfa-82d7-9d74fe0ab028', '12', '12', '231017120359-tét - Copy (2) - Copy.pptx', '2023-10-17 12:03:59', '961c8858-a43c-4cab-b878-6dba81c8c291'),
        ('aefe832f-08c4-434b-ba93-d3fbe75a5f0b', '3424we', 'ưerwerwerewr', '231017081646-tét.pptx', '2023-10-17 08:16:47', '961c8858-a43c-4cab-b878-6dba81c8c291');

insert into shteam2_db.SETTING (ID, CODE, IMAGE_TYPE, FILE_TYPE, FILE_SIZE)
values  ('1', 'USER', 'jpg,jpeg,png,svg', 'pdf,csv,xlsx,doc,xls,pptx', 3),
        ('2', 'CONTRACT', 'jpg,jpeg,png,svg', 'pdf,csv,xlsx,doc,xls,pptx', 3),
        ('3', 'ACCOUNTING', 'jpg,jpeg,png,svg', 'pdf,csv,xlsx,doc,xls,pptx', 3),
        ('4', 'NOTIFICAITON', 'jpg,jpeg,png,svg', 'pdf,csv,xlsx,doc,xls,pptx', 4),
        ('5', 'NOTIFICAITON_COMMENT', 'jpg,jpeg,png,svg', 'pdf,csv,xlsx,doc,xls,pptx', 3),
        ('6', 'TASK', 'jpg,jpeg,png,svg', 'pdf,csv,xlsx,doc,xls,pptx', 3),
        ('7', 'TASK_COMMENT', 'jpg,jpeg,png,svg', 'pdf,csv,xlsx,doc,xls,pptx', 3);

insert into shteam2_db.TASK (ID, STATUS_TASK, TITLE, USER_ID, CREATED_DATE, START_DATE, CLOSE_DATE, PRIORITY, PROGRESS, STATUS, CONTENT, DUE_DATE)
values  ('152b6ad4-3d51-484e-833c-b6884d66cd1e', 'REGISTERED', 'Update sort by user', '2', '2023-10-10', '2023-10-11', '2023-10-13', 'LOW', '0', 'ACTIVE', 'Create schedule view', '2023-10-14'),
        ('1c0d9796-3091-4b05-98a9-0a6011e59716', 'OPENED', '65516521', '961c8858-a43c-4cab-b878-6dba81c8c291', '2023-10-17', '2023-10-09', '2023-10-17', 'LOW', '10', 'ACTIVE', '<p>3213</p>', '2023-10-26'),
        ('6a26ee72-9c50-43f4-8d15-f9b80fe90b94', 'REOPENED', 'Fix login view', '2', '2023-10-10', '2023-10-11', '2023-10-13', 'LOW', '70', 'ACTIVE', 'Create schedule view', '2023-10-14'),
        ('7a4a7158-2055-47a2-b7de-23c6a2b361e0', 'CLOSED', 'Login feature', '2', '2023-10-10', '2023-10-11', '2023-10-13', 'MEDIUM', '40', 'ACTIVE', 'Create schedule view', '2023-10-14'),
        ('7aa1244c-4da8-461c-9676-3befd8660cb7', 'OPENED', 'Create schedule view', '2', '2023-10-10', '2023-10-11', '2023-10-13', 'MEDIUM', '30', 'ACTIVE', 'Create schedule view', '2023-10-14'),
        ('bb41ad96-9e86-4299-b700-f2d8b98ac4d9', 'CLOSED', '1', '1', '2023-10-17', '2023-10-17', '2023-10-17', 'LOW', '100', 'ACTIVE', '<p>1</p>', '2023-10-17'),
        ('c6f0ec1b-e965-4447-91e4-607479753a6d', 'POSTPONED', 'Accounting feature', '2', '2022-10-02', '2022-10-03', '2022-10-06', 'HIGH', '50', 'ACTIVE', 'Create schedule view', '2022-10-09'),
        ('c6f0ec1b-e965-4447-91e4-607479753af8', 'POSTPONED', 'Register feature', '2', '2023-10-10', '2023-10-11', '2023-10-13', 'HIGH', '50', 'ACTIVE', 'Create schedule view', '2023-10-14'),
        ('cd6c7449-d369-4248-99c9-c6aeabbac017', 'OPENED', '123', '1', '2023-10-17', '2023-10-17', null, 'MEDIUM', '0', 'ACTIVE', '<p>123</p>', '2023-10-17');

insert into shteam2_db.TIMESHEETS (ID, WORK_DATE, CHECKIN, CHECKOUT, OT, USER_ID)
values  ('1', '2022-09-18', '07:23:20', '17:20:22', false, '2'),
        ('2', '2022-09-19', '07:19:10', '19:12:23', true, '2'),
        ('3', '2023-09-18', '07:30:12', '17:22:12', false, '2'),
        ('4', '2023-11-19', '07:19:10', '19:12:23', true, '2');

insert into shteam2_db.WEEKLY_REPORT (ID, TITLE, CONTENT, CREATED_DATE, USER_ID)
values  ('0e1c1db8-3300-439f-aae3-a8b1cebd3e89', 'canh', '<div id="contentContainer" contenteditable="true" class="form-control mention-container " style="height: 58px;">canh #<!-- Content will be edited here --><a href="/tasks/cd6c7449-d369-4248-99c9-c6aeabbac017">123</a> <br><span>canh #</span><a href="/tasks/bb41ad96-9e86-4299-b700-f2d8b98ac4d9">1</a> </div>', '2023-10-17 15:54:46', '1'),
        ('1033394b-7952-4783-b2d3-a315caa0aee2', 'aaa', '<div id="contentContainer" contenteditable="true" class="form-control mention-container ">aaaaa<!-- Content will be edited here --></div>', '2023-10-17 15:55:11', '1'),
        ('160e8b71-98d4-4ca5-813b-505cbdba7123', 'hieu', '<div id="contentContainer" contenteditable="true" class="form-control mention-container ">hieu #<!-- Content will be edited here --><a href="/tasks/bb41ad96-9e86-4299-b700-f2d8b98ac4d9">1</a> </div>', '2023-10-17 16:06:45', '1'),
        ('39b4c8fa-eb08-48cd-8782-b683251196cb', 'hieu', '<div id="contentContainer" contenteditable="true" class="form-control mention-container ">hieu<!-- Content will be edited here --></div>', '2023-10-17 15:43:33', '100'),
        ('3de992fe-9f6e-4e06-9699-145c3644a125', 'trunghieu', '<div id="contentContainer" contenteditable="true" class="form-control mention-container ">trung hieu<!-- Content will be edited here --></div>', '2023-10-17 16:07:24', '1'),
        ('640f3108-8135-4564-aa21-9ee83965efb8', 'trunghieu1', '<div id="contentContainer" contenteditable="true" class="form-control mention-container ">hello #<!-- Content will be edited here --><a href="/tasks/cd6c7449-d369-4248-99c9-c6aeabbac017">123</a> </div>', '2023-10-17 14:13:08', '1'),
        ('6da438f1-3a50-4d85-ac07-4d62c23e21cf', 'thinh dep trai', '<div id="contentContainer" contenteditable="true" class="form-control mention-container ">
                                <!-- Content will be edited here -->

                            </div>', '2023-10-17 16:03:49', '1'),
        ('71356cf0-1515-4460-99ec-47f18e38d29f', 'aaaaa', '<div id="contentContainer" contenteditable="true" class="form-control mention-container ">aaaaa<!-- Content will be edited here --></div>', '2023-10-17 16:12:35', '1'),
        ('818c1b57-a195-4198-9b8c-ea14ac17628e', 'canh1', '<div id="contentContainer" contenteditable="true" class="form-control mention-container ">canh1<!-- Content will be edited here --></div>', '2023-10-17 16:08:36', '1'),
        ('8403aab4-7d16-462d-bece-3af075202e66', 'aaa', '<div id="contentContainer" contenteditable="true" class="form-control mention-container " style="height: 58px;">conchimnon #<!-- Content will be edited here --><a href="/tasks/bb41ad96-9e86-4299-b700-f2d8b98ac4d9">1</a>&nbsp;hieu #<a href="/tasks/cd6c7449-d369-4248-99c9-c6aeabbac017">123</a> <br><span>conchimnon #</span><a href="/tasks/cd6c7449-d369-4248-99c9-c6aeabbac017">123</a> </div>', '2023-10-17 15:53:46', '1'),
        ('86973470-ebcc-4ffd-b45f-fbfbbdf7bddf', 'aa', '<div id="contentContainer" contenteditable="true" class="form-control mention-container ">aaa<!-- Content will be edited here --></div>', '2023-10-17 15:40:14', '1'),
        ('aad603c5-fbe6-4cad-89d0-29773776d77f', 'aaa', '<div id="contentContainer" contenteditable="true" class="form-control mention-container " style="height: 82px;">#
                                <!-- Content will be edited here -->

                            <a href="/tasks/cd6c7449-d369-4248-99c9-c6aeabbac017">123</a> <br><span>#</span><a href="/tasks/bb41ad96-9e86-4299-b700-f2d8b98ac4d9">1</a> <br><span>hihi #</span><a href="/tasks/bb41ad96-9e86-4299-b700-f2d8b98ac4d9">1</a> </div>', '2023-10-17 15:12:35', '1'),
        ('acc82ec2-0907-427f-a358-2c086f82fcd5', 'heiu', '<div id="contentContainer" contenteditable="true" class="form-control mention-container ">hieu #<!-- Content will be edited here --><a href="/tasks/cd6c7449-d369-4248-99c9-c6aeabbac017">123</a> </div>', '2023-10-17 15:38:26', '1'),
        ('ae68b052-da3d-47d8-8371-f40451e99606', 'tasdas', '<div id="contentContainer" contenteditable="true" class="form-control mention-container ">
                                <!-- Content will be edited here -->

                            </div>', '2023-10-17 16:03:58', '1');


insert into shteam2_db.COMMENT_NOTIFICATION (ID, CONTENT, CREATED_DATE, NOTIFICATION_ID, USER_ID, PARENT_ID, MODIFIED_DATE, MODIFIED_BY)
values  ('0961b937-c098-466d-988f-f2c0a778827d', 'hello mother fucker', '2023-10-17 14:14:20', '825000b5-24f7-4ebe-bd4f-b81f0084ca11', '1', null, null, null),
        ('097311b7-c9e9-472a-b14a-281383df13f0', 'rtyryry', '2023-10-17 08:50:49', 'aefe832f-08c4-434b-ba93-d3fbe75a5f0b', '961c8858-a43c-4cab-b878-6dba81c8c291', 'dc2388c4-3e25-489e-b296-32ebcf43c800', null, null),
        ('12143e59-31bb-4107-8364-45a3e532c793', 'rtyrtyryr', '2023-10-17 08:52:21', 'aefe832f-08c4-434b-ba93-d3fbe75a5f0b', '3cdf6ada-7e35-453b-9d63-cb07f53430c4', null, null, null),
        ('16fb6823-0a08-40e5-b8ad-87da9e0d0332', 'ádad', '2023-10-17 08:48:06', 'aefe832f-08c4-434b-ba93-d3fbe75a5f0b', '961c8858-a43c-4cab-b878-6dba81c8c291', 'dc2388c4-3e25-489e-b296-32ebcf43c800', null, null),
        ('174843f2-a2df-42ff-843a-6c10de23842f', '5675', '2023-10-17 09:38:50', 'aefe832f-08c4-434b-ba93-d3fbe75a5f0b', '961c8858-a43c-4cab-b878-6dba81c8c291', 'f1aa448e-1ee5-47c8-aa71-b416ed9d4231', null, null),
        ('2ef95cbb-c664-4d9c-9b3a-dc336b170bda', 'dsa', '2023-10-17 14:31:16', '825000b5-24f7-4ebe-bd4f-b81f0084ca11', '100', '0961b937-c098-466d-988f-f2c0a778827d', null, null),
        ('5780f7d8-abba-4106-ac73-452211a08923', 'ádasdd23424324', '2023-10-17 09:29:30', 'aefe832f-08c4-434b-ba93-d3fbe75a5f0b', '961c8858-a43c-4cab-b878-6dba81c8c291', 'c7a0d1a0-af2c-40b4-a0d9-3fd23191417f', '2023-10-17 11:29:19', 'thinh'),
        ('5a632027-d9fc-4c3f-9821-d2ca6c792305', 'rtyryry', '2023-10-17 08:52:36', 'aefe832f-08c4-434b-ba93-d3fbe75a5f0b', '961c8858-a43c-4cab-b878-6dba81c8c291', null, null, null),
        ('925cfd84-7941-41f3-8243-9ad9f4bc7a86', 'ádad', '2023-10-17 08:42:55', 'aefe832f-08c4-434b-ba93-d3fbe75a5f0b', '961c8858-a43c-4cab-b878-6dba81c8c291', 'dc2388c4-3e25-489e-b296-32ebcf43c800', null, null),
        ('c7a0d1a0-af2c-40b4-a0d9-3fd23191417f', 'uyutu757567adasdadad', '2023-10-17 08:53:17', 'aefe832f-08c4-434b-ba93-d3fbe75a5f0b', '961c8858-a43c-4cab-b878-6dba81c8c291', null, '2023-10-17 11:28:58', 'thinh'),
        ('d20f1cae-9c56-4c16-b569-ac79a3082b06', 'hello father fucker
', '2023-10-17 14:15:33', '825000b5-24f7-4ebe-bd4f-b81f0084ca11', '100', null, null, null),
        ('dc2388c4-3e25-489e-b296-32ebcf43c800', 'ỳiyiyi', '2023-10-17 08:28:36', 'aefe832f-08c4-434b-ba93-d3fbe75a5f0b', '3cdf6ada-7e35-453b-9d63-cb07f53430c4', null, null, null),
        ('f1aa448e-1ee5-47c8-aa71-b416ed9d4231', '', '2023-10-17 09:34:06', 'aefe832f-08c4-434b-ba93-d3fbe75a5f0b', '961c8858-a43c-4cab-b878-6dba81c8c291', null, null, null);

insert into shteam2_db.COMMENT_TASK (ID, CONTENT, FILES, CREATED_DATE, TASK_ID, USER_ID, PARENT_ID, MODIFIED_DATE, MODIFIED_BY, TITLE)
values  ('8e1381a8-c13e-400e-81e3-a8ae69e552c9', '<p>789879</p>', null, '2023-10-16 11:19:02', '152b6ad4-3d51-484e-833c-b6884d66cd1e', '2', null, null, null, '978978'),
        ('9154eee0-4516-4f92-b18b-02467c6f0028', '<p>ept</p>', null, '2023-10-16 11:18:43', '152b6ad4-3d51-484e-833c-b6884d66cd1e', '2', null, null, null, 'lamd'),
        ('c237d2e3-1559-4db2-9e6c-1922f23c55c4', '<p>11123</p>', '231016125228-BÁO CÁO TUẦN 231014l.xlsx', '2023-10-16 14:52:02', '152b6ad4-3d51-484e-833c-b6884d66cd1e', '2', null, null, null, '11'),
        ('c35011aa-dbc7-436c-a272-e57e02259adb', '<p>1</p>', '231016125157-a.xlsx', '2023-10-16 14:51:31', '152b6ad4-3d51-484e-833c-b6884d66cd1e', '2', null, null, null, '1');

insert into shteam2_db.CONTRACT (ID, BASIC_SALARY, ALLOWANCE, CONTRACT, CREATED_DATE, USER_ID, STATUS, INSURANCE_TYPE, INSURANCE_MONEY)
values  ('5b5c8dc1-353d-424a-aabb-3110d822d67c', '123', '123', '231017131520-aaa.pdf', '2023-10-17', '3', 'ACTIVE', 'HEALTH_INSURANCE', '12312'),
        ('71e9c627-9102-411a-b63f-4c02b2c750e7', '3', '3', null, '2023-10-17', '1', 'INACTIVE', 'HEALTH_INSURANCE', '3'),
        ('83d32b46-c9bb-4210-aa11-8ee346f958e2', '22', '22', null, '2023-10-17', '1', 'INACTIVE', 'HEALTH_INSURANCE', '33'),
        ('9d8d4bd4-4c29-48b1-91fd-80d721b5ee5c', '4', '4', null, '2023-10-17', '1', 'INACTIVE', 'HEALTH_INSURANCE', '4');

insert into shteam2_db.MANAGEMENT_TIME_DAY (ID, ONE_THING_CALENDAR, TO_DO_LIST, GRATITUDE_DIARY, AFFIRMATION, DAY, USER_ID)
values  ('1581aa3f-672c-4295-9564-09ecda9cb03c', '{"theSingleMostImportantThing":null,"lecture":null,"dailyEvaluation":null,"work":null,"reading":null}', '{"sixToTwelvePm":[],"twelveToSixPm":[],"sixToTwelveAm":[]}', '[]', '', '2021-11-23', '961c8858-a43c-4cab-b878-6dba81c8c291'),
        ('52b61868-e78f-4dbf-a418-0f67d1ab6bc6', '{"theSingleMostImportantThing":null,"lecture":null,"dailyEvaluation":null,"work":null,"reading":null}', '{"sixToTwelvePm":[],"twelveToSixPm":[],"sixToTwelveAm":[]}', '[]', '', '2023-10-18', '961c8858-a43c-4cab-b878-6dba81c8c291'),
        ('582e1379-0f25-472f-bbb7-39977a32c732', '{"theSingleMostImportantThing":{"target":"11","performance":false},"lecture":{"target":"Lecture 2","performance":false},"dailyEvaluation":{"target":"Gratitude diary, daily evaluation","performance":false},"work":{"target":"Analyzing","performance":false},"reading":{"target":"Reading 10 pages","performance":false}}', '{"sixToTwelvePm":[{"target":"21","performance":false},{"target":"22","performance":false},{"target":"323","performance":false},{"target":"12313","performance":false}],"twelveToSixPm":[{"target":"34534","performance":false},{"target":"3453","performance":false},{"target":"34534","performance":false},{"target":"34534","performance":false}],"sixToTwelveAm":[{"target":"12q","performance":false},{"target":"q2","performance":false},{"target":"2e","performance":false},{"target":"ft6","performance":false}]}', '["1","2","3"]', '1212221213', '2023-10-20', '1'),
        ('667a289a-dc00-4c7f-9b37-ae2b16661f80', '{"theSingleMostImportantThing":null,"lecture":null,"dailyEvaluation":null,"work":null,"reading":null}', '{"sixToTwelvePm":[],"twelveToSixPm":[],"sixToTwelveAm":[]}', '[]', '', '2020-10-23', '961c8858-a43c-4cab-b878-6dba81c8c291'),
        ('97cb6bd0-296a-46f3-ab6c-13a4278b8b7a', '{"theSingleMostImportantThing":{"target":"rtre","performance":false},"lecture":null,"dailyEvaluation":null,"work":null,"reading":null}', '{"sixToTwelvePm":[{"target":"tẻ","performance":false},{"target":"tểtr","performance":false}],"twelveToSixPm":[],"sixToTwelveAm":[]}', '[]', '', '2023-10-23', '961c8858-a43c-4cab-b878-6dba81c8c291'),
        ('ac867ca3-ad8a-4733-9c24-a4fe17166f3b', '{"theSingleMostImportantThing":null,"lecture":null,"dailyEvaluation":null,"work":null,"reading":null}', '{"sixToTwelvePm":[],"twelveToSixPm":[],"sixToTwelveAm":[]}', '[]', '', '2023-10-18', '961c8858-a43c-4cab-b878-6dba81c8c291'),
        ('d61ef8fa-65ad-4ef1-897f-8292f05b894a', '{"theSingleMostImportantThing":{"target":"1","performance":false},"lecture":{"target":"Lecture 1","performance":false},"dailyEvaluation":{"target":"Gratitude diary, daily evaluation","performance":false},"work":{"target":"Meeting w customer","performance":false},"reading":{"target":"Reading 10 pages","performance":true}}', '{"sixToTwelvePm":[{"target":"6","performance":false},{"target":"7","performance":false},{"target":"8","performance":false}],"twelveToSixPm":[{"target":"xin chao canh","performance":true},{"target":"10","performance":false}],"sixToTwelveAm":[{"target":"11","performance":false},{"target":"23","performance":false},{"target":"14","performance":true}]}', '["111111111111111111ugh today’s work","111111111111111l for the birdsong I heard on my way to work today.","1111111111111"]', '', '2023-10-15', '1');

