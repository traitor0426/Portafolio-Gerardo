-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 28-06-2024 a las 03:53:18
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `usuarios`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `ACCESO` (IN `iID` VARCHAR(50) CHARSET utf8mb4)   BEGIN
	DELETE FROM acceso WHERE id = iID;
    INSERT INTO acceso(id) VALUES(iID);
    SELECT IF(EXISTS(SELECT * FROM acceso WHERE id = iID), CN("ALTA_EXITOSA"), CN("ALTA_FALLIDA")) AS resultado;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ALTAS` (IN `iNOMBRE` VARCHAR(250) CHARSET utf8mb4, IN `iPAPELLIDO` VARCHAR(250) CHARSET utf8mb4, IN `iSAPELLIDO` VARCHAR(250) CHARSET utf8mb4, IN `iNACIMIENTO` VARCHAR(50) CHARSET utf8mb4, IN `iGENERO` INT, IN `iLOGIN` VARCHAR(50) CHARSET utf8mb4, IN `iPWD` VARCHAR(50) CHARSET utf8mb4, IN `iFOTO` LONGTEXT CHARSET utf8)   BEGIN
	# Constantes a manejar
	DECLARE NO_DEFINIDO VARCHAR(250) DEFAULT CC("NO_DEFINIDO");
    DECLARE INDEFINIDO VARCHAR(250) DEFAULT CN("INDEFINIDO");
    
    # Banderas para la validación 
	DECLARE pApellidoOK INT;
	DECLARE sApellidoOK INT;
	DECLARE nacimientoOK INT;    
	DECLARE generoOK INT;
	DECLARE loginOK INT;
	DECLARE fotoOK INT;

	# Id del usuario
	DECLARE iID VARCHAR(19) DEFAULT usuarios.ID(NO_DEFINIDO);
    
    # Manejo de excepciones
	DECLARE EXIT HANDLER FOR 1022, 1062, 1291, 1452, 1859 # Problemas con llaves
	BEGIN
		ROLLBACK;
		SELECT 0 AS ok, CN('ALTA_FALLIDA') as resultado;
	END;

	# Si ya existe el login no se puede realizar el alta
    IF EXISTS(SELECT * FROM login WHERE login = iLOGIN) THEN
    	SELECT 0 AS ok, CN('LOGIN_EXISTENTE') as resultado;
	ELSE
        START TRANSACTION;

        # 1.- Registro el nombre
        INSERT INTO nombre(id, nombre) VALUES(iID, iNOMBRE);

        # 2.- Registro el apellido paterno
        IF iPAPELLIDO <> NO_DEFINIDO AND iPAPELLIDO <> "" THEN
            INSERT INTO papellido(id, papellido) VALUES(iID, iPAPELLIDO);
        END IF;

        # 3.- Registro el segundo apellido
        IF iSAPELLIDO <> NO_DEFINIDO AND iSAPELLIDO <> "" THEN
            INSERT INTO sapellido(id, sapellido) VALUES(iID, iSAPELLIDO);
        END IF;
        
        # 4.- Registro la fecha de nacimiento
        IF iNACIMIENTO <> NO_DEFINIDO AND iNACIMIENTO <> "" THEN
            INSERT INTO nacimiento(id, nacimiento) VALUES(iID, iNACIMIENTO);
        END IF;        

        # 5.- Registro el genero
        IF iGENERO <> INDEFINIDO THEN
        	INSERT INTO genero(id, genero) VALUES(iID, iGENERO);
        END IF;

        # 6.- Registro el login
        INSERT INTO login(id, login, pwd) VALUES(iID, iLOGIN, AES_ENCRYPT(iPWD, '19701019'));

        # 7.- Registro la foto
        IF iFOTO <> NO_DEFINIDO AND iFOTO <> "" THEN
            INSERT INTO foto(id, foto) VALUES(iID, iFOTO);
        END IF;

        # 8.- Configuro banderas
        SET pApellidoOK = IF(iPAPELLIDO <> NO_DEFINIDO AND iPAPELLIDO <> "" AND NOT EXISTS(SELECT * FROM papellido WHERE id = iID), 0, 1);
        SET sApellidoOK = IF(iSAPELLIDO <> NO_DEFINIDO AND iSAPELLIDO <> "" AND NOT EXISTS(SELECT * FROM sapellido WHERE id = iID), 0, 1);
        SET generoOK = IF(iGENERO <> INDEFINIDO AND NOT EXISTS(SELECT * FROM genero WHERE id = iID), 0, 1);
        SET loginOK = IF(iLOGIN <> NO_DEFINIDO AND iLOGIN <> "" AND NOT EXISTS(SELECT * FROM login WHERE id = iID), 0, 1);
		SET fotoOK = IF(iFOTO <> NO_DEFINIDO AND iFOTO <> "" AND NOT EXISTS(SELECT * FROM foto WHERE id = iID), 0, 1);

        # 9.- Valido la transacción
        IF  PApellidoOk = 1 AND sApellidoOk = 1 AND generoOk = 1 AND loginOk = 1 AND fotoOk = 1 THEN
            COMMIT;
            SELECT CN("ALTA_EXITOSA") AS resultado;
        ELSE
            ROLLBACK;
            SELECT 0 AS ok, CN("ALTA_FALLIDA") AS resultado;
        END IF;        
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `BAJAS` (IN `iID` VARCHAR(50) CHARSET utf8mb4)   BEGIN
	IF NOT EXISTS(SELECT * FROM nombre WHERE id = iID) THEN
		SELECT 0 AS ok, CN("BAJA_FALLIDA") AS resultado;
	ELSE
		DELETE FROM nombre WHERE id = iID;    
		IF NOT EXISTS(SELECT * FROM nombre WHERE id = iID) THEN
			SELECT CN("BAJA_EXITOSA") AS resultado;
		ELSE
			SELECT 0 AS ok, CN("BAJA_FALLIDA") AS resultado;
		END IF;
	END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `CAMBIOS` (IN `iID` VARCHAR(50) CHARSET utf8mb4, IN `iNOMBRE` VARCHAR(250) CHARSET utf8mb4, IN `iPAPELLIDO` VARCHAR(250) CHARSET utf8mb4, IN `iSAPELLIDO` VARCHAR(250) CHARSET utf8mb4, IN `iNACIMIENTO` VARCHAR(50) CHARSET utf8mb4, IN `iGENERO` INT, IN `iLOGIN` VARCHAR(50) CHARSET utf8mb4, IN `iPWD` VARCHAR(50) CHARSET utf8mb4, IN `iFOTO` LONGTEXT CHARSET utf8mb4)   BEGIN
	# Constantes a manejar
	DECLARE NO_DEFINIDO VARCHAR(250) DEFAULT CC("NO_DEFINIDO");
    DECLARE INDEFINIDO VARCHAR(250) DEFAULT CN("INDEFINIDO");
    
    # Banderas para la validación 
	DECLARE pApellidoOK INT;
	DECLARE sApellidoOK INT;
	DECLARE generoOK INT;
	DECLARE loginOK INT;
	DECLARE fotoOK INT;

	# Gestión de excepciones
	DECLARE EXIT HANDLER FOR 1022, 1062, 1291, 1452, 1859 # Problemas con llaves
	BEGIN    
		ROLLBACK;
		SELECT 0 AS ok, CN('CAMBIO_FALLIDO') as resultado;
	END;

	# si ya existe un usuario con el nuevo login, no se pueden realizar los cambios
	IF EXISTS(SELECT * FROM login WHERE login = iLOGIN AND id <> iID) THEN
    	SELECT 0 AS ok, CN('LOGIN_EXISTENTE') as resultado;
	ELSE
        START TRANSACTION;

        # 1.- Actualizo el nombre
        IF iNOMBRE <> NO_DEFINIDO AND iNOMBRE <> "" THEN
            UPDATE nombre SET nombre = iNOMBRE WHERE id = iID;
        END IF;

        # 2.- Actualizo el primer apellido
        DELETE FROM papellido WHERE id = iID;
        IF iPAPELLIDO <> NO_DEFINIDO AND iPAPELLIDO <> "" THEN
            INSERT INTO papellido(id, pApellido) VALUES(iID, iPAPELLIDO);
        END IF;

        # 3.- Actualizo el segundo apellido
        DELETE FROM sapellido WHERE id = iID;
        IF iSAPELLIDO <> NO_DEFINIDO AND iSAPELLIDO <> "" THEN
            INSERT INTO sapellido(id, sApellido) VALUES(iID, iSAPELLIDO);
        END IF;
        
        # 4.- Actualizo la fecha de nacimiento
        DELETE FROM nacimiento WHERE id = iID;
        IF iNACIMIENTO <> NO_DEFINIDO AND iNACIMIENTO <> "" THEN
            INSERT INTO nacimiento(id, nacimiento) VALUES(iID, iNACIMIENTO);
        END IF;        

        # 5.- Actualización del genero
        DELETE FROM genero WHERE id = iID;
        IF iGENERO <> INDEFINIDO THEN
            INSERT INTO genero(id, genero) VALUES(iID, iGENERO);
        END IF;

        # 6.- Actualizo el login
        DELETE FROM login WHERE id = iID;
        IF iLOGIN <> NO_DEFINIDO AND iLOGIN <> "" THEN
            INSERT INTO login(id, login, pwd) VALUES(iID, iLOGIN, AES_ENCRYPT(iPWD, '19701019'));
        END IF;

        # 7.- Actualización de la foto
        DELETE FROM foto WHERE id = iID;
        IF iFOTO <> NO_DEFINIDO AND iFOTO <> "" THEN
            INSERT INTO foto(id, foto) VALUES(iID, iFOTO);
        END IF;

        # 8.- Configuro banderas
        SET pApellidoOK = IF(iPAPELLIDO <> NO_DEFINIDO AND iPAPELLIDO <> "" AND NOT EXISTS(SELECT * FROM papellido WHERE id = iID), 0, 1);
        SET sApellidoOK = IF(iSAPELLIDO <> NO_DEFINIDO AND iSAPELLIDO <> "" AND NOT EXISTS(SELECT * FROM sapellido WHERE id = iID), 0, 1);
        SET generoOK = IF(iGENERO <> INDEFINIDO AND NOT EXISTS(SELECT * FROM genero WHERE id = iID), 0, 1);
        SET loginOK = IF(iLOGIN <> NO_DEFINIDO AND iLOGIN <> "" AND NOT EXISTS(SELECT * FROM login WHERE id = iID), 0, 1);
        SET fotoOK = IF(iFOTO <> NO_DEFINIDO AND iFOTO <> "" AND NOT EXISTS(SELECT * FROM foto WHERE id = iID), 0, 1);    

        # 9.- Valido la transacción
        IF  PApellidoOk = 1 AND sApellidoOk = 1 AND generoOk = 1 AND loginOk = 1 AND fotoOk = 1 THEN
            COMMIT;
            SELECT CN("CAMBIO_EXITOSO") AS resultado;
        ELSE
            ROLLBACK;
            SELECT 0 as ok, CN("CAMBIO_FALLIDO") AS resultado;
        END IF;
    END IF;        
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `CONFIGURACION` ()   SELECT * FROM configuracion$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `CONSTANTES` ()   SELECT constante, valor FROM constantes ORDER BY constante$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `CONSULTAS` (IN `iPAGINA` INT)   BEGIN
	DECLARE PAGINADOR INT DEFAULT CN('PAGINADOR');
	DECLARE COMIENZO INT DEFAULT IF(iPAGINA > 0, PAGINADOR * (iPAGINA-1), 0);
	DECLARE PAGINACION VARCHAR(250) DEFAULT IF(iPAGINA > 0, CONCAT(' LIMIT ', COMIENZO, ',' ,PAGINADOR), '');

    # Parametros en la función CAMPOS: id, nombre, creacion, pApellido, sApellido, nombreCompleto, nacimiento, genero, login, acceso, foto        
	SET @sql = CONCAT("SELECT id, nombre, ", CAMPOS(0,0,1,1,1,1,1,1,1,1,1,"id"), "FROM nombre",  PAGINACION, ';');
	PREPARE stm FROM @sql;
	EXECUTE stm;
	DEALLOCATE PREPARE stm;
    SELECT @sql as consulta;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `CONSULTAS_CATALOGO` (IN `iCATALOGO` VARCHAR(250) CHARSET utf8mb4)   BEGIN
	DECLARE CAMPOS VARCHAR(1250);

	CASE iCATALOGO
    	WHEN "generos" THEN SET CAMPOS = "genero, descripcion";
    	ELSE SET CAMPOS = "*";
  	END CASE;

	SET @sql = CONCAT("SELECT ", CAMPOS, " FROM ", iCATALOGO, ";");	
	PREPARE stm FROM @sql;
	EXECUTE stm;
	DEALLOCATE PREPARE stm;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `CONSULTAS_EDAD` (IN `iPAGINA` INT, IN `iOPERADOR` VARCHAR(2) CHARSET utf8mb4, IN `iEDAD` INT)   BEGIN
    DECLARE PAGINADOR INT DEFAULT CN('PAGINADOR');
	DECLARE COMIENZO INT DEFAULT IF(iPAGINA > 0, PAGINADOR * (iPAGINA-1), 0);
	DECLARE PAGINACION VARCHAR(250) DEFAULT IF(iPAGINA > 0, CONCAT(' LIMIT ', COMIENZO, ',' ,PAGINADOR), '');    
	DECLARE COMPARACION VARCHAR(250) DEFAULT CONCAT('TIMESTAMPDIFF(YEAR, nacimiento, CURDATE()) ', iOPERADOR, ' ' ,iEDAD);
    
    # Parametros en la función CAMPOS: id, nombre, creacion, pApellido, sApellido, nombreCompleto, nacimiento, genero, login, acceso, foto    
	SET @sql = CONCAT("SELECT nombre.id, EDAD(nombre.id) as edad, ",  CAMPOS(0,0,1,1,1,1,1,1,1,1,1, "nombre.id"), " FROM nombre JOIN nacimiento ON nombre.id = nacimiento.id WHERE ", COMPARACION, " ORDER BY NOMBRECOMPLETO(id) ", PAGINACION, ";");
	PREPARE stm FROM @sql;   
	EXECUTE stm;
    # SELECT @sql AS consulta;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `CONSULTAS_EDADENRANGO` (IN `iPAGINA` INT, IN `iINICIO` INT, IN `iFIN` INT)   BEGIN
	DECLARE PAGINADOR INT DEFAULT CN('PAGINADOR');
	DECLARE COMIENZO INT DEFAULT IF(iPAGINA > 0, PAGINADOR * (iPAGINA-1), 0);
	DECLARE PAGINACION VARCHAR(250) DEFAULT IF(iPAGINA > 0, CONCAT(' LIMIT ', COMIENZO, ',' ,PAGINADOR), '');
	DECLARE COMPARACION VARCHAR(250) DEFAULT CONCAT('EDAD(nombre.id) >= ', iINICIO, ' AND ' , 'EDAD(nombre.id) <= ', iFIN);

	# Parametros en la función CAMPOS: id, nombre, creacion, pApellido, sApellido, nombreCompleto, nacimiento, genero, login, acceso, foto    
	SET @sql = CONCAT("SELECT nombre.id, EDAD(nombre.id) as edad, ",  CAMPOS(0,0,1,1,1,1,1,1,1,1,1, "nombre.id"), " FROM nombre JOIN nacimiento ON nombre.id = nacimiento.id WHERE ", COMPARACION, " ORDER BY NOMBRECOMPLETO(id) ", PAGINACION, ";");	
	PREPARE stm FROM @sql;
	EXECUTE stm;
	DEALLOCATE PREPARE stm;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `CONSULTAS_ID` (IN `iID` VARCHAR(50) CHARSET utf8mb4)   BEGIN
	IF EXISTS(SELECT * FROM nombre WHERE id = iID) THEN    
    	# Parametros en la función CAMPOS: id, nombre, creacion, pApellido, sApellido, nombreCompleto, nacimiento, genero, login, acceso, foto                 
		SET @sql = CONCAT("SELECT id, ", CAMPOS(0,0,1,1,1,1,1,1,1,1,1,"id"), " FROM nombre WHERE id = '", iID, "';");
		PREPARE stm FROM @sql;
		EXECUTE stm;
		DEALLOCATE PREPARE stm;
	ELSE
		SELECT 0 AS ok, CN("CONSULTA_FALLIDA") AS resultado;    	
	END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `CONSULTAS_NOMBRE` (IN `iPAGINA` INT, IN `iFILTRO` LONGTEXT CHARSET utf8mb4)   BEGIN
	DECLARE PAGINADOR INT DEFAULT CN('PAGINADOR');
	DECLARE COMIENZO INT DEFAULT IF(iPAGINA > 0, PAGINADOR * (iPAGINA-1), 0);
	DECLARE PAGINACION VARCHAR(250) DEFAULT IF(iPAGINA > 0, CONCAT(' LIMIT ', COMIENZO, ',' ,PAGINADOR), '');

    # Parametros en la función CAMPOS: id, nombre, creacion, pApellido, sApellido, nombreCompleto, nacimiento, genero, login, acceso, foto    
	SET @sql = CONCAT("SELECT id, nombre, ", CAMPOS(0,0,1,1,1,1,1,1,1,1,1,"id"), " FROM nombre WHERE nombre LIKE '%", iFILTRO, "%' COLLATE utf8mb4_general_ci ORDER BY nombre", PAGINACION, ";");	
	PREPARE stm FROM @sql;   
	EXECUTE stm;
	DEALLOCATE PREPARE stm;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `CONSULTAS_NOMBRECOMPLETO` (IN `iPAGINA` INT, IN `iFILTRO` LONGTEXT CHARSET utf8mb4)   BEGIN
	DECLARE PAGINADOR INT DEFAULT CN('PAGINADOR');
	DECLARE COMIENZO INT DEFAULT IF(iPAGINA > 0, PAGINADOR * (iPAGINA-1), 0);
	DECLARE PAGINACION VARCHAR(250) DEFAULT IF(iPAGINA > 0, CONCAT(' LIMIT ', COMIENZO, ',' ,PAGINADOR), '');    
	
	# Parametros en la función CAMPOS: id, nombre, creacion, pApellido, sApellido, nombreCompleto, nacimiento, genero, login, acceso, foto          
	SET @sql = CONCAT("SELECT id, nombre, ", CAMPOS(0,0,1,1,1,1,1,1,1,1,1,"id"), " FROM nombre WHERE NOMBRECOMPLETO(id) LIKE '%", iFILTRO, "%' COLLATE utf8mb4_general_ci ORDER BY NOMBRECOMPLETO(id) ", PAGINACION, ";");
	PREPARE stm FROM @sql;
	EXECUTE stm;
	DEALLOCATE PREPARE stm;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `EXISTE` (IN `iLOGIN` VARCHAR(50) CHARSET utf8mb4, IN `iPWD` VARCHAR(50) CHARSET utf8mb4)   BEGIN
	SELECT IF(EXISTS(SELECT * FROM login WHERE (login COLLATE utf8mb4_general_ci) = iLOGIN AND AES_DECRYPT(pwd, '19701019') = iPWD), CN("CONSULTA_EXITOSA"), CN("CONSULTA_FALLIDA")) AS resultado;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PAGINACION` (IN `iCONSULTA` VARCHAR(250) CHARSET utf8mb4, IN `iPAGINA` INT, IN `iFILTRO` LONGTEXT CHARSET utf8mb4)   BEGIN
	DECLARE totalRegistros INT;
	DECLARE tamanoPagina INT DEFAULT CN('PAGINADOR');
	DECLARE registroInicial INT DEFAULT IF(iPAGINA > 0, tamanoPagina * (iPAGINA-1), 0);
	DECLARE registroFinal INT DEFAULT registroInicial +  tamanoPagina;
	DECLARE paginaAnterior INT DEFAULT 0; # Asumiendo que la página es la cero
	DECLARE paginaSiguiente INT DEFAULT 0; # Asumiendo que la página es la cero
    DECLARE comparacion VARCHAR(250); # Usado en las consultas: CONSULTAS_EDAD, CONSULTAS_EDADENRANGO

	# Consulta dinámica para recuperar el número de registros
	SET @totalRegistros = 0;
	SET @sql = "SELECT COUNT(*) INTO @totalRegistros FROM ";
    
    IF iCONSULTA = 'CONSULTAS_EDAD' THEN
        SET comparacion = CONCAT('EDAD(nombre.id) ', JSON_VALUE(iFILTRO, '$.operador'), ' ', JSON_VALUE(iFILTRO, '$.edad'));
    ELSEIF iCONSULTA = 'CONSULTAS_EDADENRANGO' THEN
    	SET comparacion = CONCAT('EDAD(nombre.id) >= ', JSON_VALUE(iFILTRO, '$.inicio'), ' AND ' , 'EDAD(nombre.id) <= ', JSON_VALUE(iFILTRO, '$.fin'));
    END IF;
	
	CASE iCONSULTA
		WHEN "CONSULTAS" THEN SET @sql = CONCAT(@sql, "nombre");
		WHEN "CONSULTAS_NOMBRE" THEN SET @sql = CONCAT(@sql, "nombre WHERE nombre LIKE '%", iFILTRO, "%' COLLATE utf8mb4_general_ci");        
		WHEN "CONSULTAS_NOMBRECOMPLETO" THEN SET @sql = CONCAT(@sql, "nombre WHERE NOMBRECOMPLETO(id) LIKE '%", iFILTRO, "%' COLLATE utf8mb4_general_ci");
		WHEN "CONSULTAS_EDAD" THEN SET @sql = CONCAT(@sql, "nombre WHERE ", comparacion);
   		WHEN "CONSULTAS_EDADENRANGO" THEN SET @sql = CONCAT(@sql, "nombre WHERE ", comparacion);
	END CASE;

	PREPARE stm FROM @sql;
	EXECUTE stm;
	DEALLOCATE PREPARE stm;

	SET totalRegistros = @totalRegistros;

	IF registroFinal > totalRegistros THEN
		SET registroFinal = totalRegistros;
	END IF;
	
	IF iPAGINA = 1 AND registroInicial + tamanoPagina >= totalRegistros THEN # Primer caso, los resultados caben en una sola página
		SET paginaAnterior = 0;
		SET paginaSiguiente = 1;
	ELSEIF iPAGINA = 1 AND registroInicial + tamanoPagina < totalRegistros THEN # Segundo caso, estamos en la primera página de varias
		SET paginaAnterior = 0;
		SET paginaSiguiente = iPAGINA + 1;
	ELSEIF iPAGINA > 1 AND registroInicial + tamanoPagina < totalRegistros THEN # Tercer caso, estamos en una página intermedia
		SET paginaAnterior = iPAGINA - 1;
		SET paginaSiguiente = iPAGINA + 1;
	ELSEIF iPAGINA > 1 AND registroInicial + tamanoPagina >= totalRegistros THEN # Cuarto caso, estamos en la última página
		SET paginaAnterior = iPAGINA - 1;
		SET paginaSiguiente = 1;
	END IF;

	SELECT paginaAnterior, paginaSiguiente, totalRegistros, registroInicial + 1 as registroInicial, registroFinal, tamanoPagina;
