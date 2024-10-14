<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Video</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }
        .form-container {
            background: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        h2 {
            margin-bottom: 20px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
        }
        input[type="text"], input[type="number"], textarea, select {
            width: 100%;
            padding: 10px;
            margin: 5px 0 15px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        input[type="file"] {
            display: inline-block;
            margin-bottom: 15px;
        }
        input[type="radio"] {
            margin-right: 5px;
        }
        .status {
            display: inline-block;
            margin-right: 20px;
        }
        input[type="submit"] {
            background-color: #28a745;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #218838;
        }
        #poster-preview {
            height: 150px;
            width: 200px;
            display: none; /* Ẩn khi chưa có ảnh */
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>Add Video</h2>
        <form action="${pageContext.request.contextPath}/admin/video/insert" method="post" enctype="multipart/form-data">
            <!-- File Upload -->
            <div class="form-group">
                <label for="poster">Upload Poster:</label>
                <input type="file" id="poster" name="poster" accept="image/*" onchange="chooseFile(this)">
                <img id="poster-preview" src="" alt="Poster Preview" />
            </div>

            <!-- Video ID -->
            <div class="form-group">
                <label for="videoId">Video ID:</label>
                <input type="text" id="videoId" name="videoId" required>
            </div>

            <!-- Video Title -->
            <div class="form-group">
                <label for="title">Video Title:</label>
                <input type="text" id="title" name="title" required>
            </div>

            <!-- View Count -->
            <div class="form-group">
                <label for="views">View Count:</label>
                <input type="number" id="views" name="views" min="0">
            </div>

            <!-- Category -->
            <div class="form-group">
                <label for="categoryId">Category:</label>
                <select id="categoryId" name="categoryId" required>
                    <option value="">Select a category</option>
                    <c:forEach var="category" items="${categories}">
                        <option value="${category.categoryId}">${category.categoryName}</option>
                    </c:forEach>
                </select>
            </div>

            <!-- Description -->
            <div class="form-group">
                <label for="description">Description:</label>
                <textarea id="description" name="description" rows="4" required></textarea>
            </div>

            <!-- Status -->
            <div class="form-group">
                <p>Status:</p>
                <span class="status"><input type="radio" id="active" name="active" value="1" checked><label for="active">Hoạt động</label></span>
                <span class="status"><input type="radio" id="inactive" name="active" value="0"><label for="inactive">Khóa</label></span>
            </div>

            <!-- Submit Button -->
            <input type="submit" value="Add Video">
        </form>

        <!-- JavaScript to handle file preview -->
        <script>
            function chooseFile(fileInput) {
                var reader = new FileReader();
                reader.onload = function(e) {
                    var preview = document.getElementById('poster-preview');
                    preview.src = e.target.result;
                    preview.style.display = 'block'; // Hiện ảnh khi đã chọn
                };
                reader.readAsDataURL(fileInput.files[0]);
            }
        </script>
    </div>
</body>
</html>
