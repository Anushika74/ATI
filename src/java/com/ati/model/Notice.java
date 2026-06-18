package com.ati.model;

public class Notice {
    private int id;
    private String title;
    private String content;
    private String priority;
    private String link;        // optional URL (e.g. a Download/More link)
    private String noticeDate;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public String getPriority() { return priority; }
    public void setPriority(String priority) { this.priority = priority; }

    public String getLink() { return link; }
    public void setLink(String link) { this.link = link; }

    public String getNoticeDate() { return noticeDate; }
    public void setNoticeDate(String noticeDate) { this.noticeDate = noticeDate; }
}
