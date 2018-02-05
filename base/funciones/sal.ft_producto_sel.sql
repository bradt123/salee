/**************************************************************************
 SISTEMA:		Salee
 FUNCION: 		sal.ft_producto_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'sal.tproducto'
 AUTOR: 		 (admin)
 FECHA:	        26-12-2017 13:27:49
 COMENTARIOS:	
***************************************************************************
 HISTORIAL DE MODIFICACIONES:
#ISSUE				FECHA				AUTOR				DESCRIPCION
 #0				26-12-2017 13:27:49								Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'sal.tproducto'	
 #
 ***************************************************************************/

DECLARE

	v_consulta    		varchar;
	v_parametros  		record;
	v_nombre_funcion   	text;
	v_resp				varchar;
			    
BEGIN

	v_nombre_funcion = 'sal.ft_producto_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'SAL_PRO_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		26-12-2017 13:27:49
	***********************************/

	if(p_transaccion='SAL_PRO_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						pro.id_producto,
						pro.id_marca,
						pro.descripcion,
						pro.id_categoria,
						pro.estado_reg,
						pro.nombre,
						pro.id_usuario_ai,
						pro.id_usuario_reg,
						pro.fecha_reg,
						pro.usuario_ai,
						pro.id_usuario_mod,
						pro.fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
                        cat.nombre as desc_categoria,
                        pro.stock 
            
						from sal.tproducto pro
						inner join segu.tusuario usu1 on usu1.id_usuario = pro.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = pro.id_usuario_mod
                        left join sal.tcategoria cat on cat.id_categoria = pro.id_categoria
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'SAL_PRO_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		26-12-2017 13:27:49
	***********************************/

	elsif(p_transaccion='SAL_PRO_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_producto)
					    from sal.tproducto pro
					    inner join segu.tusuario usu1 on usu1.id_usuario = pro.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = pro.id_usuario_mod
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