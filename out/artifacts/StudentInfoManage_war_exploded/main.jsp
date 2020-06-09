<%--
  Created by IntelliJ IDEA.
  User: brianwen
  Date: 2020-05-03
  Time: 00:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>学生信息管理系统主页面</title>
    <%
        //权限验证
        if(session.getAttribute("currentUser") == null){
        	response.sendRedirect("index.jsp");
        	return;
        }
    %>
    <link rel="stylesheet" type="text/css" href="jquery-easyui-1.3.3/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="jquery-easyui-1.3.3/themes/icon.css">
    <script type="text/javascript" src="jquery-easyui-1.3.3/jquery.min.js"></script>
    <script type="text/javascript" src="jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript">
        $(function(){
            // 数据
            var treeData=[{
                text:"Root",
                children:[{
                    text:"Class Information Management",
                    attributes:{
                        url:"gradeInfoManage.jsp"
                    }
                },{
                    text:"Student Information Management",
                    attributes:{
                        url:"studentInfoManage.jsp"
                    }
                }]
            }];

            // 实例化树菜单
            $("#tree").tree({
                data:treeData,
                lines:true,
                onClick:function(node){
                    if(node.attributes){
                        openTab(node.text,node.attributes.url);
                    }
                }
            });

            // 新增Tab
            function openTab(text,url){
                if($("#tabs").tabs('exists',text)){
                    $("#tabs").tabs('select',text);
                }else{
                    var content="<iframe frameborder='0' scrolling='auto' style='width:100%;height:100%' src="+url+"></iframe>";

                    $("#tabs").tabs('add',{
                        title:text,
                        closable:true,
                        content:content
                    });
                }
            }
        });
    </script>
</head>
<body class="easyui-layout">
    <div region="north" style="height: 80px; background-color:#E0EDFF">
        <div align="left" style="width=80%; float:left"><img src="images/main.jpg"></div>
        <div style="padding-top: 50px; padding-right: 20px;">Current User:&nbsp;<font color="red" >${currentUser.userName}</font></div>

    </div>

    <div region="west" style = "width: 150px;" title="Main Menu" split="true">
        <ul id="tree"></ul>
    </div>

    <div region="center">
        <div class="easyui-tabs" fit = "true" border = "false" id = "tabs">
            <div title ="Main Page"></div>
        </div>
    </div>

    <div region="south" style = "height: 25px;" align=" center">Libin Wen</div>
</body>
</html>
