package vn.iotstar.controllers.admin;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.List;
import java.util.UUID;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import vn.iotstar.entity.Category;
import vn.iotstar.entity.Video;
import vn.iotstar.services.ICategoryService;
import vn.iotstar.services.IVideoService;
import vn.iotstar.services.impl.CategoryService;
import vn.iotstar.services.impl.VideoService;
import vn.iotstar.utils.Constant;

@MultipartConfig(fileSizeThreshold = 1024 * 1024,
    maxFileSize = 1024 * 1024 * 5, maxRequestSize = 1024 * 1024 * 5 * 5)
@WebServlet(urlPatterns = { "/admin/videos", "/admin/video/add", "/admin/video/insert", "/admin/video/edit", "/admin/video/update", "/admin/video/delete", "/admin/video/search" })
public class VideoController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    IVideoService videoService = new VideoService();
    ICategoryService categoryService = new CategoryService();
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String url = req.getRequestURI();
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        if (url.contains("videos")) {
            List<Video> list = videoService.findAll();
            req.setAttribute("listVideos", list);
            req.getRequestDispatcher("/views/admin/video-list.jsp").forward(req, resp);
        } else if (url.contains("add")) {
            // Lấy danh sách category từ service
            List<Category> categories = categoryService.findAll(); // Giả sử bạn có một CategoryService
            req.setAttribute("categories", categories); // Đặt danh sách categories vào attribute
            req.getRequestDispatcher("/views/admin/video-add.jsp").forward(req, resp);
        } else if (url.contains("edit")) {
            int id = Integer.parseInt(req.getParameter("id"));
            Video video = videoService.findById(id);
            req.setAttribute("video", video);
            req.getRequestDispatcher("/views/admin/video-edit.jsp").forward(req, resp);
        } else if (url.contains("delete")) {
            String id = req.getParameter("id");
            try {
                videoService.delete(Integer.parseInt(id));
            } catch (Exception e) {
                e.printStackTrace();
            }
            resp.sendRedirect(req.getContextPath() + "/admin/videos");
        }
    }



    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String url = req.getRequestURI();
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        if (url.contains("insert")) {
            // Lấy các giá trị từ form
            String title = req.getParameter("title");
            String description = req.getParameter("description");
            int active = Integer.parseInt(req.getParameter("active"));

            // Tạo video mới
            Video video = new Video();
            // Tạo videoId bằng UUID
            String videoId = UUID.randomUUID().toString();
            video.setVideoId(videoId);

            video.setTitle(title);
            video.setDescription(description);
            video.setActive(active);

            // Xử lý phần upload file poster
            String fname = "";
            String uploadPath = Constant.DIR;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }

            try {
                Part part = req.getPart("poster");
                if (part.getSize() > 0) {
                    String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                    // Đổi tên file
                    int index = filename.lastIndexOf(".");
                    String ext = filename.substring(index + 1);
                    fname = System.currentTimeMillis() + "." + ext;
                    // Upload file
                    part.write(uploadPath + "/" + fname);
                    // Ghi tên file vào data
                    video.setPoster(fname);
                } else {
                    video.setPoster("default.png");
                }
            } catch (Exception e) {
                e.printStackTrace();
            }

            // Gọi service để lưu video vào database
            videoService.insert(video);
            resp.sendRedirect(req.getContextPath() + "/admin/videos");
        } else if (url.contains("update")) {
            // Cập nhật logic cập nhật video ở đây
        }
    }
}
