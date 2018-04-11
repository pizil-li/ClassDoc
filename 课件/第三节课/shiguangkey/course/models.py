from django.db import models

from datetime import datetime


# Create your models here.

class Course(models.Model):
    name = models.CharField(max_length=30, verbose_name=u"课程名称")
    price = models.CharField(max_length=10, verbose_name=u"价格")
    learn_time = models.CharField(max_length=6, verbose_name=u"学习时长")
    nums = models.IntegerField(default=0, verbose_name=u"购买人数")
    image = models.ImageField(upload_to="img/&Y/%m", verbose_name=u"封面图")
    describe = models.ImageField(upload_to="img/course/%Y/%m", verbose_name=u"描述")

    class Meta:
        verbose_name = u"课程"
        verbose_name_plural = verbose_name


class lesson(models.Model):
    lesson_course = models.ForeignKey(Course, related_name="course")
    name = models.CharField(max_length=40, verbose_name=u"课程名")
    time = models.DateTimeField(default=datetime.now, verbose_name=u"课程时间")

    class Meta:
        verbose_name = u"章节"
        verbose_name_plural = verbose_name


class Teacher(models.Model):
    teacher_course = models.ForeignKey(Course, related_name="courses")
    teacher_name = models.CharField(max_length=30, verbose_name=u"老师名")
    teacher_des = models.CharField(max_length=100, verbose_name=u"老师描述")
    teacher_img = models.ImageField(upload_to="img/tea/&Y/%m", verbose_name=u"老师图")

    class Meta:
        verbose_name = u"老师"
        verbose_name_plural = verbose_name
