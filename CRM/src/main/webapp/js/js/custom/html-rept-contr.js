var data = [{
		name: '聪海信息科技有限公司',
		value: 12345.00,
		color: '#4572a7'
	},
	{
		name: '北京明科科技有限公司',
		value: 45678.00,
		color: '#aa4643'
	},
	{
		name: '太阳药业',
		value: 90123.00,
		color: '#89a54e'
	},
	{
		name: '云南天河烟草公司	',
		value: 45678.00,
		color: '#80699b'
	},
	{
		name: '北京天桥信息技术有限公司',
		value: 93543.00,
		color: '#a47d7c'
	}
];

$(function() {

	var chart = new iChart.Pie3D({
		render: 'canvasDiv',
		data: data,
		title: {
			text: '客户贡献分析报表',
			color: '#3e576f'
		},
		footnote: {
			text: '华瑞IT教育 2018',
			color: '#486c8f',
			fontsize: 11,
			padding: '0 38'
		},
		bound_event: null,
		sub_option: {
			label: {
				background_color: null,
				sign: false, //设置禁用label的小图标
				padding: '0 4',
				border: {
					enable: false,
					color: '#be5985'
				},
				fontsize: 11,
				fontweight: 600,
				color: '#000'
			},
			border: {
				width: 2,
				color: '#ffffff'
			}
		},
		shadow: true,
		shadow_blur: 6,
		shadow_color: '#aaaaaa',
		shadow_offsetx: 0,
		shadow_offsety: 0,
		//background_color: '#fefefe',
		yHeight: 80, //饼图厚度
		offsety: 50, //设置向y轴负方向偏移位置
//		offsetx: 100, //设置向x轴负方向偏移位置
		offset_angle: 120, //逆时针偏移角度
		mutex: true, //只允许一个扇形弹出
		showpercent: true,
		decimalsnum: 2,
		width: $('#canvasDiv').innerWidth(),
		height: 400,
		radius: 150
	});

	chart.draw();

	var tid = 0;
	$(window).resize(function() {
		if(tid != 0) {
			window.clearTimeout(tid);
		}
		tid = window.setTimeout(function() {
			chart.resize($('#canvasDiv').innerWidth(), 400);
		}, 500);

	});
});