END$$

--
-- Funciones
--
CREATE DEFINER=`root`@`localhost` FUNCTION `ACCESO` (`iID` VARCHAR(50) CHARSET utf8mb4) RETURNS VARCHAR(50) CHARSET utf8mb4 COLLATE utf8mb4_general_ci  RETURN IFNULL((SELECT acceso FROM acceso WHERE id = iID), CC("FECHA_INDEFINIDA"))$$

CREATE DEFINER=`root`@`localhost` FUNCTION `CAMPOS` (`iID` INT, `iNOMBRE` INT, `iCREACION` INT, `iPAPELLIDO` INT, `iSAPELLIDO` INT, `iNOMBRECOMPLETO` INT, `iNACIMIENTO` INT, `iGENERO` INT, `iLOGIN` INT, `iACCESO` INT, `iFOTO` INT, `iIDENTIFICADOR` VARCHAR(50) CHARSET utf8mb4) RETURNS VARCHAR(1250) CHARSET utf8mb4 COLLATE utf8mb4_general_ci  BEGIN
	DECLARE STR VARCHAR(1250) DEFAULT "";
    DECLARE cid INT;
    DECLARE cnombre INT;
    DECLARE ccreacion INT;
	DECLARE cpApellido INT;
	DECLARE csApellido INT;
    DECLARE cnacimiento INT;
	DECLARE cgenero INT;
	DECLARE clogin INT;
    DECLARE cacceso INT;
	DECLARE cfoto INT;
    
    SELECT Id, nombre, creacion, pApellido, sApellido, nacimiento, genero, login, acceso, foto INTO cid, cnombre, ccreacion, cpApellido, csApellido, cnacimiento, cgenero, clogin, cacceso, cfoto FROM configuracion LIMIT 1 ;
    
    IF iID = 1 AND cid = 1 THEN
    	SET STR = CONCAT(STR, IF(STR <> "", ", ", ""), "id");
    END IF;

    IF iNOMBRE = 1 AND cnombre = 1 THEN
    	SET STR = CONCAT(STR, IF(STR <> "", ", ", ""), "NOMBRE(", iIDENTIFICADOR, ") AS nombre");
    END IF;

    IF iCREACION = 1 AND ccreacion = 1 THEN
    	SET STR = CONCAT(STR, IF(STR <> "", ", ", ""), "CREACION(", iIDENTIFICADOR, ") AS creacion");
    END IF;

	IF iPAPELLIDO = 1 AND cpApellido = 1 THEN
    	SET STR = CONCAT(STR, IF(STR <> "", ", ", ""), "PAPELLIDO(", iIDENTIFICADOR, ") AS pApellido");
    END IF;
    
    IF iSAPELLIDO = 1 AND csApellido = 1 THEN
    	SET STR = CONCAT(STR, IF(STR <> "", ", ", ""), "SAPELLIDO(", iIDENTIFICADOR, ") AS sApellido");
    END IF;
    
    IF iNACIMIENTO = 1 AND cnacimiento = 1 THEN
    	SET STR = CONCAT(STR, IF(STR <> "", ", ", ""), "NACIMIENTO(", iIDENTIFICADOR, ") AS nacimiento");
    END IF;    
    
    IF iNOMBRECOMPLETO = 1 THEN
    	SET STR = CONCAT(STR, IF(STR <> "", ", ", ""), "NOMBRECOMPLETO(", iIDENTIFICADOR, ") AS nombreCompleto");
    END IF;    
    
    IF iGENERO = 1 AND cgenero = 1 THEN
    	SET STR = CONCAT(STR, IF(STR <> "", ", ", ""), "GENERO(", iIDENTIFICADOR, ") AS genero");
    END IF;
    
    IF iLOGIN = 1 AND clogin = 1 THEN
    	SET STR = CONCAT(STR, IF(STR <> "", ", ", ""), "LOGIN(", iIDENTIFICADOR, ") AS login");
    END IF;
    
    IF iACCESO = 1 AND cacceso = 1 THEN
    	SET STR = CONCAT(STR, IF(STR <> "", ", ", ""), "ACCESO(", iIDENTIFICADOR, ") AS acceso");
    END IF;
    
    IF iFOTO = 1 AND cfoto = 1 THEN
    	SET STR = CONCAT(STR, IF(STR <> "", ", ", ""), "FOTO(", iIDENTIFICADOR, ") AS foto");
    END IF;          
    
    RETURN CONCAT(STR, " ");
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `CC` (`iCONSTANTE` VARCHAR(250) CHARSET utf8mb4) RETURNS VARCHAR(250) CHARSET utf8mb4 COLLATE utf8mb4_general_ci  IF(EXISTS(SELECT * FROM constantes WHERE constante = iCONSTANTE AND numerica = "0")) THEN
	RETURN (SELECT valor FROM constantes WHERE constante = iCONSTANTE AND numerica = "0");
