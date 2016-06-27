<%--
  Created by IntelliJ IDEA.
  User: apple6268
  Date: 16. 3. 27
  Time: 오후 11:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<form class="form-horizontal static" role="form" action="/file" method="post" enctype="multipart/form-data">
    파일첨부 1 : <input type="file" name="file1" />
    <br />
    파일첨부 2 : <input type="file" name="file2" />
    <br />
    파일첨부 3 : <input type="file" name="file3" />
    <br />
    <input type="submit" value="upload" />
</form>



