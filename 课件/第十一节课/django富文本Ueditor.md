## django富文本Ueditor



1. 安装ueditor

   ```python
   pip install DjangouEditor
   ```

2. 在settings.py的INSTALLED_APPS里添加DjangoUeditor 应用

   ```python
   INSTALLED_APPS = (
       #
       'DjangoUeditor',
   )
   ```

3. 接下来在urls.py里配置Ueditor相关的url。

   ```python
   urlpatterns = [
       #
    	url(r'^ueditor/',include('DjangoUeditor.urls' )),
   ]
   ```

4. 在models中的使用

   ```python
   from DjangoUeditor.models import UEditorField
   class Blog(models.Model):
   	Name=models.CharField(,max_length=100,blank=True)
   	Content=UEditorField(u'内容	',width=600, height=300, toolbars="full", imagePath="", filePath="", upload_settings={"imageMaxSize":1204000},
                settings={},command=None,event_handler=myEventHander(),blank=True)
   ```

   ​

