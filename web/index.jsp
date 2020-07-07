
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <meta charset="utf-8">
  <link rel="stylesheet" href="css/style.css" />
  <link rel="stylesheet" href="css/iconfont.css" />
  <title>登录界面</title>
</head>
<body>
<div id="bigBox">
  <form action="login" method="post">
  <h1>LOGIN</h1>
  <div class="inputBox">
    <div class="inputText">
      <span class="iconfont icon-nickname"></span>
      <input type="text" placeholder="username" name ="userName" id="userName"/>
    </div>
    <div class="inputText">
      <span class="iconfont icon-visible"></span>
      <input type="password" placeholder="password" name="password" id="password"/>
    </div>
  </div>
  <input class="loginButton" type="submit" value="Login" />
  </form>
</div>
</body>
</html>
