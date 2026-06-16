package com.ati.model;

public class Course {
    private int id;
    private String name;
    private String description;
    private String duration;
    private String fee;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getDuration() { return duration; }
    public void setDuration(String duration) { this.duration = duration; }

    public String getFee() { return fee; }
    public void setFee(String fee) { this.fee = fee; }
}
