const UsuarioService = require('../services/usuario.service');

const crearUsuario = async (req, res) => {
  try {
    const usuario = await UsuarioService.crearUsuario(req.body);
    res.status(201).json({ mensaje: 'Usuario creado exitosamente', usuario });
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
};

const autenticarUsuario = async (req, res) => {
  try {
    const { usuario, contrasena } = req.body;
    const datos = await UsuarioService.autenticarUsuario(usuario, contrasena);
    res.status(200).json({ mensaje: 'Autenticación exitosa', usuario: datos });
  } catch (error) {
    res.status(401).json({ error: error.message });
  }
};

const obtenerUsuarioPorId = async (req, res) => {
  try {
    const { id } = req.params;
    const usuario = await UsuarioService.obtenerUsuarioPorId(id);
    res.status(200).json(usuario);
  } catch (error) {
    res.status(404).json({ error: error.message });
  }
};

const obtenerUsuarios = async (req, res) => {
  try {
    const usuarios = await UsuarioService.obtenerUsuarios();
    res.status(200).json(usuarios);
  } catch (error) {
    res.status(404).json({ error: error.message });
  }
};

const eleminarUsuario = async (req, res) => {
  try {
    const { id } = req.params;
    await UsuarioService.eliminarUsuario(id);
    res.status(200).json({ mensaje: 'Usuario eliminado exitosamente'});
  } catch (error) {
    res.status(404).json({ error: error.message });
  }
};


module.exports = {
  crearUsuario,
  autenticarUsuario,
  obtenerUsuarioPorId,
  obtenerUsuarios,
  eleminarUsuario
};
