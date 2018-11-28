<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<form class="modal-content" id="form-edit" method="post" action="/html/~customer/edit">
    <div class="modal-header">
        <button class="close" data-dismiss="modal">
            <span class="glyphicon glyphicon-remove"></span>
        </button>
        <h3 class="modal-title">
            客户信息
            <div class="visible-xs"></div>
            <small>${customer.name}</small>
        </h3>
    </div>
    <div class="modal-body">
        <div class="form-horizontal">
            <div class="form-group col-md-6">
                <label class="col-xs-3 col-md-2 control-label">编号</label>
                <div class="col-xs-9 col-md-10">
                    <input class="form-control" value="${customer.id}" hidefocus="false" readonly="readonly" name="id"/>
                </div>
            </div>
            <div class="form-group col-md-6">
                <label class="col-xs-3 col-md-2 control-label">名称</label>
                <div class="col-xs-9 col-md-10">
                    <input class="form-control" value="${customer.name}" required="required" autofocus="autofocus" name="name"/>
                </div>
            </div>

            <div class="form-group col-md-6">
                <label class="col-xs-4 col-md-3 control-label">地区</label>
                <div class="col-xs-8 col-md-9">
                    <select class="form-control" required="required" name="region">
                        <option value="">请选择...</option>
                        <option value="北京" <c:if test="${customer.region=='北京'}">selected="selected"</c:if> >北京</option>
                        <option value="华北地区" <c:if test="${customer.region=='华北地区'}">selected="selected"</c:if>>华北</option>
                        <option value="华东地区" <c:if test="${customer.region=='华东地区'}">selected="selected"</c:if>>华东</option>
                        <option value="华中地区" <c:if test="${customer.region=='华中地区'}">selected="selected"</c:if>>华中</option>
                        <option value="华南地区" <c:if test="${customer.region=='华南地区'}">selected="selected"</c:if>>华南</option>
                        <option value="西部地区" <c:if test="${customer.region=='西部地区'}">selected="selected"</c:if>>西部</option>
                    </select>
                </div>
            </div>

            <div class="form-group col-md-6">
                <label class="col-xs-4 col-md-3 control-label">客户经理</label>
                <div class="col-xs-8 col-md-9">
                    <select class="form-control" required="required" name="userId">
                        <option value="">请选择...</option>
                        <c:forEach items="${users}" var="u">
                            <option value="${u.id}" ${u.id eq customer.userId?'selected="selected"':''}>${u.name}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <div class="form-group col-md-6">
                <label class="col-xs-4 col-md-3 control-label">信用度</label>
                <div class="col-xs-8 col-md-9">
                    <select class="form-control" required="required" name="credit">
                        <option value="">未指定</option>
                        <option value="★★★★★" <c:if test="${customer.credit=='★★★★★'}">selected="selected"</c:if>>★★★★★</option>
                        <option value="★★★★" <c:if test="${customer.credit=='★★★★'}">selected="selected"</c:if>>★★★★</option>
                        <option value="★★★" <c:if test="${customer.credit=='★★★'}">selected="selected"</c:if>>★★★</option>
                        <option value="★★" <c:if test="${customer.credit=='★★'}">selected="selected"</c:if>>★★</option>
                        <option value="★" <c:if test="${customer.credit=='★'}">selected="selected"</c:if>>★</option>
                    </select>
                    </select>
                </div>
            </div>

            <div class="form-group col-md-6">
                <label class="col-xs-4 col-md-3 control-label">等级</label>
                <div class="col-xs-8 col-md-9">
                    <select class="form-control" required="required" name="level">
                        <option value="">请选择...</option>
                        <option value="战略合作伙伴" <c:if test="${customer.level=='战略合作伙伴'}">selected="selected"</c:if>>战略合作伙伴</option>
                        <option value="合作伙伴" <c:if test="${customer.level=='合作伙伴'}">selected="selected"</c:if>>合作伙伴</option>
                        <option value="大客户" <c:if test="${customer.level=='大客户'}">selected="selected"</c:if>>大客户</option>
                        <option value="重点开发客户" <c:if test="${customer.level=='重点开发客户'}">selected="selected"</c:if>>重点开发客户</option>
                        <option value="普通客户" <c:if test="${customer.level=='普通客户'}">selected="selected"</c:if>>普通客户</option>
                    </select>
                </div>
            </div>

            <div class="form-group col-md-6">
                <label class="col-xs-4 col-md-3 control-label">满意度</label>
                <div class="col-xs-8 col-md-9">
                    <select class="form-control" required="required" name="satisfy">
                        <option value="">未指定</option>
                        <option value="☆☆☆☆☆" <c:if test="${customer.satisfy=='☆☆☆☆☆'}">selected="selected"</c:if>>☆☆☆☆☆</option>
                        <option value="☆☆☆☆" <c:if test="${customer.satisfy=='☆☆☆☆'}">selected="selected"</c:if>>☆☆☆☆</option>
                        <option value="☆☆☆" <c:if test="${customer.satisfy=='☆☆☆'}">selected="selected"</c:if>>☆☆☆</option>
                        <option value="☆☆" <c:if test="${customer.satisfy=='☆☆'}">selected="selected"</c:if>>☆☆</option>
                        <option value="☆" <c:if test="${customer.satisfy=='☆'}">selected="selected"</c:if>>☆</option>
                    </select>
                    </select>
                </div>
            </div>
        </div>
        <div class="clearfix"></div>
        <hr/>
        <div class="form-horizontal">

            <div class="form-group col-md-6">
                <label class="col-xs-3 col-md-2 control-label">地址</label>
                <div class="col-xs-9 col-md-10">
                    <input class="form-control" value="${customer.address}" name="address" />
                </div>
            </div>
            <div class="form-group col-md-6">
                <label class="col-xs-3 col-md-2 control-label">邮编</label>
                <div class="col-xs-9 col-md-10">
                    <input class="form-control" value="${customer.zip}" name="zip" />
                </div>
            </div>
            <div class="form-group col-md-6">
                <label class="col-xs-3 col-md-2 control-label">电话</label>
                <div class="col-xs-9 col-md-10">
                    <input class="form-control" value="${customer.tel}" name="tel" type="tel" />
                </div>
            </div>
            <div class="form-group col-md-6">
                <label class="col-xs-3 col-md-2 control-label">传真</label>
                <div class="col-xs-9 col-md-10">
                    <input class="form-control" value="${customer.fax}" name="fax" type="tel" />
                </div>
            </div>
            <div class="form-group col-md-6">
                <label class="col-xs-3 col-md-2 control-label">主页</label>
                <div class="col-xs-9 col-md-10">
                    <input class="form-control" value="${customer.website}" name="website" type="url" />
                </div>
            </div>
        </div>
        <div class="clearfix"></div>
        <hr />
        <div class="form-horizontal">

            <div class="form-group col-md-6">
                <label class="col-xs-6 col-md-4 control-label">营业执照注册号</label>
                <div class="col-xs-6 col-md-8">
                    <input class="form-control" value="${customer.licenceNo}" name="licenceNo" />
                </div>
            </div>
            <div class="form-group col-md-6">
                <label class="col-xs-5 col-md-4 control-label">法人</label>
                <div class="col-xs-7 col-md-8">
                    <input class="form-control" value="${customer.chieftain}" name="chieftain" />
                </div>
            </div>
            <div class="form-group col-md-6">
                <label class="col-xs-5 col-md-4 control-label">注册资金(万元)</label>
                <div class="col-xs-7 col-md-8">
                    <input class="form-control" value="${customer.bankroll}" name="bankroll" type="number" />
                </div>
            </div>
            <div class="form-group col-md-6">
                <label class="col-xs-5 col-md-4 control-label">年营业额(万元)</label>
                <div class="col-xs-7 col-md-8">
                    <input class="form-control" value="${customer.turnover}" name="turnover" type="number" />
                </div>
            </div>
            <div class="form-group col-md-6">
                <label class="col-xs-5 col-md-4 control-label">开户银行</label>
                <div class="col-xs-7 col-md-8">
                    <input class="form-control" value="${customer.bank}" name="bank" />
                </div>
            </div>
            <div class="form-group col-md-6">
                <label class="col-xs-5 col-md-4 control-label">银行账号</label>
                <div class="col-xs-7 col-md-8">
                    <input class="form-control" value="${customer.bankAccount}" name="bankAccount" />
                </div>
            </div>
            <div class="form-group col-md-6">
                <label class="col-xs-5 col-md-4 control-label">地税登记号</label>
                <div class="col-xs-7 col-md-8">
                    <input class="form-control" value="${customer.localTaxNo}" name="localTaxNo" />
                </div>
            </div>
            <div class="form-group col-md-6">
                <label class="col-xs-5 col-md-4 control-label">国税登记号</label>
                <div class="col-xs-7 col-md-8">
                    <input class="form-control" value="${customer.nationalTaxNo}" name="nationalTaxNo" />
                </div>
            </div>
        </div>
        <div class="clearfix"></div>
    </div>
    <div class="modal-footer">
        <button class="btn btn-default" type="button" data-dismiss="modal">
            <span class="glyphicon glyphicon-remove"></span>
            关闭
        </button>
        <button class="btn btn-primary" type="submit">
            <span class="glyphicon glyphicon-save"></span>
            更新
        </button>
    </div>
</form>
