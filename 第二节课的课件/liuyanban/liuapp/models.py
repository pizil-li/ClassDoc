from django.db import models

# Create your models here.

# 创建留言的表单
class LiuyanModels(models.Model):
    name = models.CharField(max_length=50, verbose_name=u"姓名")
    email = models.EmailField(verbose_name=u"邮箱")
    address = models.CharField(max_length=60, verbose_name=u"地址")
    message = models.CharField(max_length=600, verbose_name=u"留言")
    add_time = models.DateTimeField(auto_now=True,verbose_name=u"添加时间")
