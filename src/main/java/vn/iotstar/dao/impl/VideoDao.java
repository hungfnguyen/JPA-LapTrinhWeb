package vn.iotstar.dao.impl;

import java.util.List;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import jakarta.persistence.Query;
import vn.iotstar.configs.JPAConfig;
import vn.iotstar.dao.IVideoDao;
import vn.iotstar.entity.Video;

public class VideoDao implements IVideoDao {

    @Override
    public void insert(Video video) {
        EntityManager enma = JPAConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            // Thêm mới video vào database
            enma.persist(video);
            trans.commit();
        } catch (Exception e) {
            e.printStackTrace();
            trans.rollback(); // Quay lại nếu có lỗi
            throw e;
        } finally {
            enma.close(); // Đảm bảo đóng EntityManager
        }
    }

    @Override
    public void update(Video video) {
        EntityManager enma = JPAConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            // Cập nhật thông tin video
            enma.merge(video);
            trans.commit();
        } catch (Exception e) {
            e.printStackTrace();
            trans.rollback(); // Rollback nếu có lỗi
            throw e;
        } finally {
            enma.close(); // Đảm bảo đóng EntityManager
        }
    }

    @Override
    public void delete(int videoId) throws Exception {
        EntityManager enma = JPAConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            // Tìm video theo ID và xoá nếu tồn tại
            Video video = enma.find(Video.class, videoId);
            if (video != null) {
                enma.remove(video);
            } else {
                throw new Exception("Không tìm thấy video với ID: " + videoId);
            }
            trans.commit();
        } catch (Exception e) {
            e.printStackTrace();
            trans.rollback(); // Rollback nếu gặp lỗi
            throw e;
        } finally {
            enma.close(); // Đảm bảo đóng EntityManager
        }
    }

    @Override
    public Video findById(int videoId) {
        EntityManager enma = JPAConfig.getEntityManager();
        try {
            // Tìm video theo ID
            return enma.find(Video.class, videoId);
        } finally {
            enma.close(); // Đảm bảo đóng EntityManager
        }
    }

    @Override
    public List<Video> findAll() {
        EntityManager enma = JPAConfig.getEntityManager();
        try {
            // Sử dụng NamedQuery để lấy tất cả video
            TypedQuery<Video> query = enma.createNamedQuery("Video.findAll", Video.class);
            return query.getResultList();
        } finally {
            enma.close(); // Đảm bảo đóng EntityManager
        }
    }

    @Override
    public List<Video> findAll(int page, int pageSize) {
        EntityManager enma = JPAConfig.getEntityManager();
        try {
            // Phân trang kết quả
            TypedQuery<Video> query = enma.createNamedQuery("Video.findAll", Video.class);
            query.setFirstResult(page * pageSize);
            query.setMaxResults(pageSize);
            return query.getResultList();
        } finally {
            enma.close(); // Đảm bảo đóng EntityManager
        }
    }

    @Override
    public int count() {
        EntityManager enma = JPAConfig.getEntityManager();
        try {
            // Đếm số lượng video trong bảng
            String jpql = "SELECT count(v) FROM Video v";
            Query query = enma.createQuery(jpql);
            return ((Long) query.getSingleResult()).intValue();
        } finally {
            enma.close(); // Đảm bảo đóng EntityManager
        }
    }
}
