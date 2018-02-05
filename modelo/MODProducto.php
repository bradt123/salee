<?php
/**
*@package pXP
*@file gen-MODProducto.php
*@author  (admin)
*@date 26-12-2017 13:27:49
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODProducto extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarProducto(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='sal.ft_producto_sel';
		$this->transaccion='SAL_PRO_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_producto','int4');
		$this->captura('id_marca','int4');
		$this->captura('descripcion','varchar');
		$this->captura('id_categoria','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('nombre','varchar');
		$this->captura('id_usuario_ai','int4');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('usuario_ai','varchar');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		/*aumentado video2*/
		$this->captura('desc_categoria','varchar');
		/*aumentado vide3*/
		$this->captura('stock','int4');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarProducto(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='sal.ft_producto_ime';
		$this->transaccion='SAL_PRO_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_marca','id_marca','int4');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('id_categoria','id_categoria','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('nombre','nombre','varchar');
		/*aumentado video3*/
		$this->setParametro('stock','stock','int4');
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarProducto(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='sal.ft_producto_ime';
		$this->transaccion='SAL_PRO_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_producto','id_producto','int4');
		$this->setParametro('id_marca','id_marca','int4');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('id_categoria','id_categoria','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('nombre','nombre','varchar');
		/*aumentado video3*/
		$this->setParametro('stock','stock','int4');
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarProducto(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='sal.ft_producto_ime';
		$this->transaccion='SAL_PRO_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_producto','id_producto','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
	
	/* depues de haber agregado en el controlador para workflow
	 
	 function siguienteEstadoSalee(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='sal.ft_producto_ime';
		$this->transaccion='SAL_PRO_ELI'; //cambiar 'SAL_SIGESTADO_IME
		$this->tipo_procedimiento='IME';
		
	  AGREGAR 
	 $this->setParametro('id_proceso_wf_act','id_proceso_wf_act','int4');
	 $this->setParametro('id_estado_wf_act','id_estado_wf_act','int4');
	 $this->setParametro('id_tipo_estado','id_tipo_estado','int4');
	 $this->setParametro('id_funcionario_wf','id_funcionario_wf','int4');
	 $this->setParametro('id_depto_wf','id_depto_wf','int4');
	 $this->setParametro('obs','obs','text');
	 $this->setParametro('json_procesos','json_procesos','text');
	 
		//Define los parametros para la funcion
		$this->setParametro('id_producto','id_producto','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
	 */
			
}
?>