class Nave {
	
	var property velocidadXSeg
	var property distancia
	var property combustible
	
	method acelerar(cuanto) {velocidadXSeg +=cuanto.min(100000) }
	
	method desacelerar(cuanto) { velocidadXSeg -=cuanto.min(0) }
	
	method irHaciaElSol() { distancia = 10 }
	
	method escaparDelSol() { distancia = -10 }
	
	method ponerseParaleloAlSol() { distancia = 0 }
	
	method acercarseUnPocoAlSol() { distancia += 1 }
	
	method alejarseeUnPocoDelSol() { distancia -= 1 }
	
	method prepararViaje() { self.cargarCombustible(30000)
							 self.acelerar(5000)	
	}
	
	method cargarCombustible(litros) { combustible += litros }
	
	method descargarCombustible(litros) { combustible -= litros }
	
	method recibirAmenaza()
	
	method tranquilidad() = combustible > 4000 and velocidadXSeg < 12000
	
}

class NaveBaliza inherits Nave{
	
	var property color
	
	method cambiarColorDeBaliza(colorNuevo) { color = colorNuevo }
	
	override method prepararViaje() { super()
									  self.cambiarColorDeBaliza("verde")
									  self.ponerseParaleloAlSol()
	} 
	
	override method recibirAmenaza() {  self.irHaciaElSol() 
										self.cambiarColorDeBaliza("Rojo")
	}
	
	override method tranquilidad() = super() and  not color == "Rojo"
	
}

class NaveDePasajeros inherits Nave{
	
	var property racionesDeComida
	var property racionesDeBebidas
	var property pasajeros
	
	method agregarPasajeros(cuantos) { pasajeros += cuantos }
	
	method cargarComida(comida) { racionesDeComida += comida * pasajeros}
	
	method descargarComida(comida) { racionesDeComida -= comida * pasajeros }
	
	method cargarbebidas(bebidas) { racionesDeBebidas += bebidas * pasajeros}
	
	method descargarBebidas(bebidas) { racionesDeBebidas -= bebidas * pasajeros }
	
	override method prepararViaje() { super()
									  self.cargarComida(4)
									  self.cargarbebidas(6)
									  self.acercarseUnPocoAlSol()
	}
	
	override method recibirAmenaza() { self.acelerar(velocidadXSeg * 2)
									   self.descargarComida(1)
									   self.descargarBebidas(2)
	}
	
}

class NaveDeCobate inherits Nave{
	
	var property camuflage
	var property armamento
	var property mensajes = #{}
	
	method ponerseVisibles() { camuflage = false }
	method ponerseInvisible() { camuflage = true }
	method estaInvisible() = camuflage
	
	method desplagarMisiles() { armamento = true }
	method replagarMisiles() { armamento = false }
	method misilesDesplagados() = armamento
	
	method emitirMensaje(mensaje) { mensajes.add(mensaje) }
	method mensajesEmitidos() = mensajes
	method primerMensajeEmitido() = mensajes.first()
	method ultimoMensajeEmitido() = mensajes.last()
	
	override method prepararViaje() { super()
									  self.ponerseVisibles()
									  self.desplagarMisiles()
									  self.acelerar(15000)
									  self.emitirMensaje("Saliendo en mision")
	}
	
	override method recibirAmenaza() { self.escaparDelSol()
									   self.escaparDelSol()
									   self.emitirMensaje("Amenaza recibida")
	}
	
	override method tranquilidad() = super() and  armamento
	
}

class NaveHospital inherits NaveDePasajeros {
	
	var property quirofanoPreparado
	
	method prepararQuirofano(bool) { quirofanoPreparado = bool }
	
	override method recibirAmenaza() { super()
									   self.prepararQuirofano(true)
	}
	
	override method tranquilidad() = super() and quirofanoPreparado
	
}

class NaveDeCombateSigilosa inherits NaveDeCobate {
	
	override method recibirAmenaza() { super()
									   self.desplagarMisiles()
									   self.ponerseInvisible()
	}
	
	override method tranquilidad() = super() and camuflage
	
}