ELSE
	RETURN "ND";
END IF$$

CREATE DEFINER=`root`@`localhost` FUNCTION `CN` (`iCONSTANTE` VARCHAR(250) CHARSET utf8mb4) RETURNS INT(11)  IF(EXISTS(SELECT * FROM constantes WHERE constante = iCONSTANTE AND numerica = "1")) THEN
	RETURN (SELECT CAST(valor AS INT) FROM constantes WHERE constante = iCONSTANTE AND numerica = "1");
ELSE
	RETURN -1;
END IF$$

CREATE DEFINER=`root`@`localhost` FUNCTION `CREACION` (`iID` VARCHAR(50) CHARSET utf8mb4) RETURNS VARCHAR(50) CHARSET utf8mb4 COLLATE utf8mb4_general_ci  RETURN IFNULL((SELECT creacion FROM nombre WHERE id = iID), CC("FECHA_INDEFINIDA"))$$

CREATE DEFINER=`root`@`localhost` FUNCTION `EDAD` (`iID` VARCHAR(50) CHARSET utf8) RETURNS INT(11)  BEGIN
	DECLARE nacimiento VARCHAR(50) DEFAULT NACIMIENTO(iID);

	IF nacimiento = CC("NO_DEFINIDO") THEN
		RETURN CN("INDEFINIDO");
	ELSE
		RETURN TIMESTAMPDIFF(YEAR, nacimiento, CURDATE());
	END IF;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `FOTO` (`iID` VARCHAR(50) CHARSET utf8mb4) RETURNS LONGTEXT CHARSET utf8mb4 COLLATE utf8mb4_general_ci  RETURN IFNULL((SELECT foto FROM foto WHERE id = iID), CC("NO_DEFINIDO"))$$

