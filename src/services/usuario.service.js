const pool = require('../config/db');
const bcrypt = require('bcrypt');

class UsuarioService {
  static async crearUsuario(usuario) {
    const { nombre_completo, identificacion, numero_celular, correo, contrasena, rol_id } = usuario;

    // Verificar si el usuario ya existe
    const [existe] = await pool.query('SELECT id_usuario FROM usuarios WHERE correo = ?', [correo]);
    if (existe.length > 0) {
      throw new Error('El usuario ya está registrado');
    }

    // Encriptar contrasena
    const hashedPassword = await bcrypt.hash(contrasena, 10);

    // Insertar usuario
    const [resultado] = await pool.query(
      'INSERT INTO usuarios (nombre_completo, identificacion, numero_celular, correo, contrasena, rol_id) VALUES (?, ?, ?, ?, ?, ?)',
      [nombre_completo, identificacion, numero_celular, correo, hashedPassword, rol_id]
    );

    return { id_usuario: resultado.insertId, ...usuario, contrasena: undefined };
  }

  static async autenticarUsuario(username, contrasena) {
    const [usuario] = await pool.query('SELECT U.id_usuario, U.nombre_completo, U.correo, U.contrasena, R.nombre AS rol FROM usuarios AS U JOIN roles AS R ON R.id_rol = U.rol_id AND U.correo = ?', [username]);
    
    if (usuario.length === 0) {
      throw new Error('Usuario no encontrado');
    }

    const valido = await bcrypt.compare(contrasena, usuario[0].contrasena);
    if (!valido) {
      throw new Error('contrasena incorrecta');
    }

    return { id_usuario: usuario[0].id_usuario, nombre_completo: usuario[0].nombre_completo, usuario: usuario[0].correo, rol: usuario[0].rol };
  }

  static async obtenerUsuarioPorId(id) {
    const [usuario] = await pool.query('SELECT U.id_usuario, U.nombre_completo, U.apellidos, U.correo, U.celular, U.usuario, U.fecha_creacion, U.fecha_actualizacion, U.id_rol, TU.rol FROM usuarios AS U INNER JOIN tipo_usuario AS TU ON TU.id_rol = U.id_rol WHERE id_usuario=?;', [id]);
    
    if (usuario.length === 0) {
      throw new Error('Usuario no encontrado');
    }
    
    return usuario[0];
  }

  static async obtenerUsuarios() {
    const [usuario] = await pool.query('SELECT U.id_usuario, U.correo, R.nombre FROM usuarios AS U JOIN roles AS R ON R.id_rol = U.rol_id');
    
    if (usuario.length === 0) {
      throw new Error('No existen Usuarios');
    }
    
    return usuario;
  }

  static async eliminarUsuario(id) {
    await pool.query('DELETE FROM usuarios WHERE id_usuario=?;', [id]);    
    return true;
  }
}

module.exports = UsuarioService;
