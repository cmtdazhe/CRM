<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script type="text/javascript">
    $(function () {
       $(document).on('click','[data-order-show]',function () {
          var orderId = $(this).data('order-show');
          var url = '/html/~order/to-show-'+orderId;
          var tr = "";
          $.getJSON(url,function (orderLines) {
              var totals = 0;
              var money = 0;
              for(i=0;i<orderLines.length;i++){
                  var order = orderLines[i];
                  tr += '<tr>';
                  tr += '<td>'+order.productName+'</td>';
                  tr += '<td>'+order.unit+'</td>';
                  tr += '<td>'+order.totals+'</td>';
                  tr += '<td>￥'+order.price+'.00</td>';
                  tr += '<td>￥'+order.money+'.00</td>';
                  tr += '</tr>';
                  totals = order.totals+totals;
                  money = order.money+money;
              }
              $('#totals-'+orderId).html(totals);
              $('#money-'+orderId).html("￥"+money+".00");
              $('#tbodys-'+orderId).html(tr);
          });
          $("#order-table-"+orderId).toggle(500);
       });
    });


</script>
<div class="modal-header">
    <button class="close" data-dismiss="modal">
        <span class="glyphicon glyphicon-remove"></span>
    </button>
    <h3 class="modal-title">
        ${cu.name}
        <small>${cu.id}</small>
    </h3>
</div>

