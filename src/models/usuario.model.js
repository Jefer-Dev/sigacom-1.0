class Usuario {
  constructor(id, nombre_completo, identificacion, numero_celular, correo, contrasena, rol_id) {
    this.id_usuario = id;
    this.nombre_completo = nombre_completo;
    this.identificacion = identificacion;
    this.numero_celular = numero_celular;
    this.correo = correo;
    this.contrasena = contrasena;
    this.rol_id = rol_id;
  }
}

module.exports = Usuario;
