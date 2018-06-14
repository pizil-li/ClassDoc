## django富文本ckeditor



1. 安装ckeditor   

   ```python
   pip install django-ckeditor
   ```

   ​

2. 在settings.py的INSTALLED_APPS里添加ckeditor和ckeditor_uploader两个应用。

   ```python
   INSTALLED_APPS = (
       #
       'ckeditor',
       'ckeditor_uploader'  # 使用上传的app
   )
   ```

3. 同时需要在settings.py里设置ckeditor的文件上传路径(在此之前需要配置MEDIA_URL和MEDIA_ROOT)。

   ```python
   CKEDITOR_UPLOAD_PATH = "content"


   ```

4. 然后在settings.py里进行ckeditor的相关配置。

   ```python
   CKEDITOR_CONFIGS = {
       'default_ckeditor': {
           'toolbar': 'Full',
       },
       'special':{
        'toolbar': 'Custom',
        'skin': 'moono',
        'height': '500',
        'toolbar_Custom' : [
               ['Bold', 'Link', 'Unlink', 'Image'],
           ]        
       }    
   }
   ```

5. 接下来在urls.py里配置ckeditor相关的url。

   ```python
   urlpatterns = [
       #
       url(r'^ckeditor/', include('ckeditor_uploader.urls')),
   ]+ static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
   ```

6. 最后修改需要使用富文本编辑器的Django APP的目录下的models.py。其中RichTextField拥有TextField的全部参数，还拥有其他的一些参数。

   ```python
   from ckeditor.fields import RichTextField
   from ckeditor_uploader.fields import RichTextUploadingField  # 这个可以上传文件了, 需要把media相关配置好
   ```


   instructions = RichTextField() # 将需要使用富文本编辑器的字段改为RichTextField
   describe = RichTextUploadingField(config_name='default_ckeditor', verbose_name=u'描述') 
   ```python

7. 这样就可以在相应Django APP的Admin界面中使用富文本编辑器编辑了。
   当然上面配置ckeditor的CKEDITOR_CONFIGS时比较简单粗暴，其实可以看到这就是一个Python的dict，可以同时运用多种ckeditor的配置并命名。

   ```python
   CKEDITOR_CONFIGS = {
       'awesome_ckeditor': {
           'toolbar': 'Basic',
       },
       'default_ckeditor':{
           'toolbar': 'Full',
       },
   }
   ```
   ```python

   ```

   ​

8. 当然这里也只是简单配置了一下toolbar，其他的一些配置可以看源码和文档。这样在models.py中就可以通过RichTextField的config_name进行选择。

   ```python
   learn = RichTextField(config_name='default_ckeditor')
   instructions = RichTextField(config_name='awesome_ckeditor')
   ```

9. 前端要想先显示富文本

   ```python

   {% autoescape off %}

   {{course.describe}}

   {% endautoescape %}

   # 或者使用别的方式
   {% course.describe | safe %}
   ```

10. 关于ckeditor的其他的属性,这个需要多试试

   ```python
    toolbar :
           [
               #  加粗     斜体，     下划线      穿过线      下标字        上标字
               ['Bold','Italic','Underline','Strike','Subscript','Superscript'],
               #  数字列表          实体列表            减小缩进    增大缩进
               ['NumberedList','BulletedList','-','Outdent','Indent'],
               #  左对 齐             居中对齐          右对齐          两端对齐
               ['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'],
               #  超链接  取消超链接 锚点
               ['Link','Unlink','Anchor'],
               #  图片    flash    表格       水平线            表情       特殊字符        分页符
               ['Image','Flash','Table','HorizontalRule','Smiley','SpecialChar','PageBreak'],
               '/',
               ## 样式       格式      字体    字体大小
               ['Styles','Format','Font','FontSize'],
               ## 文本颜色     背景颜色
               ['TextColor','BGColor'],
               ##全屏           显示区块
               ['Maximize', 'ShowBlocks','-']
           ]
   ```

   ​