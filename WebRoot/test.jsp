<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="extjs/ext.js"></script>
<script type="text/javascript" src="extjs/bootstrap.js"></script>
<script type="text/javascript" src="extjs/ext-all.js"></script>
<link rel="stylesheet" type="text/css" href="extjs/resources/css/ext-all.css"></link>
<script type="text/javascript" src="extjs/ext-lang-zh_CN.js"></script>
<script type="text/javascript">
Ext.onReady(function(){
    //初始化Extjs
    Ext.QuickTips.init();
    //从本地加载图片,如果不定义默认从Exj官方网站加载
    Ext.BLANK_IMAGE_URL ='resources/images/default/s.gif';
    //首先读取数据，Json格式
    var store = new Ext.data.Store
    ({      
        //读取数据源用json方法(三种方法1.读取json用JsonReader,2读取数组使用ArrayReader3.读取XML用XmlReader)
        reader:new Ext.data.JsonReader
        ({
        root:"Table",
        //从数据库中读取的总记录数
        totalProperty: 'totalCount',
        //要读取出来的字段
        fields:
        [
            'ID','RoleName','Remark'
        ]
        }),   
        //获取数据源(该方法返回一个json格式的数据源)
        proxy: new Ext.data.HttpProxy
        ({
            url: '../../BackGround/RoleManage/Role.ashx?AutoLoad=true'      
        })
    });
    //定义GridPanel的列名称
   var cms=new Ext.grid.ColumnModel
   (
   [
    new Ext.grid.RowNumberer({header:"编号",width:30,align:"center"}),//添加一个编号
    new Ext.grid.CheckboxSelectionModel(),//增加 CheckBox多选框列
    //header列名称，dateIndex对应数据库字段名称,sortable支持排序
    {header:"角色名称",dataIndex:"RoleName",sortable:true},
    {header:"角色备注",dataIndex:"Remark",sortable:true}
      
   ]
   );
  //编辑panel，用于添加，修改
  var Edit_Panel=new Ext.FormPanel({    
    labelWidth: 75, 
    labelAlign:'right',
    frame:true,      
    bodyStyle:'padding:5px 5px 0',
    width: 380,
    defaults: {width: 150},
    defaultType: 'textfield',
    items: 
    [
        {
            fieldLabel: '角色编号',
            name: 'ID',
            xtype:'hidden'
        },
        {
            //label名称
            fieldLabel: '角色名称',
            //textfield名称
            name: 'RoleName',
            //textfield正则
            allowBlank:false,//是否允许为空！false不允许
            blankText:"不允许为空",//提示信息
            minLength :2 , 
            minLengthText : "姓名最少2个字符", 
            maxLength : 4 , 
            maxLengthText :"姓名至多4个字符",
            regex:/[\u4e00-\u9fa5]/,//正则表达式
            regexText:"只能为中文"
        },
        {
           fieldLabel: '角色编码',
           name: 'RoleCode',
           allowBlank:false,
           blankText:"不允许为空",
            xtype:'hidden'
        },
        {
         fieldLabel: '说明',
            name: 'Remark'
         
        }
    ]
 
});
 //弹出层
var Edit_Window = new Ext.Window({
    collapsible: true,
    maximizable: true,
    minWidth: 300,
    height :180 ,
    minHeight: 200,
    width:378,
    modal:true,
    closeAction:"hide",
    //所谓布局就是指容器组件中子元素的分布，排列组合方式
    layout: 'form',//layout布局方式为form
    plain: true,
    title:'编辑对话框',
    bodyStyle: 'padding:5px;',
    buttonAlign: 'center',
    items: Edit_Panel,
    buttons: [{
        text: '保存',
        //点击保存按钮后触发事件
        handler:function(){
        //得到编辑模板中id为ID的控件名称的值
        var ID=Edit_Panel.getForm().findField('ID').getValue();
          //得到编辑模板中id为RoleName的控件名称的值
        var RoleName=Edit_Panel.getForm().findField('RoleName').getValue();
        //var RoleCode=Edit_Panel.getForm().findField('RoleCode').getValue();
        var Remark=Edit_Panel.getForm().findField('Remark').getValue();
        var jsonData='';
        if(ID=='')
        //如果ID为空的话说明是添加操作，否则是修改操作,将ID,角色名称(RoleName),角色编码(RoleCode),说明(Remark),操作类型(添加操作:AddUser,更新操作:UpdateUser)写成json的形式作为参数传到后台
       jsonData= {operatype:'AddRole',ID:ID,RoleName:RoleName,Remark:Remark};
        else
       jsonData= {operatype:'UpdateRole',ID:ID,RoleName:RoleName,Remark:Remark};
        Edit_Window.hide();
        CodeOperaMethod('../../WebUI/RoleManage/RoleManege.aspx',jsonData);
        //重新加载store信息
        store.reload();
        grid.store.reload();
        }
    },{
        text: '重置',  handler:function(){Edit_Panel.getForm().reset();}
    }]
});
});
</script>
</head>
<body>

</body>
</html>