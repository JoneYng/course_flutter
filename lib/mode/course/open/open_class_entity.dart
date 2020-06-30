class OpenClassDateEntity {
  String week = ""; //星期
  String date = ""; //日期
  String query_date = ""; //日期
  var isSelect = false;

  OpenClassDateEntity({this.week});

  OpenClassDateEntity.fromJson(Map<String, dynamic> json) {
    week = json['week'];
    date = json['date'];
    isSelect = json['isSelect'];
    query_date = json['query_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['week'] = this.week;
    return data;
  }
}

class OpenClassEntity {
  String title = ""; //标题
  String live_url = ""; //直播地址
  String site_cn = ""; //业务
  String subject_cn = ""; //类型
  int stime = 0; //开始时间
  int etime = 0; //结束时间
	TeacherInfo mTeacherInfo;//老师信息
  OpenClassEntity({this.title});

  OpenClassEntity.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    live_url = json['live_url'];
    site_cn = json['site_cn'];
    subject_cn = json['subject_cn'];
    stime = json['stime'];
    etime = json['etime'];
		var teacherInfo = json['teacher_info'];
		mTeacherInfo=TeacherInfo.fromJson(teacherInfo);

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    return data;
  }
}

class OpenClassRoot {
  List<dynamic> item;
  List<OpenClassEntity> mOpenClassEntity = [];

  OpenClassRoot({this.item});

  OpenClassRoot.fromJson(Map<String, dynamic> json) {
    item = json['item'];
    mOpenClassEntity = fromItem(item);
  }

  List<OpenClassEntity> fromItem(List<dynamic> item) {
    List<OpenClassEntity> mOpenClassEntity = [];
    if (item != null) {
      mOpenClassEntity.clear();
      for (var mVideoEntity in item) {
        mOpenClassEntity.add(OpenClassEntity.fromJson(mVideoEntity));
      }
    }
    return mOpenClassEntity;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item'] = this.item;
    return data;
  }
}

class TeacherInfo {
  int  id ; //id
  String name = ""; //名字
  String nickname = ""; //名字
  String head_pic = ""; //头像
  String mobile_head_pic = ""; //标题
  String introduce = ""; //introduce
  String site_cn = ""; //GMAT
  String subject_cn = ""; //逻辑

  TeacherInfo({this.id});

  TeacherInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nickname = json['nickname'];
    head_pic = json['head_pic'];
    mobile_head_pic = json['mobile_head_pic'];
    introduce = json['introduce'];
    site_cn = json['site_cn'];
    site_cn = json['site_cn'];
    subject_cn = json['subject_cn'];
  }
}
