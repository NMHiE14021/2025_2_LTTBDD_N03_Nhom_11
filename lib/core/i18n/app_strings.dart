class AppStrings {
  final bool vi;

  const AppStrings(this.vi);

  String get appName =>
      vi ? 'Học tiếng Anh thông minh' : 'Smart English Learning';
  String get home => vi ? 'Trang chủ' : 'Home';
  String get flashcard => vi ? 'Flashcard' : 'Flashcards';
  String get dictation => vi ? 'Dictation' : 'Dictation';
  String get shadowing => vi ? 'Shadowing' : 'Shadowing';
  String get settings => vi ? 'Cài đặt' : 'Settings';

  String get hello => vi ? 'Xin chào 👋' : 'Hello 👋';
  String get subtitle => vi
      ? 'Luyện từ vựng, nghe chép chính tả và shadowing trong một ứng dụng.'
      : 'Practice vocabulary, dictation and shadowing in one app.';

  String get todayOverview => vi ? 'Tổng quan hôm nay' : 'Today overview';
  String get lessons => vi ? 'Bài học' : 'Lessons';
  String get minutes => vi ? 'Phút luyện' : 'Practice minutes';
  String get minutesUnit => vi ? 'phút' : 'minutes';
  String get streak => vi ? 'Chuỗi ngày' : 'Streak';
  String get completed => vi ? 'Hoàn thành' : 'Completed';

  String get featuredModules =>
      vi ? 'Các chế độ luyện tập' : 'Featured modules';
  String get recentActivities => vi ? 'Hoạt động gần đây' : 'Recent activities';
  String get continueLearning => vi ? 'Tiếp tục học' : 'Continue learning';

  String get flashcardDesc => vi
      ? 'Học từ mới bằng thẻ từ với bố cục trực quan.'
      : 'Learn vocabulary with clean and visual cards.';

  String get dictationDesc => vi
      ? 'Nghe và nhập lại câu để cải thiện nghe hiểu.'
      : 'Listen and type the sentence to improve listening.';

  String get shadowingDesc => vi
      ? 'Luyện nói theo mẫu để cải thiện phát âm và ngữ điệu.'
      : 'Repeat after the speaker to improve pronunciation and intonation.';

  String get language => vi ? 'Ngôn ngữ' : 'Language';
  String get vietnamese => vi ? 'Tiếng Việt' : 'Vietnamese';
  String get english => vi ? 'Tiếng Anh' : 'English';

  String get topic => vi ? 'Chủ đề' : 'Topic';
  String get meaning => vi ? 'Nghĩa' : 'Meaning';
  String get example => vi ? 'Ví dụ' : 'Example';
  String get pronunciation => vi ? 'Phát âm' : 'Pronunciation';
  String get progress => vi ? 'Tiến độ' : 'Progress';
  String get previous => vi ? 'Trước' : 'Previous';
  String get next => vi ? 'Tiếp' : 'Next';

  String get chooseLesson => vi ? 'Chọn bài học' : 'Choose lesson';
  String get audioPlayer => vi ? 'Trình phát âm thanh' : 'Audio player';
  String get typeAnswer =>
      vi ? 'Nhập nội dung bạn nghe được' : 'Type what you hear';
  String get tips => vi ? 'Gợi ý từ khóa' : 'Keyword hints';
  String get checkResult => vi ? 'Kết quả mô phỏng' : 'Mock result';
  String get accuracy => vi ? 'Độ chính xác' : 'Accuracy';

  String get transcript => vi ? 'Đoạn mẫu' : 'Transcript';
  String get speakingAnalysis =>
      vi ? 'Phân tích luyện nói' : 'Speaking analysis';
  String get fluency => vi ? 'Độ trôi chảy' : 'Fluency';
  String get intonation => vi ? 'Ngữ điệu' : 'Intonation';
  String get startRecord => vi ? 'Bắt đầu ghi âm' : 'Start recording';
  String get playSample => vi ? 'Nghe mẫu' : 'Play sample';

  String get flashcardHint => vi
      ? 'Chạm vào thẻ để lật mặt trước / mặt sau'
      : 'Tap the card to flip between front and back';

  String get savedVocabulary => vi ? 'Từ đã lưu' : 'Saved words';
  String get reviewSavedWords =>
      vi ? 'Ôn tập từ vựng đã lưu' : 'Review saved vocabulary';
  String get savedWordsCount => vi ? 'Số từ đã lưu' : 'Saved words count';
  String get saveWord => vi ? 'Lưu từ này' : 'Save this word';
  String get savedLabel => vi ? 'Đã lưu' : 'Saved';
  String get addedToSaved =>
      vi ? 'Đã thêm từ vào danh sách ôn tập.' : 'Word added to review list.';
  String get removedFromSaved => vi
      ? 'Đã xóa từ khỏi danh sách ôn tập.'
      : 'Word removed from review list.';
  String get removeSavedWord => vi ? 'Bỏ lưu' : 'Remove';
  String get searchWord =>
      vi ? 'Tìm từ vựng đã lưu...' : 'Search saved vocabulary...';
  String get noSavedWords =>
      vi ? 'Chưa có từ nào phù hợp' : 'No matching saved words';
  String get noSavedWordsHint => vi
      ? 'Hãy vào Flashcard để lưu từ, thêm từ mới hoặc đổi bộ lọc chủ đề / trạng thái.'
      : 'Go to Flashcards to save words, add new words, or change the topic / status filter.';
  String get savedPageHint => vi
      ? 'Lọc từ theo chủ đề và trạng thái học để ôn tập hiệu quả hơn.'
      : 'Filter words by topic and learning status for a cleaner review flow.';
  String get filterByTopic => vi ? 'Lọc theo chủ đề' : 'Filter by topic';
  String get allTopics => vi ? 'Tất cả chủ đề' : 'All topics';
  String get allWords => vi ? 'Tất cả' : 'All';
  String get learningStatus => vi ? 'Trạng thái học' : 'Learning status';
  String get reviewLabel => vi ? 'Ôn tập' : 'Review';
  String get masteredOnly => vi ? 'Đã thuộc' : 'Mastered';
  String get masteredLabel => vi ? 'Đánh dấu đã thuộc' : 'Mark mastered';
  String get unmasteredLabel => vi ? 'Chưa thuộc' : 'Needs review';
  String get markedAsMastered =>
      vi ? 'Đã đánh dấu từ là đã thuộc.' : 'Word marked as mastered.';
  String get markedAsReview =>
      vi ? 'Đã chuyển từ về trạng thái ôn tập.' : 'Word moved back to review.';
  String get noVocabularyAvailable =>
      vi ? 'Chưa có từ vựng nào.' : 'No vocabulary available.';
  String get addVocabularyShort => vi ? 'Thêm từ' : 'Add word';

  String get addVocabulary => vi ? 'Thêm từ vựng' : 'Add vocabulary';
  String get addVocabularyTitle => vi ? 'Tạo từ vựng mới' : 'Create a new word';
  