/**************************************************************************
 SISTEMA:		Salee
 FUNCION: 		sal.ft_movimiento_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'sal.tmovimiento'
 AUTOR: 		 (admin)
 FECHA:	        26-12-2017 14:49:03
 COMENTARIOS:	
***************************************************************************
 HISTORIAL DE MODIFICACIONES:
#ISSUE				FECHA				AUTOR				DESCRIPCION
 #0				26-12-2017 14:49:03								Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'sal.tmovimiento'	
 #
 ***************************************************************************/

DECLARE

	v_nro_requerimiento    	integer;
	v_parametros           	record;
	v_id_requerimiento     	integer;
	v_resp		            varchar;
	v_nombre_funcion        text;
	v_mensaje_error         text;
	v_id_movimiento			integer;
    v_registros 			record;
			    
BEGIN

    v_nombre_funcion = 'sal.ft_movimiento_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'SAL_MOV_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		26-12-2017 14:49:03
	***********************************/

	if(p_transaccion='SAL_MOV_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into sal.tmovimiento(
			cantidad_movimiento,
			tipo,
			estado_reg,
			id_producto,
			id_usuario_ai,
			id_usuario_reg,
			fecha_reg,
			usuario_ai,
			id_usuario_mod,
			fecha_mod
          	) values(
			v_parametros.cantidad_movimiento,
			v_parametros.tipo,
			'activo',
			v_parametros.id_producto,
			v_parametros._id_usuario_ai,
			p_id_usuario,
			now(),
			v_parametros._nombre_usuario_ai,
			null,
			null
							
			
			
			)RETURNING id_movimiento into v_id_movimiento;
            
             --funcion aumentada
            IF(v_parametros.tipo = 'Entrada')THEN
            	update sal.tproducto set
                	stock = stock + v_parametros.cantidad_movimiento
                where id_producto = v_parametros.id_producto;
        	ELSE
            	update sal.tproducto set
                	stock = stock - v_parametros.cantidad_movimiento
                where id_producto = v_parametros.id_producto;
            END IF;
			--
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Movimiento almacenado(a) con exito (id_movimiento'||v_id_movimiento||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_movimiento',v_id_movimiento::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'SAL_MOV_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		26-12-2017 14:49:03
	***********************************/

	elsif(p_transaccion='SAL_MOV_MOD')then

		begin
        --aumentado con la funcion 
           select 
            	id_producto,
                cantidad_movimiento,
                tipo
        	into 
            	v_registros
            from sal.tmovimiento
            where id_movimiento = v_parametros.id_movimiento;
            
			--Sentencia de la modificacion
			update sal.tmovimiento set
			cantidad_movimiento = v_parametros.cantidad_movimiento,
			tipo = v_parametros.tipo,
			id_producto = v_parametros.id_producto,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now(),
			id_usuario_ai = v_parametros._id_usuario_ai,
			usuario_ai = v_parametros._nombre_usuario_ai
			where id_movimiento=v_parametros.id_movimiento;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Movimiento modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_movimiento',v_parametros.id_movimiento::varchar);
               
            
            --funcion aumentada
            IF(v_registros.tipo = 'Entrada')THEN
            	update sal.tproducto set
            		stock = stock - v_registros.cantidad_movimiento + v_parametros.cantidad_movimiento
                where id_producto = v_registros.id_producto;
            ELSE
            	update sal.tproducto set
                	stock = stock + v_registros.cantidad_movimiento - v_parametros.cantidad_movimiento
                where id_producto = v_registros.id_producto;
            END IF;
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'SAL_MOV_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		26-12-2017 14:49:03
	***********************************/

	elsif(p_transaccion='SAL_MOV_ELI')then

		begin
        --aumentado con la funcion 
            select 
            	id_producto,
                cantidad_movimiento,
                tipo
        	into 
            	v_registros
            from sal.tmovimiento
            where id_movimiento = v_parametros.id_movimiento;
            
			--Sentencia de la eliminacion
			delete from sal.tmovimiento
            where id_movimiento=v_parametros.id_movimiento;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Movimiento eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_movimiento',v_parametros.id_movimiento::varchar);
              
             --funcion aumentada para suma o resta de ventas o compra
            
            IF(v_registros.tipo = 'Entrada')THEN
            	update sal.tproducto set
                	stock = stock - v_registros.cantidad_movimiento
                where id_producto = v_registros.id_producto;
            ELSE
            	update sal.tproducto set
                	stock = stock + v_registros.cantidad_movimiento
                where id_producto = v_registros.id_producto;
        	END IF;
            
            --Devuelve la respuesta
            return v_resp;

		end;
         
	else
     
    	raise exception 'Transaccion inexistente: %',p_transaccion;

	end if;

EXCEPTION
				
	WHEN OTHERS THEN
		v_resp='';
		v_resp = pxp.f_agrega_clave(v_resp,'mensaje',SQLERRM);
		v_resp = pxp.f_agrega_clave(v_resp,'codigo_error',SQLSTATE);
		v_resp = pxp.f_agrega_clave(v_resp,'procedimientos',v_nombre_funcion);
		raise exception '%',v_resp;
				        
END;