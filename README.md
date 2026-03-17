# English Learning App with Flashcard

Ứng dụng học tiếng Anh trên thiết bị di động được phát triển bằng **Flutter**, hỗ trợ học từ vựng bằng **Flashcard**, luyện nghe **Dictation**, luyện nói **Shadowing**, theo dõi tiến độ học tập và tùy chỉnh thông tin/cài đặt người dùng. Ở phiên bản hiện tại, ứng dụng tập trung vào **giao diện**, **trải nghiệm người dùng** và **mô phỏng luồng chức năng** bằng dữ liệu mẫu và state cục bộ. :contentReference[oaicite:1]{index=1}

---

## Giới thiệu

Dự án được xây dựng với mục tiêu hỗ trợ người học tiếng Anh tự học một cách trực quan, thuận tiện và dễ tiếp cận trên thiết bị di động. Ứng dụng hướng đến việc:

- ghi nhớ từ vựng hiệu quả qua flashcard
- luyện nghe chính tả với Dictation
- luyện nói theo mẫu với Shadowing
- theo dõi quá trình học tập
- cá nhân hóa trải nghiệm sử dụng qua phần Cài đặt


---

## Tính năng chính

### 1. Home
- Hiển thị màn hình tổng quan khi mở ứng dụng
- Điều hướng nhanh đến các khu vực chính
- Có thể hiển thị tiến độ học tập, hoạt động gần đây và các lối tắt chức năng nếu dữ liệu có sẵn

### 2. Flashcard
- Chọn bộ từ vựng theo chủ đề
- Học từ vựng bằng thẻ lật
- Xem từ, nghĩa, phiên âm và ví dụ
- Chuyển qua lại giữa các thẻ

### 3. Quản lý từ vựng
- Thêm từ vựng mới
- Lưu từ vựng để ôn tập
- Đánh dấu từ đã thuộc / chưa thuộc

### 4. Dictation
- Luyện nghe chính tả bằng câu hoặc đoạn mẫu
- Nhập đáp án sau khi nghe
- Xem kết quả so sánh và phản hồi

### 5. Shadowing
- Luyện nói theo câu mẫu
- Xem kết quả mô phỏng theo các tiêu chí như phát âm, ngữ điệu và độ lưu loát

### 6. Progress
- Theo dõi số từ đã học
- Theo dõi số từ đã thuộc, số từ đã lưu
- Theo dõi số bài Dictation và Shadowing đã thực hiện

### 7. Settings
- Thay đổi ngôn ngữ hiển thị
- Chỉnh sửa thông tin cá nhân
- Tùy chỉnh một số thiết lập học tập cơ bản


---

## Công nghệ sử dụng

- **Flutter**
- **Dart**
- **Material Design**
- **Widget-based UI**
- **Local State Management**
- **Mock Data**
- **Feature-based Folder Structure**
- **Reusable Widgets**



---

## Kiến trúc tổng quan

Ứng dụng được tổ chức theo 3 lớp chính:

- **UI**: nơi người dùng tương tác trực tiếp với hệ thống
- **State**: quản lý trạng thái, điều phối xử lý và cập nhật giao diện
- **Storage**: lưu trữ dữ liệu cục bộ hoặc dữ liệu mô phỏng



---

## Cấu trúc chức năng

```text
lib/
├─ features/
│  ├─ home/
│  ├─ flashcard/
│  ├─ dictation/
│  ├─ shadowing/
│  ├─ progress/
│  └─ settings/
├─ models/
├─ services/
├─ state/
├─ data/
└─ main.dart
