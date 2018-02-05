/**************************************************************************
 SISTEMA:		Salee
 FUNCION: 		sal.ft_producto_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'sal.tproducto'
 AUTOR: 		 (admin)
 FECHA:	        26-12-2017 13:27:49
 COMENTARIOS:	
***************************************************************************
 HISTORIAL DE MODIFICACIONES:
#ISSUE				FECHA				AUTOR				DESCRIPCION
 #0				26-12-2017 13:27:49								Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'sal.tproducto'	
 #
 ***************************************************************************/

DECLARE

	v_nro_requerimiento    	integer;
	v_parametros           	record;
	v_id_requerimiento     	integer;
	v_resp		            varchar;
	v_nombre_funcion        text;
	v_mensaje_error         text;
	v_id_producto	integer;
			    
BEGIN

    v_nombre_funcion = 'sal.ft_producto_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'SAL_PRO_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		26-12-2017 13:27:49
	***********************************/

	if(p_transaccion='SAL_PRO_INS')then
					
        begin
        		--aca ba el codigo 
    
        	--Sentencia de la insercion
        	insert into sal.tproducto(
			id_marca,
			descripcion,
			id_categoria,
			estado_reg,
			nombre,
			id_usuario_ai,
			id_usuario_reg,
			fecha_reg,
			usuario_ai,
			id_usuario_mod,
			fecha_mod,
            stock
          	) values(
			v_parametros.id_marca,
			v_parametros.descripcion,
			v_parametros.id_categoria,
			'activo',
			v_parametros.nombre,
			v_parametros._id_usuario_ai,
			p_id_usuario,
			now(),
			v_parametros._nombre_usuario_ai,
			null,
			null,
            v_parametros.stock
							
			
			
			)RETURNING id_producto into v_id_producto;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Producto almacenado(a) con exito (id_producto'||v_id_producto||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_producto',v_id_producto::varchar);

            --Devuelve la respuesta
            return v_resp;
            
		--agregar el fragmento de codigo encia de select ps_num_tramite
		end;
        
       

	/*********************************    
 	#TRANSACCION:  'SAL_PRO_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		26-12-2017 13:27:49
	***********************************/

	elsif(p_transaccion='SAL_PRO_MOD')then

		begin
			--Sentencia de la modificacion
			update sal.tproducto set
			id_marca = v_parametros.id_marca,
			descripcion = v_parametros.descripcion,
			id_categoria = v_parametros.id_categoria,
			nombre = v_parametros.nombre,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now(),
			id_usuario_ai = v_parametros._id_usuario_ai,
			usuario_ai = v_parametros._nombre_usuario_ai,
            stock = v_parametros.stock
			where id_producto=v_parametros.id_producto;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Producto modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_producto',v_parametros.id_producto::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'SAL_PRO_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		26-12-2017 13:27:49
	***********************************/

	elsif(p_transaccion='SAL_PRO_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from sal.tproducto
            where id_producto=v_parametros.id_producto;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Producto eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_producto',v_parametros.id_producto::varchar);
              
            --Devuelve la respuesta
            return v_resp;

		end;
        
        --aqui va lo enviado y cambiar la #transaccion por lo del controlador
         
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