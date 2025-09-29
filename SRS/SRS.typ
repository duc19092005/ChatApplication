#set page(
  paper: "a4",
  margin: (x: 1.8cm, y: 1.5cm),
)

#set par(
  justify: true,
  leading: 0.52em,
  first-line-indent: (amount: 1em, all: true,),
)

#set text(
  size:12pt,
)

#set heading(numbering: "I.")

#set enum(numbering: "1.a.")

#let x=table.cell(
  fill: green.lighten(60%),
)[✓]
#set table(
  stroke: none,
  gutter: 0.2em,
  fill: (col, row) =>
    if col == 0 or row == 0 { blue.lighten(30%) },
  inset: (right: 1.5em),
)

#show table.cell: it => {
  // Check if the cell is in the header row or column based on fill
  if it.fill == blue.lighten(30%) {
    set text(white)
    strong(it)
  } else if it.body == [] {
    // Replace empty cells with 'N/A'
    pad(..it.inset)[]
  } else {
    it
  }
}


#align(center, text(15pt)[
    Bộ Giáo Dục Và Đào Tạo \
  Trường Đại Học Ngoại Ngữ - Tin Học Thành Phố Hồ Chí Minh \
*Khoa Công Nghệ Thông Tin*
])
#figure(
  image("HUFLIT.png", width: 30%)
)
#align(center, text(20pt, font: "Roboto")[
*CÔNG NGHỆ PHẦN MỀM NÂNG CAO - THỰC HÀNH* \
*ĐỀ TÀI: CHAT APPLICATION*
])
#align(center, text(12pt)[
   Giáo viên hướng dẫn: 

])
Nhóm 12:
#table(columns: (150pt,100pt),
  fill: (x,y) =>
  if y==0 {blue.lighten(30%)},
  align: center,
  [Tên thành viên], [Mã số ],
  [Trần Anh Đức], [23DH110826],  
  [Cao Phạm Tuấn Anh], [21DH113430],
  [Đỗ Hoàng Minh Trí], [23DH113733],
  [Dương Thế Hiệp], [23DH114911],
)


= Giới thiệu
Chat Application như cái tên là một website chat đơn giản
được xây dựng trên Node.js, Expressjs và Socket.io giúp cho người dùng
đã có tài khoản có thể tham gia chat với một người hoặc một
nhóm người khác

Mục tiêu của hệ thống này là để cung cấp kinh nghiệm làm việc với Javascript cho lập trình viên, cho nên đây chỉ là bản phát thảo
= Yêu cầu từ khách hàng
#table( fill: (x, y) => 
  if y == 0 {blue.lighten(30%)}
  else if x==2 { green.lighten(30%) }
  else if x==0 {blue.lighten(30%)},
  columns: (30pt, auto, 150pt),
  [STT], [Câu hỏi], [Câu trả lời], 
  [1], [Tôi có mục đích nào cho phần mềm chat này hay không], [Mục đích là để có 1 website đơn giản thuần chat với người dùng khác],
  [2], [Hệ thống này dành cho web hay app?], [Hệ thống dành cho web],
  [3], [Tôi có thể chặn người khác không?], [Có],
  [4], [Tôi có thể cuộc gọi và video hay không?], [Không],
  [5], [Tôi có thể gửi ảnh và video cho người khác hay không?], [Có nhưng hiện tại chỉ gửi ảnh],
  [6], [Tôi có thể tạo nhóm chat hay không?], [Có],
  [7], [Tôi có thể gửi icon, emoji cho người khác không?], [Có],
  [8],[Web có hỗ trợ mã hóa cho tin nhắn của tôi không?], [Có],
  [9], [Tôi có thể tìm kiếm người dùng khác bằng email và số điện thoại?], [Có],
  [10], [Web có thể hỗ trợ xác thực 2 lớn bằng email hoặc số điện thoại hay không?], [Có],
  [11], [Web có hỗ trợ khôi phục lại mật khâu nếu tôi quên hay không?], [Có],
  [12], [Web có yêu cầu đăng ký không?], [Có], 
  [13], [Website có áp dụng các gói nâng cấp tài khoản không?], [Không],
  [14], [Xem thông tin tài khoản được không?], [Có],
  [15], [Tôi có thể sửa mật khẩu của tôi không?], [Có],
  [16], [Tôi có thể xem lịch sử lời nhắn không?], [Có],
  [17], [Tôi có thể custom font hay theme chat không?], [Hiện tại không],
  [18], [Tôi có thể xem thông tin tài khoản người dùng khác hay không?], [Có],
  [19], [Làm sao để tham gia nhóm?], [Cần phải có người dùng đã trong nhóm mời bạn vào và bạn đồng ý],
  [20], [Yêu cầu đăng ký là gì?], [Chỉ cần tên người dùng, Email và mật khẩu],
  [21], [Lời nhắn có tương tác như thả emoji hay pin tin nhắn không], [Không]
)
= Yêu cầu hệ thống
+ Chức năng
_Admin: Người quản trị hệ thống_

_Chatter: Người dùng đã có tài khoản_

#table(columns: 5,
  [STT], [Story name], [Admin], [Chatter], [Description],
  [1], [Đăng ký], [], x, [],
  [2], [Đăng nhập], x, x, [],
  [3], [Xem tài khoản], x, x, [], 
  [4], [Tìm kiếm user/group chat], x, x, [],
  [5], [Nhập lời nhắn], x, x, [],
  [6], [Xem lịch sử chat], x, x, [],
  [7], [Gửi ảnh], x, x, [],
  [8], [Gửi emoji], x, x, [],
  [9], [Xem thông tin tài khoản cá nhân], x, x, [],
  [10], [Xem thông tin tài khoản người dùng khác], x, x, [],
  [11], [Đăng xuất], x, x, [],
  [12], [Chặn user], x, x, [],
  [13], [Mời người vào nhóm], x, x, [],
  [14], [Sửa mật khẩu],[],  x, [],
  [15], [Xác thực 2 lớp] , [], x, [],
  [16], 
)
+ Phi chức năng
  + perfomance
  + security
  + usability
  + scalability

= System architecture
+ Technology stack
  + Backend
    - Ngôn ngữ: Javascript, Typescript
    - Môi trường: Node.js
    - Framework: Expressjs
  + Frontend
    - Ngôn ngữ: Javascript
    - Thư viện: Reactjs
  + Database
    - MongoDB  
  + Authentication
    - jwt

= Component design

= User interface design

= Data design
- Database: MongoDB
- API contract:
+ Database ERD Diagram
\* _insert here_
+ Database tables

\* _insert here_

= security consideration
Độ bảo mật của hệ thống được dựa dẫm hoàn toàn vào 
Hệ thống có thể được xem xét để thêm vào những chức năng như thêm option cho chatter để block hoặc kết bạn với chatter khác. Một số chức năng đã có:
- Xác thực 2 yếu tố
- Đổi mật khẩu
- 
= Testing strategy

= Deployment plan

= Phân chia công việc

#table(columns: 3,
  [Họ tên], [Công việc], [Mức độ hoàn thành],
  [Trần Anh Đức], [], [],  
  [Cao Phạm Tuấn Anh], [], [],
  [Đỗ Hoàng Minh Trí], [], [],
  [Dương Thế Hiệp], [], [],
)



