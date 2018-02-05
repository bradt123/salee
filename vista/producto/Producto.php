<?php
/**
*@package pXP
*@file gen-Producto.php
*@author  (admin)
*@date 26-12-2017 13:27:49
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.Producto=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.Producto.superclass.constructor.call(this,config);
		this.init();
		this.load({params:{start:0, limit:this.tam_pag}})
		
		/*copiar this.Button('sig.estado') de skype*/
		
	},
	//sigEstado:funciont() va aqui
	//preparaMenu:function() para desactivar y activar el menu va aqui depues 
	//llamada al metodo onSaveWizard  de pues del anterior 
	//sis_salee/control/Salee/siguienteEstadoSalee
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_producto'
			},
			type:'Field',
			form:true 
		},
		{
			config: {
				inputType:'hidden',
				name: 'id_marca',
				fieldLabel: 'id_marca',
				
			},
			type: 'Field',
			id_grupo: 0,
			form: true
		},
		

		{
			config: {
				name: 'id_categoria',
				fieldLabel: 'id_categoria',
				allowBlank: true,
				emptyText: 'Elija una opción...',
				store: new Ext.data.JsonStore({
					url: '../../sis_salee/control/Categoria/listarCategoria',
					id: 'id_categoria',
					root: 'datos',
					sortInfo: {
						field: 'nombre',
						direction: 'ASC'
					},
					totalProperty: 'total',
					fields: ['id_categoria', 'nombre'],
					remoteSort: true,
					baseParams: {par_filtro: 'cat.nombre'}
				}),
				valueField: 'id_categoria',
				displayField: 'nombre',
				gdisplayField: 'desc_categoria',
				hiddenName: 'id_categoria',
				forceSelection: true,
				typeAhead: false,
				triggerAction: 'all',
				lazyRender: true,
				mode: 'remote',
				pageSize: 15,
				queryDelay: 1000,
				anchor: '100%',
				gwidth: 150,
				minChars: 2,
				renderer : function(value, p, record) {
					return String.format('{0}', record.data['desc_categoria']);
				}
			},
			type: 'ComboBox',
			id_grupo: 0,
			filters: {pfiltro: 'cat.nombre',type: 'string'},
			grid: true,
			form: true
		},
				{
			config:{
				name: 'descripcion',
				fieldLabel: 'descripcion',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:50
			},
				type:'TextField',
				filters:{pfiltro:'pro.descripcion',type:'string'},
				id_grupo:1,
				grid:true,
				form:true
		},
		{
			config:{
				name: 'estado_reg',
				fieldLabel: 'Estado Reg.',
				inputType:'hidden',
				//allowBlank:true,
				//anchor: '80%',
				//gwidth: 100,
				//maxLength:10
			},
				type:'TextField',
				//filters:{pfiltro:'pro.estado_reg',type:'string'},
				//id_grupo:1,
				//grid:true,
				form:false
		},
		{
			config: {
				name: 'stock',
				fieldLabel: 'stock',
				allowBlank:true,
				anchor: '80%',
				gwidth: 100,
				maxLength:300
				
			},
			type: 'Field',
			id_grupo: 0,
			grid:true,
			form: true
		},
		{
			config:{
				name: 'nombre',
				fieldLabel: 'nombre',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:50
			},
				type:'TextField',
				filters:{pfiltro:'pro.nombre',type:'string'},
				id_grupo:1,
				grid:true,
				form:true
		},
		{
			config:{
				name: 'id_usuario_ai',
				fieldLabel: '',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
				type:'Field',
				filters:{pfiltro:'pro.id_usuario_ai',type:'numeric'},
				id_grupo:1,
				grid:false,
				form:false
		},
		{
			config:{
				name: 'usr_reg',
				fieldLabel: 'Creado por',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
				type:'Field',
				filters:{pfiltro:'usu1.cuenta',type:'string'},
				id_grupo:1,
				grid:true,
				form:false
		},
		{
			config:{
				name: 'fecha_reg',
				fieldLabel: 'Fecha creación',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
							format: 'd/m/Y', 
							renderer:function (value,p,record){return value?value.dateFormat('d/m/Y H:i:s'):''}
			},
				type:'DateField',
				filters:{pfiltro:'pro.fecha_reg',type:'date'},
				id_grupo:1,
				grid:true,
				form:false
		},
		{
			config:{
				name: 'usuario_ai',
				fieldLabel: 'Funcionaro AI',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:300
			},
				type:'TextField',
				filters:{pfiltro:'pro.usuario_ai',type:'string'},
				id_grupo:1,
				grid:true,
				form:false
		},
		{
			config:{
				name: 'usr_mod',
				fieldLabel: 'Modificado por',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
				type:'Field',
				filters:{pfiltro:'usu2.cuenta',type:'string'},
				id_grupo:1,
				grid:true,
				form:false
		},
		{
			config:{
				name: 'fecha_mod',
				fieldLabel: 'Fecha Modif.',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
							format: 'd/m/Y', 
							renderer:function (value,p,record){return value?value.dateFormat('d/m/Y H:i:s'):''}
			},
				type:'DateField',
				filters:{pfiltro:'pro.fecha_mod',type:'date'},
				id_grupo:1,
				grid:true,
				form:false
		}
	],
	tam_pag:50,	
	title:'Producto',
	ActSave:'../../sis_salee/control/Producto/insertarProducto',
	ActDel:'../../sis_salee/control/Producto/eliminarProducto',
	ActList:'../../sis_salee/control/Producto/listarProducto',
	id_store:'id_producto',
	fields: [
		{name:'id_producto', type: 'numeric'},
		{name:'id_marca', type: 'numeric'},
		{name:'descripcion', type: 'string'},
		{name:'id_categoria', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'nombre', type: 'string'},
		{name:'id_usuario_ai', type: 'numeric'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'usuario_ai', type: 'string'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		{name:'desc_categoria', type: 'string'},
		{name:'stock', type: 'numeric'}
		
	],
	sortInfo:{
		field: 'id_producto',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true,
	
	/*auemtado video2*/
	onReloadPage:function(m){
		this.maestro=m,
		this.store.baseParams={id_marca:this.maestro.id_marca};
		this.load({params:{start:0,limit:50}});
	},
	loadValoresIniciales:function()
	{
		Phx.vista.Producto.superclass.loadValoresIniciales.call(this);
		this.getComponente('id_marca').setValue(this.maestro.id_marca);
	},
	/*aumetado video 3*/
		east:{
		url:'../../../sis_salee/vista/movimiento/Movimiento.php',
		title:'Movimiento',
		width:'50%',
		cls:'Movimiento'
	 }
}
)
</script>
		
		