<div class="modal-body mulit-panel-body">
    <ul class="nav nav-tabs">
        <li class="active">
            <a href="#tab-info" data-toggle="tab">信息</a>
        </li>
        <li>
            <a href="#tab-linkman" data-toggle="tab">联系人</a>
        </li>
        <li>
            <a href="#tab-activity" data-toggle="tab">交往记录</a>
        </li>
        <li>
            <a href="#tab-order" data-toggle="tab">历史订单</a>
        </li>
    </ul>

    <div class="tab-content">
        <div class="tab-pane fade in active" id="tab-info">
            <!--基础信息部分-->
            <table class="table table-condensed">
                <tr>
                    <th class="bg-info text-right">编号</th>
                    <td>${cu.id}</td>
                    <th class="bg-info text-right">名称</th>
                    <td>${cu.name}</td>
                </tr>
                <tr>
                    <th class="bg-info text-right">地区</th>
                    <td>${cu.region}</td>
                    <th class="bg-info text-right">客户经理</th>
                    <td>${cu.user.name}</td>
                </tr>
                <tr>
                    <th class="bg-info text-right">等级</th>
                    <td>${cu.level}</td>
                    <th class="bg-info text-right">信用度</th>
                    <td>
                        <span class="text-success">${cu.credit}</span>
                    </td>
                </tr>
                <tr>
                    <th class="bg-info text-right">满意度</th>
                    <td colspan="3">
                        <span class="text-success">${cu.satisfy}</span>
                    </td>
                </tr>
                <tr>
                    <td colspan="4">&nbsp;</td>
                </tr>
                <tr>
                    <th class="bg-info text-right">地址</th>
                    <td>${cu.address}</td>
                    <th class="bg-info text-right">邮编</th>
                    <td>${cu.zip}</td>
                </tr>
                <tr>
                    <th class="bg-info text-right">电话</th>
                    <td>${cu.tel}</td>
                    <th class="bg-info text-right">传真</th>
                    <td>${cu.fax}</td>
                </tr>
                <tr>
                    <th class="bg-info text-right">主页</th>
                    <td colspan="3">${cu.website}</td>
                </tr>
                <tr>
                    <td colspan="4">&nbsp;</td>
                </tr>
                <tr>
                    <th class="bg-info text-right">营业执照注册号</th>
                    <td>${cu.licenceNo}</td>
                    <th class="bg-info text-right">法人</th>
                    <td>${cu.chieftain}</td>
                </tr>
                <tr>
                    <th class="bg-info text-right">注册资金(万元)</th>
                    <td>￥${cu.bankroll}.00</td>
                    <th class="bg-info text-right">年营业额(万元)</th>
                    <td>￥${cu.turnover}.00</td>
                </tr>
                <tr>
                    <th class="bg-info text-right">开户银行</th>
                    <td>${cu.bank}</td>
                    <th class="bg-info text-right">银行账号</th>
                    <td>${cu.bankAccount}</td>
                </tr>
                <tr>
                    <th class="bg-info text-right">地税登记号</th>
                    <td>${cu.localTaxNo}</td>
                    <th class="bg-info text-right">国税登记号</th>
                    <td>${cu.nationalTaxNo}</td>
                </tr>
            </table>

        </div>

        <div class="tab-pane fade" id="tab-linkman">
            <!--联系人部分-->
            <table class="table table-condensed">
                <thead>
                <tr class="bg-info">
                    <th>姓名</th>
                    <th class="hidden-xs">性别</th>
                    <th>职位</th>
                    <th class="hidden-xs">办公电话</th>
                    <th class="hidden-xs">移动电话</th>
                    <th class="visible-xs">联系电话</th>
                    <th class="hidden-xs">备注</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${ln}" var="l">
                    <tr>
                        <td>${l.name}</td>
                        <td class="hidden-xs">${l.sex}</td>
                        <td>${l.job}</td>
                        <td class="hidden-xs">0730-${l.tel}-110</td>
                        <td class="hidden-xs">${l.tel}</td>
                        <td class="visible-xs">
                            010-68348438-668
                            <br />13622883228
                        </td>
                        <td class="hidden-xs">${l.remark}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>

        </div>

        <div class="tab-pane fade" id="tab-activity">
            <!--交往记录部分-->
            <table class="table table-hover table-condensed">
                <thead>
                <tr class="bg-info">
                    <th>时间</th>
                    <th>主题</th>
                    <th>地点</th>
                    <th>详细信息</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${as}" var="a">
                    <f:formatDate value="${a.creationTime}" var="createDate" pattern="yyyy/MM/dd"/>
                    <tr>
                        <td>${createDate}</td>
                        <td>${a.title}</td>
                        <td>${a.place}</td>
                        <td>${a.remark}</td>
                    </tr>
                </c:forEach>

                </tbody>
            </table>

        </div>

        <div class="tab-pane fade" id="tab-order">
            <!--历史订单部分-->
            <table class="table table-hover">
                <thead>
                <tr class="bg-info">
                    <th>#</th>
                    <th>日期</th>
                    <th>送货地址</th>
                    <th>状态</th>
                    <th>查看</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${orders}" var="o">
                    <f:formatDate value="${o.creationTime}" var="createDate" pattern="yyyy/MM/dd HH:mm:ss"/>
                    <tr>
                        <td>${o.id}</td>
                        <td>
                            <span class="hidden-xs">${createDate}</span>
                        </td>
                        <td>${o.address}</td>
                        <c:if test="${o.status==0}">
                        <td class="text-warning">未回款</td>
                        </c:if>
                        <c:if test="${o.status==1}">
                            <td class="text-danger">已发货</td>
                        </c:if>
                        <c:if test="${o.status==2}">
                        <td class="text-success">已回款</td>
                        </c:if>
                        <td>
                            <button class="btn btn-xs btn-default" data-order-show="${o.id}">
                                <span class="glyphicon glyphicon-zoom-in"></span>
                                <span class="hidden-xs">查看</span>
                            </button>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="5" class="order-table-parent-td">
                            <div class="collapse" id="order-table-${o.id}">
                                <table class="table table-bordered table-condensed">
                                    <thead>
                                    <tr class="bg-info">
                                        <th>商品</th>
                                        <th>单位</th>
                                        <th>数量</th>
                                        <th>单价(元)</th>
                                        <th>金额(元)</th>
                                    </tr>
                                    </thead>
                                    <tbody id="tbodys-${o.id}">

                                    </tbody>
                                    <tfoot>
                                    <tr>
                                        <th colspan="2" align="right">合计</th>
                                        <td id="totals-${o.id}"></td>
                                        <td></td>
                                        <td id="money-${o.id}"></td>
                                    </tr>
                                    </tfoot>
                                </table>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>

        </div>

    </div>

</div>

<div class="modal-footer">
    <button class="btn btn-default" type="button" data-dismiss="modal">
        <span class="glyphicon glyphicon-remove"></span>
        关闭
    </button>
</div>
