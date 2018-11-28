<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-header">
    <button class="close" data-dismiss="modal">
        <span class="glyphicon glyphicon-remove"></span>
    </button>
    <h3 class="modal-title">
        客户信息
        <div class="visible-xs"></div>
        <small>${cu.name}</small>
    </h3>
</div>

<div class="modal-body">

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

<div class="modal-footer">
    <button class="btn btn-default" type="button" data-dismiss="modal">
        <span class="glyphicon glyphicon-remove"></span>
        关闭
    </button>
</div>
