package com.ati.model;

public class Result {
    private int id;
    private String studentIndex;
    private String studentName;
    private String courseName;
    private String marks;
    private String grade;
    private String resultFile;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getStudentIndex() { return studentIndex; }
    public void setStudentIndex(String studentIndex) { this.studentIndex = studentIndex; }

    public String getStudentName() { return studentName; }
    public void setStudentName(String studentName) { this.studentName = studentName; }

    public String getCourseName() { return courseName; }
    public void setCourseName(String courseName) { this.courseName = courseName; }

    public String getMarks() { return marks; }
    public void setMarks(String marks) { this.marks = marks; }

    public String getGrade() { return grade; }
    public void setGrade(String grade) { this.grade = grade; }

    public String getResultFile() { return resultFile; }
    public void setResultFile(String resultFile) { this.resultFile = resultFile; }
}
