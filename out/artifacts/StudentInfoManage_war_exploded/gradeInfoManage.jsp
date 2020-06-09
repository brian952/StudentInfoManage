<%--
  Created by IntelliJ IDEA.
  User: brianwen
  Date: 2020-05-03
  Time: 20:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="jquery-easyui-1.3.3/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="jquery-easyui-1.3.3/themes/icon.css">
    <script type="text/javascript" src="jquery-easyui-1.3.3/jquery.min.js"></script>
    <script type="text/javascript" src="jquery-easyui-1.3.3/jquery.easyui.min.js"></script>

    <script type="text/javascript">
        function searchGrade(){
            $('#dg').datagrid('load',{
                gradeName:$('#s_gradeName').val()
            });
        }

        function deleteGrade(){
            var selectedRows=$("#dg").datagrid('getSelections');
            if(selectedRows.length==0){
                $.messager.alert("System Alert","Please Choose a Valid Selection");
                return;
            }
            var strIds=[];
            for(var i=0;i<selectedRows.length;i++){
                strIds.push(selectedRows[i].id);
            }
            var ids=strIds.join(",");
            $.messager.confirm("System Alert","Confirm delete<font color=red>"+selectedRows.length+"</font>selection？",function(r){
                if(r){
                    $.post("gradeDelete",{delIds:ids},function(result){
                        if(result.success){
                            $.messager.alert("System Alert","You have deleted<font color=red>"+result.delNums+"</font>");
                            $("#dg").datagrid("reload");
                        }else{
                            $.messager.alert('System Alert',result.errorMsg);
                        }
                    },"json");
                }
            });
        }

        function openGradeAddDialog(){
            $("#dlg").dialog("open").dialog("setTitle","Add Class Message");
            url="gradeSave";
        }

        function openGradeModifyDialog(){
            var selectedRows=$("#dg").datagrid('getSelections');
            if(selectedRows.length!=1){
                $.messager.alert("System Alert","Please Choose a message");
                return;
            }
            var row=selectedRows[0];
            $("#dlg").dialog("open").dialog("setTitle","Edit message");
            $("#fm").form("load",row);
            url="gradeSave?id="+row.id;
        }

        function closeGradeDialog(){
            $("#dlg").dialog("close");
            resetValue();
        }

        function resetValue(){
            $("#gradeName").val("");
            $("#gradeDesc").val("");
        }


        function saveGrade(){
            $("#fm").form("submit",{
                url:url,
                onSubmit:function(){
                    return $(this).form("validate");
                },
                success:function(result){
                    if(result.errorMsg){
                        $.messager.alert("System Alert",result.errorMsg);
                        return;
                    }else{
                        $.messager.alert("System Alert","Saved!");
                        resetValue();
                        $("#dlg").dialog("close");
                        $("#dg").datagrid("reload");
                    }
                }
            });
        }
    </script>
    <title>班级信息管理</title>
</head>
<body style="margin: 5px">
    <table id="dg" title="班级信息" class="easyui-datagrid" fitColumns="true" pagination ="true" rownumbers="true" url="gradeList" fit="true" toolbar="#tb">
        <thead>
        <tr>
            <th field="cb" checkbox="true"></th>
            <th field="id" width="50">ID</th>
            <th field="gradeName" width="100">Class Name</th>
            <th field="gradeDesc" width="250">Class Description</th>
        </tr>
        </thead>
    </table>
    <div id="tb">
        <div>
            <a href="javascript:openGradeAddDialog()" class="easyui-linkbutton" iconCls="icon-add" plain="true">Add</a>
            <a href="javascript:openGradeModifyDialog()" class="easyui-linkbutton" iconCls="icon-edit" plain="true">Edit</a>
            <a href="javascript:deleteGrade()" class="easyui-linkbutton" iconCls="icon-remove" plain="true">Delete</a>
        </div>
        <div>&nbsp;Class Description：&nbsp;<input type="text" name="s_gradeName" id="s_gradeName"/><a href="javascript:searchGrade()" class="easyui-linkbutton" iconCls="icon-search" plain="true">Search</a></div>
    </div>

    <div id="dlg" class="easyui-dialog" style="width: 400px;height: 280px;padding: 10px 20px"
         closed="true" buttons="#dlg-buttons">
        <form id="fm" method="post">
            <table>
                <tr>
                    <td>Class Name：</td>
                    <td><input type="text" name="gradeName" id="gradeName" class="easyui-validatebox" required="true"/></td>
                </tr>
                <tr>
                    <td valign="top">Class Description：</td>
                    <td><textarea rows="7" cols="30" name="gradeDesc" id="gradeDesc"></textarea></td>
                </tr>
            </table>
        </form>
    </div>

    <div id="dlg-buttons">
        <a href="javascript:saveGrade()" class="easyui-linkbutton" iconCls="icon-ok">Save</a>
        <a href="javascript:closeGradeDialog()" class="easyui-linkbutton" iconCls="icon-cancel">Close</a>
    </div>
</body>
</html>