CREATE DEFINER=`root`@`localhost` FUNCTION `GENERO` (`iID` VARCHAR(50) CHARSET utf8mb4) RETURNS INT(11)  RETURN IFNULL((SELECT genero FROM genero WHERE id = iID), CN("INDEFINIDO"))$$

CREATE DEFINER=`root`@`localhost` FUNCTION `ID` (`iID` VARCHAR(2) CHARSET utf8mb4) RETURNS VARCHAR(19) CHARSET utf8mb4 COLLATE utf8mb4_general_ci  BEGIN
	DECLARE FECHA DATETIME DEFAULT NOW();
	DECLARE ANIO VARCHAR(4) DEFAULT SUBSTRING(CONCAT("0000", YEAR(FECHA)), -4);
	DECLARE MES VARCHAR(2) DEFAULT SUBSTRING(CONCAT("00", MONTH(FECHA)), -2);
	DECLARE DIA VARCHAR(2) DEFAULT SUBSTRING(CONCAT("00", DAY(FECHA)), -2);
	DECLARE HORA VARCHAR(2) DEFAULT SUBSTRING(CONCAT("00", HOUR(FECHA)), -2);
	DECLARE MINUTO VARCHAR(2) DEFAULT SUBSTRING(CONCAT("00", MINUTE(FECHA)), -2);
	DECLARE SEGUNDO VARCHAR(2) DEFAULT SUBSTRING(CONCAT("00", SECOND(FECHA)), -2);
	DECLARE MILISEGUNDO VARCHAR(3) DEFAULT SUBSTRING(CONCAT("000", FLOOR(((RAND() * (999 - 1)) + 1))), -3);
    
    if iID = CC("NO_DEFINIDO") OR iID = "" THEN
    	SET iID = "ID";
    END IF;
    
    RETURN CONCAT(iID, ANIO, MES, DIA, HORA, MINUTO, SEGUNDO, MILISEGUNDO);
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `LOGIN` (`iID` VARCHAR(50) CHARSET utf8mb4) RETURNS VARCHAR(50) CHARSET utf8mb4 COLLATE utf8mb4_general_ci  RETURN IFNULL((SELECT login FROM login WHERE id = iID), CC("NO_DEFINIDO"))$$

