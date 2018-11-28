<%@ page language="java" pageEncoding="utf-8" contentType="text/html;charset=UTF-8" %>
<%@taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
    $(function () {
       $('#form-add-exec').submit(function () {
          var url = "/html/~cust/add-serviceProcess";
          var data = $(this).serialize(); //将表单序列化  属性=值&属性=值
          $.post(url,data,function (s) {
              var date = new Date(s.creationTime);
              Y = date.getFullYear() + '/';
              M = (date.getMonth()+1 < 10 ? '0'+(date.getMonth()+1) : date.getMonth()+1) + '/';
              D = date.getDate() + ' ';
              h = date.getHours() + ':';
              m = date.getMinutes() + ':';
              s2 = date.getSeconds();
              var processDate = (Y+M+D+h+m+s2);
              var tr=
                  '<tr>\n' +
                      '<td>'+processDate+'</td>\n' +
                      '<td>'+s.process+'</td>\n' +
                      '<td>'+s.result+'</td>\n' +
                      '<td>\n' +
                          '<div class="text-success">'+s.satisfy+'</div>\n' +
                      '</td>\n' +
                  '</tr>';
              $('#table-add-serviceProcess tbody').prepend(tr);
          },'json');
          return false;
       });
    });
</script>
<div class="modal-header">
    <button class="close" data-dismiss="modal">
        <span class="glyphicon glyphicon-remove"></span>
    </button>
    <h3 class="modal-title">
        处理服务
        <div class="visible-xs"></div>
        <small>[${services.type}]-${services.cuName}</small>

    </h3>
</div>

<div class="modal-body">
    <table class="table table-condensed">
        <tr>
            <th class="bg-info" align="right">客户名称</th>
            <td>${services.cuName}</td>
            <th class="bg-info" align="right">概要</th>
            <td>${services.title}</td>
        </tr>
        <tr>
            <th class="bg-info" align="right">类型</th>
            <td>${services.type}</td>
            <th class="bg-info" align="right">分配状态</th>
            <td>
                <span class="text-success">${services.status eq 0 ?'未分配':'已分配'}</span>
            </td>
        </tr>
        <tr>
            <th class="bg-info" align="right">分配人员</th>
            <td>${user.name}</td>
            <th class="bg-info" align="right">分配时间</th>
            <td>
                <div class="visible-xs"></div>
                <f:formatDate value="${services.assignTime}" var="time" pattern="yyyy-MM-dd HH:ss:mm"/>
                ${time}
            </td>
        </tr>
    </table>

    <hr/>

    <form class="panel panel-success" id="form-add-exec">
        <input type="hidden" name="serviceId" value="${services.id}">
        <div class="panel-heading">
            <h4 class="panel-title">
                新增处理
                <button class="btn btn-xs btn-primary">
                    <span class="glyphicon glyphicon-plus"></span>
                    新增处理
                </button>
            </h4>
        </div>
        <div class="panel-body">
            <div class="container-fluid">
                <div class="row">
                    <div class="form-group form-group-sm col-md-6">
                        <label class="col-md-3 control-label">处理内容</label>
                        <div class="col-md-9">
                            <textarea class="form-control" required="required" name="process"></textarea>
                        </div>
                    </div>
                    <div class="form-group form-group-sm col-md-6">
                        <label class="col-md-3 control-label">处理结果</label>
                        <div class="col-md-9">
                            <textarea class="form-control" required="required" name="result"></textarea>
                        </div>
                    </div>
                    <div class="form-group form-group-sm col-md-6">
                        <label class="col-md-3 control-label">满意度</label>
                        <div class="col-md-9">
                            <select class="form-control" name="satisfy">
                                <option value="0">未指定</option>
                                <option value="★★★★★" class="bg-success">★★★★★</option>
                                <option value="★★★★" class="bg-info">★★★★</option>
                                <option value="★★★" class="bg-warning">★★★</option>
                                <option value="★★" class="bg-danger">★★</option>
                                <option value="★" class="bg-danger">★</option>
                            </select>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>

    <hr/>

    <div class="panel panel-info">
        <div class="panel-heading">
            <h4 class="panel-title">
                处理历史记录
                <a href=".table-exec" class="btn btn-xs btn-default" data-toggle="collapse">
                    <span class="glyphicon glyphicon-zoom-in"></span>
                    查看
                </a>
            </h4>
        </div>
        <div class="table-exec panel-collapse collapse">
            <div class="panel-body">
                <table class="table table-hover table-condensed" id="table-add-serviceProcess">
                    <thead>
                    <tr class="bg-info">
                        <th>时间</th>
                        <th>处理详细</th>
                        <th>处理结果</th>
                        <th>满意度</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${serviceProcesses}" var="ser">
                        <f:formatDate value="${ser.creationTime}" var="createDate" pattern="yyyy/MM/dd HH:mm:ss"/>
                        <tr>
                            <td>${createDate}</td>
                            <td>${ser.process}</td>
                            <td>${ser.result}</td>
                            <td>
                                <div class="text-success">
                                   ${ser.satisfy}
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

</div>

<div class="modal-footer">
    <button class="btn btn-default" type="button" data-dismiss="modal">
        <span class="glyphicon glyphicon-remove"></span>
        关闭
    </button>
</div>