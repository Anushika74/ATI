package com.ati.model;

public class GalleryImage {
    private int id;
    private String title;
    private String imagePath;
    private boolean carousel;
    private String uploadDate;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getImagePath() { return imagePath; }
    public void setImagePath(String imagePath) { this.imagePath = imagePath; }

    public boolean isCarousel() { return carousel; }
    public void setCarousel(boolean carousel) { this.carousel = carousel; }

    public String getUploadDate() { return uploadDate; }
    public void setUploadDate(String uploadDate) { this.uploadDate = uploadDate; }
}