CREATE DEFINER=`root`@`localhost` FUNCTION `NACIMIENTO` (`iID` VARCHAR(50) CHARSET utf8mb4) RETURNS VARCHAR(11) CHARSET utf8mb4 COLLATE utf8mb4_general_ci  RETURN IFNULL((SELECT nacimiento FROM nacimiento WHERE id = iID), CC("NO_DEFINIDO"))$$

CREATE DEFINER=`root`@`localhost` FUNCTION `NOMBRE` (`iID` VARCHAR(50) CHARSET utf8mb4) RETURNS VARCHAR(250) CHARSET utf8mb4 COLLATE utf8mb4_general_ci  RETURN IFNULL((SELECT nombre FROM nombre WHERE id = iID), CC("NO_DEFINIDO"))$$

CREATE DEFINER=`root`@`localhost` FUNCTION `NOMBRECOMPLETO` (`iID` VARCHAR(50) CHARSET utf8mb4) RETURNS VARCHAR(1250) CHARSET utf8mb4 COLLATE utf8mb4_general_ci  BEGIN
	DECLARE NO_DEFINIDO VARCHAR(50) DEFAULT CC("NO_DEFINIDO");
	DECLARE nombre VARCHAR(250) DEFAULT NOMBRE(iID);
    DECLARE pApellido VARCHAR(250) DEFAULT PAPELLIDO(iID);
    DECLARE sApellido VARCHAR(250) DEFAULT SAPELLIDO(iID);
    
    IF pApellido <> NO_DEFINIDO THEN
    	SET nombre = CONCAT(nombre, " ", pApellido);
    END IF;

    IF sApellido <> NO_DEFINIDO THEN
    	SET nombre = CONCAT(nombre, " ", sApellido);
    END IF;

    RETURN nombre;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `PAPELLIDO` (`iID` VARCHAR(50) CHARSET utf8mb4) RETURNS VARCHAR(250) CHARSET utf8mb4 COLLATE utf8mb4_general_ci  RETURN IFNULL((SELECT pApellido FROM papellido WHERE id = iID), CC("NO_DEFINIDO"))$$

