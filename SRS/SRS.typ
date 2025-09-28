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
)[X]
#set table(
  stroke: none,
  gutter: 0.2em,
  fill: (col, row) =>
    if col == 0 or row == 0 { blue.lighten(50%) },
  inset: (right: 1.5em),
)

#show table.cell: it => {
  // Check if the cell is in the header row or column based on fill
  if it.fill == blue.lighten(50%) {
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
#align(center, text(20pt)[
*CÔNG NGHỆ PHẦN MỀM NÂNG CAO - THỰC HÀNH* \
*ĐỀ TÀI: CHAT APPLICATION*
])
#align(center, text(12pt)[
   Giáo viên hướng dẫn: 

])
#table(columns: (150pt,100pt),
  align: center,
  [Tên thành viên], [Mã số ]
)
#grid(
  columns: (150pt, 100pt),
  align(center)[
    Trần Anh Đức \
    Cao Phạm Tuấn Anh \
    Đỗ Hoàng Minh Trí \
    Trần Tuấn Duy Khanh \
    Dương Thế Hiệp \
    
],
  align(center)[
    23DH110826 \
    21DH113430 \
    23DH113733 \
    23DH111546 \
    23DH114911 \
]
)

= Giới thiệu
Chat Application như cái tên là một website chat đơn giản
được xây dựng trên Node.js, Expressjs và Socket.io giúp cho người dùng
đã có tài khoản có thể tham gia chat với một người hoặc một
nhóm người khác

Mục tiêu của hệ thống này là để cung cấp kinh nghiệm làm việc với Javascript cho lập trình viên, cho nên đây chỉ là bản phát thảo
= Yêu cầu
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
  [8], [Gửi video], x, x, [],
  [9], [Gửi emoji], x, x, [],
  [10], [Xem thông tin tài khoản cá nhân], x, x, [],
  [11], [Xem thông tin tài khoản người dùng], x, x, [],
  [12], [Đăng xuất], x, x, [],
  [13], [Chặn user], x, [], [],
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
Hệ thống có thể được xem xét để thêm vào những chức năng như thêm option cho chatter để block hoặc kết bạn với chatter khác.
= Testing strategy

= deployment plan



