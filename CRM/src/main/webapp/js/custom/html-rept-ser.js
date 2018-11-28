var data = [{
		name: '咨询',
		value: 100,
		color: '#4572a7'
	},
	{
		name: '投诉',
		value: 3,
		color: '#aa4643'
	},
	{
		name: '建议',
		value: 50,
		color: '#89a54e'
	}
];

$(function() {

	var chart = new iChart.Pie3D({
		render: 'canvasDiv',
		data: data,
		title: {
			text: '客户服务分析报表',
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
	//利用自定义组件构造右侧说明文本
	chart.plugin(new iChart.Custom({
		drawFn: function() {
			//计算位置
			//			var y = chart.get('originy'),
			//				w = chart.get('width');

			var y = 80;
			//在右侧的位置，渲染说明文字
			chart.target.textAlign('start')
				.textBaseline('middle')
				.textFont('600 16px Verdana')
				.fillText('咨询：100', 5, y, false, '#4572a7', false, 20)
				.fillText('投诉：3', 5, y += 25, false, '#aa4643', false, 20)
				.fillText('建议：50', 5, y += 25, false, '#89a54e', false, 20);
		}
	}));

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