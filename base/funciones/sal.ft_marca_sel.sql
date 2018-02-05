/**************************************************************************
 SISTEMA:		Salee
 FUNCION: 		sal.ft_marca_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'sal.tmarca'
 AUTOR: 		 (admin)
 FECHA:	        26-12-2017 13:27:47
 COMENTARIOS:	
***************************************************************************
 HISTORIAL DE MODIFICACIONES:
#ISSUE				FECHA				AUTOR				DESCRIPCION
 #0				26-12-2017 13:27:47								Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'sal.tmarca'	
 #
 ***************************************************************************/

DECLARE

	v_consulta    		varchar;
	v_parametros  		record;
	v_nombre_funcion   	text;
	v_resp				varchar;
			    
BEGIN

	v_nombre_funcion = 'sal.ft_marca_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'SAL_MAR_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		26-12-2017 13:27:47
	***********************************/

	if(p_transaccion='SAL_MAR_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						mar.id_marca,
						mar.nombre,
						mar.estado_reg,
						mar.fecha_reg,
						mar.usuario_ai,
						mar.id_usuario_reg,
						mar.id_usuario_ai,
						mar.fecha_mod,
						mar.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod	
						from sal.tmarca mar
						inner join segu.tusuario usu1 on usu1.id_usuario = mar.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = mar.id_usuario_mod
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'SAL_MAR_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		26-12-2017 13:27:47
	***********************************/

	elsif(p_transaccion='SAL_MAR_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_marca)
					    from sal.tmarca mar
					    inner join segu.tusuario usu1 on usu1.id_usuario = mar.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = mar.id_usuario_mod
					    where ';
			
			--Definicion de la respuesta		    
			v_consulta:=v_consulta||v_parametros.filtro;

			--Devuelve la respuesta
			return v_consulta;

		end;
					
	else
					     
		raise exception 'Transaccion inexistente';
					         
	end if;
					
EXCEPTION
					
	WHEN OTHERS THEN
			v_resp='';
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje',SQLERRM);
			v_resp = pxp.f_agrega_clave(v_resp,'codigo_error',SQLSTATE);
			v_resp = pxp.f_agrega_clave(v_resp,'procedimientos',v_nombre_funcion);
			raise exception '%',v_resp;
END;