CREATE DEFINER=`root`@`localhost` FUNCTION `SAPELLIDO` (`iID` VARCHAR(50) CHARSET utf8mb4) RETURNS VARCHAR(250) CHARSET utf8mb4 COLLATE utf8mb4_general_ci  RETURN IFNULL((SELECT sapellido FROM sapellido WHERE id = iID), CC("NO_DEFINIDO"))$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `acceso`
--

CREATE TABLE `acceso` (
  `id` varchar(50) NOT NULL,
  `acceso` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `configuracion`
--

CREATE TABLE `configuracion` (
  `id` int(11) NOT NULL DEFAULT 1,
  `nombre` int(11) NOT NULL DEFAULT 1,
  `creacion` int(11) NOT NULL DEFAULT 1,
  `pApellido` int(11) NOT NULL DEFAULT 1,
  `sApellido` int(11) NOT NULL DEFAULT 1,
  `nacimiento` int(11) NOT NULL DEFAULT 1,
  `genero` int(11) NOT NULL DEFAULT 1,
  `login` int(11) NOT NULL DEFAULT 1,
  `pwd` int(11) NOT NULL DEFAULT 1,
  `acceso` int(11) NOT NULL DEFAULT 1,
  `foto` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `configuracion`
--

INSERT INTO `configuracion` (`id`, `nombre`, `creacion`, `pApellido`, `sApellido`, `nacimiento`, `genero`, `login`, `pwd`, `acceso`, `foto`) VALUES
(1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `constantes`
--

CREATE TABLE `constantes` (
  `constante` varchar(250) NOT NULL,
  `valor` varchar(250) NOT NULL,
  `numerica` int(11) NOT NULL DEFAULT 1,
  `descripcion` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `constantes`
--

INSERT INTO `constantes` (`constante`, `valor`, `numerica`, `descripcion`) VALUES
('ALTA_EXITOSA', '2', 1, 'Reporta un alta exitosa sobre una base de datos.'),
('ALTA_FALLIDA', '3', 1, 'Reporta un alta fallida sobre una base de datos.'),
('BAJA_EXITOSA', '4', 1, 'Reporta una baja exitosa sobre una base de datos.'),
('BAJA_FALLIDA', '5', 1, 'Reporta una baja fallida sobre una base de datos.'),
('CAMBIO_EXITOSO', '6', 1, 'Reporta un cambio exitoso sobre una base de datos.'),
('CAMBIO_FALLIDO', '7', 1, 'Reporta un cambio fallido sobre una base de datos.'),
('CAMPO_ACTIVO', '1', 1, 'Indica que el campo debe ser considerado en las consultas.'),
('CAMPO_INACTIVO', '0', 1, 'Indica que el campo no debe ser considerado en las consultas'),
('CONSULTA_EXITOSA', '1', 1, 'Reporta una consulta exitosa sobre una base de datos.'),
('CONSULTA_FALLIDA', '0', 1, 'Reporta una consulta sin resultados sobre una base de datos.'),
('FECHA_INDEFINIDA', '0000-00-00 00:00:00', 0, 'Indica que no se registró fecha'),
('INDEFINIDO', '-1', 1, 'Indica cualquier valor no definido de tipo numérico'),
('LOGIN_EXISTENTE', '9', 1, 'Indica que ya existe un usuario con el login indicado.'),
('NO_DEFINIDO', 'ND', 0, 'Representa cualquier valor no definido de tipo cadena de caracteres'),
('PAGINADOR', '2', 1, 'Indica el número de registros a recuperar por consulta.');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `foto`
--

CREATE TABLE `foto` (
  `id` varchar(50) NOT NULL,
  `foto` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `foto`
--

INSERT INTO `foto` (`id`, `foto`) VALUES
('ID20240627190250220', 'uygyuuygu'),
('ID20240627190455457', 'ihwid'),
('ID20240627193626252', 'dfd');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `genero`
--

CREATE TABLE `genero` (
  `id` varchar(50) NOT NULL,
  `genero` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `genero`
--

INSERT INTO `genero` (`id`, `genero`) VALUES
('ID20240311205621847', 1),
('ID20240311210443636', 1),
('ID20240311231906329', 1),
('ID20240312072915820', 1),
('ID20240312073316388', 1),
('ID20240627190250220', 0),
('ID20240627190455457', 0),
('ID20240627193626252', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `generos`
--

CREATE TABLE `generos` (
  `genero` int(11) NOT NULL,
  `Descripcion` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `generos`
--

INSERT INTO `generos` (`genero`, `Descripcion`) VALUES
(0, 'Femenino'),
(1, 'Masculino');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `login`
--

CREATE TABLE `login` (
  `id` varchar(50) NOT NULL,
  `login` varchar(50) NOT NULL,
  `pwd` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `login`
--

INSERT INTO `login` (`id`, `login`, `pwd`) VALUES
('ID20240311205621847', 'FIGJ701019HVZGRR00', 0x9e346ea5da219791c1d9289db4373d53),
('ID20240311210443636', 'FIGJ701019HVZGRR01', 0x7be6be7827e62927101aa85b5b77827c),
('ID20240311231906329', 'JPATINO2005', 0x2d825a7780416984b9ce0369673de181),
('ID20240312072915820', 'Jorge', 0x7be6be7827e62927101aa85b5b77827c),
('ID20240312073316388', 'JorgeM', 0x7be6be7827e62927101aa85b5b77827c),
('ID20240627190250220', 'daisy', 0x5123949ec19ac718a0958339957bc1f9),
('ID20240627190455457', 'pp', 0x5123949ec19ac718a0958339957bc1f9),
('ID20240627193626252', 'o', 0xe3f1d7320dc9ebabd5f9431841aa1c1a);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `nacimiento`
--

CREATE TABLE `nacimiento` (
  `id` varchar(50) NOT NULL,
  `nacimiento` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `nacimiento`
--

INSERT INTO `nacimiento` (`id`, `nacimiento`) VALUES
('ID20240311205621847', '1970-10-19'),
('ID20240311210443636', '1971-08-29'),
('ID20240311231906329', '1990-03-04'),
('ID20240312072915820', '1980-03-03'),
('ID20240312073316388', '1980-03-03'),
('ID20240627190250220', '2024-06-19'),
('ID20240627190455457', '2024-05-28'),
('ID20240627193626252', '2024-05-27');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `nombre`
--

CREATE TABLE `nombre` (
  `id` varchar(50) NOT NULL,
  `nombre` varchar(250) NOT NULL,
  `creacion` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `nombre`
--

INSERT INTO `nombre` (`id`, `nombre`, `creacion`) VALUES
('ID20240311205621847', 'Mario', '2024-03-11 20:56:21'),
('ID20240311210443636', 'Carlos', '2024-03-11 21:04:43'),
('ID20240311231906329', 'Mario', '2024-03-11 23:19:06'),
('ID20240312072915820', 'Jorge', '2024-03-12 07:29:15'),
('ID20240312073316388', 'Jorge Mario', '2024-03-12 07:33:16'),
('ID20240627190250220', 'Daisy', '2024-06-27 19:02:50'),
('ID20240627190455457', 'ihyu', '2024-06-27 19:04:55'),
('ID20240627193626252', 'o', '2024-06-27 19:36:26');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `papellido`
--

CREATE TABLE `papellido` (
  `id` varchar(50) NOT NULL,
  `pApellido` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `papellido`
--

INSERT INTO `papellido` (`id`, `pApellido`) VALUES
('ID20240311205621847', 'Figueroa'),
('ID20240311210443636', 'Figueroa'),
('ID20240311231906329', 'Figueroa'),
('ID20240312072915820', 'Figueroa'),
('ID20240312073316388', 'Figueroa'),
('ID20240627190250220', 'Diaz'),
('ID20240627190455457', 'hug'),
('ID20240627193626252', 'o');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sapellido`
--

CREATE TABLE `sapellido` (
  `id` varchar(50) NOT NULL,
  `sApellido` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `sapellido`
--

INSERT INTO `sapellido` (`id`, `sApellido`) VALUES
('ID20240311210443636', 'García'),
('ID20240627190250220', 'undefined'),
('ID20240627190455457', 'undefined'),
('ID20240627193626252', 'undefined');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `acceso`
--
ALTER TABLE `acceso`
  ADD UNIQUE KEY `acceso_indice` (`id`);

--
-- Indices de la tabla `configuracion`
--
ALTER TABLE `configuracion`
  ADD UNIQUE KEY `parametros_indece` (`id`);

--
-- Indices de la tabla `constantes`
--
ALTER TABLE `constantes`
  ADD UNIQUE KEY `constantes_indice` (`constante`);

--
-- Indices de la tabla `foto`
--
ALTER TABLE `foto`
  ADD UNIQUE KEY `foto_indice` (`id`);

--
-- Indices de la tabla `genero`
--
ALTER TABLE `genero`
  ADD KEY `genero_nombre` (`id`),
  ADD KEY `genero_generos` (`genero`);

--
-- Indices de la tabla `generos`
--
ALTER TABLE `generos`
  ADD UNIQUE KEY `generos_indice` (`genero`);

--
-- Indices de la tabla `login`
--
ALTER TABLE `login`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `nacimiento`
--
ALTER TABLE `nacimiento`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `nombre`
--
ALTER TABLE `nombre`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `papellido`
--
ALTER TABLE `papellido`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `sapellido`
--
ALTER TABLE `sapellido`
  ADD KEY `sApellidos_datosPersonales` (`id`);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `acceso`
--
ALTER TABLE `acceso`
  ADD CONSTRAINT `acceso_nombre` FOREIGN KEY (`id`) REFERENCES `nombre` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `foto`
--
ALTER TABLE `foto`
  ADD CONSTRAINT `foto_nombre` FOREIGN KEY (`id`) REFERENCES `nombre` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `genero`
--
ALTER TABLE `genero`
  ADD CONSTRAINT `genero_generos` FOREIGN KEY (`genero`) REFERENCES `generos` (`genero`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `genero_nombre` FOREIGN KEY (`id`) REFERENCES `nombre` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `login`
--
ALTER TABLE `login`
  ADD CONSTRAINT `login_nombre` FOREIGN KEY (`id`) REFERENCES `nombre` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `nacimiento`
--
ALTER TABLE `nacimiento`
  ADD CONSTRAINT `nacimiento_nombre` FOREIGN KEY (`id`) REFERENCES `nombre` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `papellido`
--
ALTER TABLE `papellido`
  ADD CONSTRAINT `papellido_nombre` FOREIGN KEY (`id`) REFERENCES `nombre` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `sapellido`
--
ALTER TABLE `sapellido`
  ADD CONSTRAINT `sapellido_nombre` FOREIGN KEY (`id`) REFERENCES `nombre` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
