<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
    $(function () {
       $('#form-add-dev-plan').submit(function () {
           var url = '/html/~sale/devPlan-add';
           var data = $(this).serialize(); //将表单序列化  属性=值&属性=值
           /*table-add-Plan*/
           $.post(url,data,function (s) {
                   var date = new Date(s.creationTime);
                   Y = date.getFullYear() + '/';
                   M = (date.getMonth()+1 < 10 ? '0'+(date.getMonth()+1) : date.getMonth()+1) + '/';
                   D = date.getDate() + ' ';
                   h = date.getHours() + ':';
                   m = date.getMinutes() + ':';
                   s2 = date.getSeconds();
                   var createDate = (Y+M+D+h+m+s2);
                   $('#form-add-dev-plan')[0].reset();
               var tr =
                   '<tr>' +
                       '<td>'+createDate+'</td>'+
                       '<td>'+s.process+'</td>'+
                       '<td>'+
                           '<button class="btn btn-xs btn-default btn-plan-del" data-del-plan="'+s.id+'">\n' +
                               '<div class="text-danger">\n' +
                                   '<span class="glyphicon glyphicon-remove"></span>\n' +
                                   '<span class="hidden-xs">删除</span>\n' +
                               '</div>\n' +
                           '</button>' +
                       '</td>'+
                   '</tr>';
               $('#table-add-Plan tbody').prepend(tr);
           },
           'json');
           return false;
       });

        //删除
        $(document).on('click','[data-del-plan]',function () {
           var id = $(this).data('del-plan');
           var url = '/html/~sale/dev-del-plan-'+id;
            var del_btn = $(this);
           $.get(url, function () {
                $(del_btn).parents('tr').slideUp('fast', function () {
                    $(this).remove(2000);
                });
            });

        });
    });
</script>

<div class="modal-header">
    <button class="close btn" data-dismiss="modal">
        <span class="glyphicon glyphicon-remove"></span>
    </button>
    <h3 class="modal-title">
        制定客户开发计划【<span class="text-primary">${salesOpportunity.customerName}</span>】
    </h3>
</div>
<div class="modal-body">
    <div>
        <!--开发计划及执行情况部分-->
        <table data-name="plan" class="table table-condensed" id="table-add-Plan">
            <thead>
            <tr class="bg-info">
                <th>计划日期</th>
                <th>计划内容</th>
                <th>执行结果&amp;操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${salesPlans}" var="s">
                <f:formatDate value="${s.creationTime}" var="createDate" pattern="yyyy/MM/dd HH:mm:ss"/>
                <f:formatDate value="${s.processTime}" var="processTime" pattern="yyyy/MM/dd HH:mm:ss"/>
                <tr>
                    <td>${createDate}</td>
                    <td>${s.process}</td>
                    <td>
                        <c:if test="${s.result == null}">
                            <button class="btn btn-xs btn-default btn-plan-del" data-del-plan="${s.id}">
                                <div class="text-danger">
                                    <span class="glyphicon glyphicon-remove"></span>
                                    <span class="hidden-xs">删除</span>
                                </div>
                            </button>
                        </c:if>
                        <c:if test="${s.result != null}">
                            <span class="text-primary">[${processTime}]</span>
                            <span class="hidden-xs">${s.result}</span>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>

        <form id="form-add-dev-plan" method="post" class="form-horizontal">
            <input name="opportunityId" value="${salesOpportunity.id}" type="hidden">
            <table data-name="new-plan" class="table table-condensed">
                <tr>
                    <td class="container-fluid">
                        <div class="row">
                            <div class="col-xs-4">
                                <input type="datetime-local" class="form-control" required="required" name="creationTime"/>
                            </div>
                            <div class="col-xs-8">
                                <input name="process" class="form-control" required="required"/>
                            </div>
                        </div>
                    </td>
                    <td>
                        <button class="btn btn-primary" title="新增开发计划">
                            <span class="glyphicon glyphicon-plus"></span>
                            <span class="hidden-xs">新增开发计划</span>
                        </button>
                    </td>
                </tr>
            </table>
        </form>

    </div>
</div>
<div class="modal-footer">
    <button class="btn btn-default" type="button" data-dismiss="modal">
        <span class="glyphicon glyphicon-remove"></span>
        关闭
    </button>
</div>
