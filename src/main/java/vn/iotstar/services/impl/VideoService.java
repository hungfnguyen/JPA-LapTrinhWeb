package vn.iotstar.services.impl;

import java.util.List;

import vn.iotstar.dao.impl.VideoDao;
import vn.iotstar.entity.Video;
import vn.iotstar.services.IVideoService;

public class VideoService implements IVideoService{
	
	public VideoDao video = new VideoDao();
	
	@Override
	public int count() {
		return video.count();
	}

	@Override
	public List<Video> findAll(int page, int pagesize) {
		return video.findAll(page, pagesize);
	}

	@Override
	public List<Video> findAll() {
		return video.findAll();
	}

	@Override
	public Video findById(int videoid) {
		return video.findById(videoid);
	}

	@Override
	public void delete(int videoid) throws Exception {
		video.delete(videoid);
		
	}

	@Override
	public void update(Video videos) {
		video.update(videos);
		
	}

	@Override
	public void insert(Video videos) {
		video.insert(videos);
		
	}

}
