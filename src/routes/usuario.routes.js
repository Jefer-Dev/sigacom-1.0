const express = require('express');
const router = express.Router();
const UsuarioController = require('../controllers/usuario.controller');

router.post('/registro', UsuarioController.crearUsuario);
router.post('/login', UsuarioController.autenticarUsuario);
router.get('/:id', UsuarioController.obtenerUsuarioPorId);
router.get('', UsuarioController.obtenerUsuarios);
router.delete('/:id', UsuarioController.eleminarUsuario);

module.exports = router;
