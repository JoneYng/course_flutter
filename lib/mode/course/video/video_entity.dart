class VideoEntity {
	String title="";
	String description="";
	String img_url="";
	String poly_id="";
	VideoEntity({this.title});

	VideoEntity.fromJson(Map<String, dynamic> json) {
		title = json['title'];
		description = json['description'];
		img_url = json['img_url'];
		poly_id = json['poly_id'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['title'] = this.title;
		return data;
	}
}
class VideoRoot {
	List<dynamic> item;
	List<VideoEntity> mVideoEntityList=[];
	int total_page;
	VideoRoot({this.item,this.total_page});

	VideoRoot.fromJson(Map<String, dynamic> json) {
		print("total_page:${json['total_page']}");
		item = json['item'];
		mVideoEntityList=fromItem(item);
		total_page = json['total_page'];
	}

	List<VideoEntity> fromItem(List<dynamic> item) {
		List<VideoEntity> mVideoEntityList=[];
		if(item!=null){
			mVideoEntityList.clear();
			for(var mVideoEntity in item) {
				mVideoEntityList.add(VideoEntity.fromJson(mVideoEntity));
			}
		}
		return mVideoEntityList;
	}


	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['item'] = this.item;
		data['total_page'] = this.total_page;
		return data;
	}
}
