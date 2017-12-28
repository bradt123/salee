<?php
/**
*@package pXP
*@file gen-MODMovimiento.php
*@author  (admin)
*@date 26-12-2017 14:49:03
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODMovimiento extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarMovimiento(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='sal.ft_movimiento_sel';
		$this->transaccion='SAL_MOV_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_movimiento','int4');
		$this->captura('cantidad_movimiento','int4');
		$this->captura('tipo','varchar');
		$this->captura('estado_reg','varchar');
		$this->captura('id_producto','int4');
		$this->captura('id_usuario_ai','int4');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('usuario_ai','varchar');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		
		/*aumentado video 3*/
		$this->captura('desc_producto','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarMovimiento(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='sal.ft_movimiento_ime';
		$this->transaccion='SAL_MOV_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('cantidad_movimiento','cantidad_movimiento','int4');
		$this->setParametro('tipo','tipo','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_producto','id_producto','int4');
		/*aumentado video 3*/
		$this->setParametro('desc_producto','desc_producto','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarMovimiento(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='sal.ft_movimiento_ime';
		$this->transaccion='SAL_MOV_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_movimiento','id_movimiento','int4');
		$this->setParametro('cantidad_movimiento','cantidad_movimiento','int4');
		$this->setParametro('tipo','tipo','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_producto','id_producto','int4');
		/*aumentado video 3*/
		$this->setParametro('desc_producto','desc_producto','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarMovimiento(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='sal.ft_movimiento_ime';
		$this->transaccion='SAL_MOV_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_movimiento','id_movimiento','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>