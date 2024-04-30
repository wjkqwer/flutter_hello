# flutter_hello

```
//加载网络图片
Image.network("")   

//两种处理列表数据方式
children: _urls.map((url) => Image.network(url)).toList()
children: List.generate(_urls.length, (index) => Image.network(_urls[index])))

//滚动组件,不支持懒加载
SingleChildScrollView  

//和安卓差不多的Card组件
Card 
```